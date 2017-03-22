package com.tana.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.tana.entities.Account;

@Controller
public class IndexController {
	
	private Logger LOGGER = Logger.getLogger(IndexController.class);
	
	@GetMapping("/")
	public String start(Model model) {
		LOGGER.info("Redirect to index page");
		model.addAttribute("account",new Account());
		return "index";
	}
	
	@GetMapping("/index")
	public String index(Model model) {
		LOGGER.info("Redirect to index page");
		model.addAttribute("account",new Account());
		return "index";
	}
}
