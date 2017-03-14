package com.tana.controller;


import javax.servlet.http.HttpSession;

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
public class TestController {
	
	@Autowired
	private AccountRepository accountRepository;
	
	private Logger LOGGER = Logger.getLogger(TestController.class);
	
	@ModelAttribute("account")
	public Account getAccount(){
		return new Account();
	}
	
	@GetMapping("/")
	public String index(Model model) {
		LOGGER.info("Redirect to index page");
		return "index";
	}

	@GetMapping("/regis")
	public String goToResult(Model model) {
		LOGGER.info("Redirect to result page");
		return "Register";
	}
	
	@GetMapping("/login")
	public String goToLogin(Model model) {
		LOGGER.info("Redirect to login page");
		return "Login";
	}

	@RequestMapping(value = "/addRegister", method = RequestMethod.POST)
	public String addRegister(@ModelAttribute("SpringWeb") Account account,ModelMap model) {
		LOGGER.info("Username : "+account.getUsername());
		accountRepository.save(account);
		return "index";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String doLogin(@ModelAttribute("SpringWeb") Account accountLogin,HttpSession session,ModelMap model) {
		Account account = accountRepository.findByUsername(accountLogin.getUsername());
		if(account != null){
			if(account.getPassword().equals(accountLogin.getPassword())){
				LOGGER.info("Logging in as '"+account.getUsername()+"' successfully");
				session.setAttribute("user", account);
				return "index";
			}
		}
		return "Login";
	}
	
	@RequestMapping(value = "/logout")
	public String doLogout(HttpSession session,ModelMap model) {
		session.removeAttribute("user");
		return "index";
	}

}
