package com.tana.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tana.Repositories.OrdersRepository;
import com.tana.entities.Orders;

@RestController
public class TestJson {
	
	@Autowired
	private OrdersRepository ordersManager;
	
	@RequestMapping(value="/testJson")
	public Orders goToMyCart(HttpSession session,ModelMap model){
		
			Orders orders = ordersManager.findCartByAccountId(1);
			System.out.println(orders.getOrderId());
			return orders;
		
		
	}
}
