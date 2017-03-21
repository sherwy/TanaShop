package com.tana.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tana.Repositories.OrdersRepository;
import com.tana.entities.Account;
import com.tana.entities.Orders;
import com.tana.utilities.OrderStatus;
import com.tana.utilities.SessionUtility;

@Controller
public class AdminController {
	
	private Logger LOGGER = Logger.getLogger(AdminController.class);
	
	@Autowired
	private OrdersRepository ordersManager;
	
	@RequestMapping("/listAllOrder")
	public String listAllOrder(HttpSession session,Model model){
		Account account = SessionUtility.getAccount(session);

		if (account != null) {

			List<Orders> listOrder = ordersManager.findOrderByOrderStatusOnExcept(OrderStatus.ORDER_CART.getStatus());
			model.addAttribute("listOrder",listOrder);
			return "ListOrder";
		} else {
			return "redirect:index";
		}

	}

}
