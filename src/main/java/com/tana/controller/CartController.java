package com.tana.controller;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tana.Repositories.OrderLineRepository;
import com.tana.Repositories.OrdersRepository;
import com.tana.Repositories.ProductRepository;
import com.tana.entities.Account;
import com.tana.entities.OrderLine;
import com.tana.entities.Orders;
import com.tana.entities.Payment;
import com.tana.entities.Product;
import com.tana.utilities.SessionUtility;
import com.tana.utilities.UserRole;
import com.tana.utilities.AlertMessage;
import com.tana.utilities.OrderStatusUtilities;

@Controller
public class CartController {

	private Logger LOGGER = Logger.getLogger(CartController.class);

	@Autowired
	private ProductRepository productManager;

	@Autowired
	private OrdersRepository ordersManager;

	@Autowired
	private OrderLineRepository orderLineManager;

	@ModelAttribute("account")
	public Account getAccount() {
		return new Account();
	}

	@RequestMapping(value = "/myCart")
	public String goToMyCart(HttpSession session, ModelMap model) {

		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.USER, account, successAlert);

		if (successAlert == generatedAlert) {
			Orders order = ordersManager.findCartByAccountId(account.getAccountId());
			if (order != null) {
				model.addAttribute("order", order);
				model.addAttribute("orderId", order.getOrderId());
				Orders confirmOrder = ordersManager.findByStatusAndAccountId(
						OrderStatusUtilities.PENDING_PAYMENT.getStatus(), account.getAccountId());
				model.addAttribute("haveConfirmOrder", (confirmOrder != null));
			}
			model.addAttribute("orderList", new Orders());
			return "MyCart";
		} else {
			model.addAttribute("alert",generatedAlert);
			return "index";
		}
	}

	@RequestMapping(value = "/confirmCart", method = RequestMethod.POST)
	public String confirmCart(@ModelAttribute Orders orders, HttpSession session, ModelMap model) {
		long orderId = orders.getOrderId();

		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.CONFIRM_CART_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.USER, account, successAlert);

		if (successAlert == generatedAlert) {
			for (OrderLine orderLine : orders.getListProduct()) {
				int amount = orderLine.getAmount();
				long productId = orderLine.getPk().getProduct().getProductId();

				orderLineManager.updateAmountByOrderIdAndProductId(amount, orderId, productId);
				LOGGER.info("Order " + orderId + " : Update amount to " + amount + " on product id " + productId);

				Product product = productManager.findProductByProductId(productId);
				product.setAmount(product.getAmount() - amount);
				productManager.save(product);
			}
			String status = OrderStatusUtilities.PENDING_PAYMENT.getStatus();
			ordersManager.updateOrderStatusByOrderId(orderId, status);
			LOGGER.info("Order ID {" + orderId + "} to " + status);
			model.addAttribute("payment", new Payment());
			model.addAttribute("alert",generatedAlert);
			return "ConfirmPayment";
		}
		model.addAttribute("alert",generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/RemoveOutOfCart/{productId}", method = RequestMethod.GET)
	public String doRemoveOutOfCart(@PathVariable("productId") int productId, HttpSession session, ModelMap model) {
		LOGGER.info("Product id '" + productId + "' has requested to add to my cart");
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.REMOVE_PRODUCT_OUTOFCART_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.USER, account, successAlert);

		if (successAlert == generatedAlert) {
			Orders orders = ordersManager.findCartByAccountId(account.getAccountId());
			ordersManager.removeOrderByOrderIdAndProductId(orders.getOrderId(), productId);
			model.addAttribute("alert",generatedAlert);
			return "../myCart";
		}
		model.addAttribute("alert",generatedAlert);
		return "../index";
	}

	@RequestMapping(value = "/addToCart/{productId}", method = RequestMethod.GET)
	public String doAddToCart(@PathVariable("productId") int productId, HttpSession session, ModelMap model) {
		LOGGER.info("Product id '" + productId + "' has requested to add to my cart");
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.ADD_PRODUCT_TOCART_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.USER, account, successAlert);

		if (successAlert == generatedAlert) {
			Orders orders = ordersManager.findCartByAccountId(account.getAccountId());
			Product product = productManager.findOne(((Integer) productId).longValue());
			OrderLine orderLine = null;
			if (orders == null) {
				LOGGER.info("New Cart");
				orders = new Orders();
				orders.setStatus(OrderStatusUtilities.CART.getStatus());
				orders.setCustomer(account);
				orders.setDatetime(new Date());
				ordersManager.save(orders);
				LOGGER.info("My cart '" + orders.getOrderId() + "'");
			}

			orderLine = new OrderLine();
			orderLine.getPk().setProduct(product);
			orderLine.getPk().setOrders(orders);
			orderLine.setAmount(0);
			LOGGER.info("\tAdd Product :  '" + product.getProductName() + "'");
			orderLineManager.save(orderLine);

			model.addAttribute("orderList", orderLine);
			model.addAttribute("alert",generatedAlert);
			return "../listProduct";
		}
		model.addAttribute("alert",generatedAlert);
		return "../index";
	}
}
