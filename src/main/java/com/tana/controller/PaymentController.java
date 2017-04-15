package com.tana.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tana.Repositories.OrdersRepository;
import com.tana.Repositories.PaymentRepository;
import com.tana.entities.Account;
import com.tana.entities.Orders;
import com.tana.entities.Payment;
import com.tana.utilities.AlertMessage;
import com.tana.utilities.DateUtilities;
import com.tana.utilities.FolderUtilities;
import com.tana.utilities.OrderStatusUtilities;
import com.tana.utilities.SessionUtility;
import com.tana.utilities.UserRole;
import com.tana.utilities.VariableUtility;

@Controller
public class PaymentController {

	private Logger LOGGER = Logger.getLogger(PaymentController.class);

	@Autowired
	private PaymentRepository paymentManager;

	@Autowired
	private OrdersRepository ordersManager;

	@ModelAttribute("account")
	public Account getAccount() {
		return new Account();
	}

	@RequestMapping(value = "/confirmPayment", method = RequestMethod.POST)
	public String confirmCart(@ModelAttribute("payment") Payment payment, @RequestParam("date") String dateString,
			@RequestParam("file") MultipartFile file, HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.CONFIRM_PAYMENT_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.USER, account, successAlert);

		if (successAlert == generatedAlert) {
			Orders order = ordersManager.findByStatusAndAccountId(OrderStatusUtilities.PENDING_PAYMENT.getStatus(),
					account.getAccountId());
			long orderId = order.getOrderId();
			LOGGER.info("Found order id : " + order.getOrderId());

			String fileName = null;

			FolderUtilities.createFolderIfNotExist(VariableUtility.IMG_PATH_PAYMENT);

			try {
				byte[] bytes = file.getBytes();
				fileName = orderId + "_" + payment.getId() + "_" + file.getOriginalFilename();
				LOGGER.info("File name : " + fileName);
				Path path = Paths.get(VariableUtility.IMG_PATH_PAYMENT + fileName);
				Files.write(path, bytes);
			} catch (IOException e) {
				e.printStackTrace();
			}
			Date date = DateUtilities.convertStringToDateWithFormat(dateString, "yyyy-MM-dd");
			payment.setImgUrl(fileName);
			payment.setPaymentDate(date);
			paymentManager.save(payment);
			LOGGER.info("Payment saved : OrderID {" + orderId + "}  ,   Payment {" + payment.getId() + "}");

			order.setPayment(payment);
			order.setStatus(OrderStatusUtilities.PENDING_VERIFICATION.getStatus());
			ordersManager.save(order);
			LOGGER.info("OrderID {" + orderId + "} updated status to : " + order.getStatus());
		}
		model.addAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/confirmPayment", method = RequestMethod.GET)
	public String confirmCart(HttpSession session, ModelMap model) {

		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.USER, account, successAlert);

		if (successAlert == generatedAlert) {
			Orders order = ordersManager.findByStatusAndAccountId(OrderStatusUtilities.PENDING_PAYMENT.getStatus(),
					account.getAccountId());
			if (order != null) {
				model.addAttribute("date", new Date());
				model.addAttribute("payment", new Payment());
				model.addAttribute("orderId", order.getOrderId());
				return "ConfirmPayment";
			} else {
				AlertMessage alert = AlertMessage.NO_PAYMENT_ORDER_WARNING;
				model.addAttribute("alert", alert);
				return "index";
			}
		}else{
			model.addAttribute("alert",generatedAlert);
		}
		return "index";
	}

}