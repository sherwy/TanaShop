package com.tana.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.tana.entities.Account;

@Controller
public class IndexController {

	private Logger LOGGER = Logger.getLogger(IndexController.class);

	@ModelAttribute("account")
	public Account getAccount(){
		return new Account();
	}
	
	@GetMapping("/")
	public String start(Model model) {
		LOGGER.info("Redirect to index page");
		return "index";
	}

	@GetMapping("/index")
	public String index(Model model) {
		LOGGER.info("Redirect to index page");
		return "index";
	}
}
