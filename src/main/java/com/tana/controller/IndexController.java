package com.tana.controller;


import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.tana.Repositories.OrdersRepository;
import com.tana.entities.Account;
import com.tana.entities.OrderLine;
import com.tana.entities.Orders;
import com.tana.entities.Product;
import com.tana.utilities.ProductStatusUtilities;
import com.tana.utilities.SessionUtility;


@Controller
public class IndexController extends HeaderController{

	private Logger LOGGER = Logger.getLogger(IndexController.class);
	
	@Autowired
	private OrdersRepository ordersManager;
	
	@GetMapping("/")
	public String start(HttpSession session,Model model) {
		LOGGER.info("Redirect to index page");
		return "index";
	}

	@GetMapping("/index")
	public String index(HttpSession session,Model model) {
		LOGGER.info("Redirect to index page");
		return "index";
	}
}
