package com.tana.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tana.Repositories.AccountRepository;
import com.tana.entities.Account;

@Controller
public class RegisterController {
	
	private Logger LOGGER = Logger.getLogger(RegisterController.class);
	
	@Autowired
	private AccountRepository accountRepository;
	
	@ModelAttribute("account")
	public Account getAccount(){
		return new Account();
	}
	
	@GetMapping("/regis")
	public String goToResult(Model model) {
		LOGGER.info("Redirect to result page");
		return "Register";
	}
	

	@RequestMapping(value = "/addRegister", method = RequestMethod.POST)
	public String addRegister(@ModelAttribute("SpringWeb") Account account,ModelMap model) {
		LOGGER.info("Username : "+account.getUsername());
		accountRepository.save(account);
		return "index";
	}
}
