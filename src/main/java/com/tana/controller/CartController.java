package com.tana.controller;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tana.Repositories.OrderLineRepository;
import com.tana.Repositories.OrdersRepository;
import com.tana.entities.Account;
import com.tana.entities.OrderLine;
import com.tana.entities.Orders;
import com.tana.utilities.OrderStatus;
import com.tana.utilities.SessionUtility;

@Controller
public class CartController {

	private Logger LOGGER = Logger.getLogger(CartController.class);

	@Autowired
	private OrdersRepository ordersManager;

	@Autowired
	private OrderLineRepository orderLineManager;

	@RequestMapping(value = "/myCart")
	public String goToMyCart(HttpSession session, ModelMap model) {

		Account account = SessionUtility.getAccount(session);

		if (account != null) {

			Orders order = ordersManager.findCartByAccountId(account.getAccountId());

			model.addAttribute("order", order);
			model.addAttribute("orderId", order.getOrderId());
			model.addAttribute("orderList", new Orders());
			return "MyCart";
		} else {
			return "index";
		}

	}

	@RequestMapping(value = "/confirmCart", method = RequestMethod.POST)
	public String confirmCart(@ModelAttribute Orders orders, HttpSession session, ModelMap model) {
		long orderId = orders.getOrderId();

		Account account = SessionUtility.getAccount(session);

		if (account != null) {
			for (OrderLine orderLine : orders.getListProduct()) {
				int amount = orderLine.getAmount();
				long productId = orderLine.getPk().getProduct().getProductId();

				orderLineManager.updateAmountByOrderIdAndProductId(amount, orderId, productId);
				LOGGER.info("Order " + orderId + " : Update amount to " + amount + " on product id " + productId);
				
				String statusString = OrderStatus.ORDER_PENDING_PAYMENT.getStatus();
				ordersManager.updateOrderStatusByOrderId(orderId,statusString);
				LOGGER.info("Order ID : "+orderId+" to " + statusString);
			}
		}
		return "redirect:index";

	}
}
