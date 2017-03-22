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
public class LoginController {

	private Logger LOGGER = Logger.getLogger(LoginController.class);

	@Autowired
	private AccountRepository accountRepository;

	@ModelAttribute("account")
	public Account getAccount() {
		return new Account();
	}

	@GetMapping("/login")
	public String goToLogin(Model model) {
		LOGGER.info("Redirect to login page");
		model.addAttribute("user", new Account());
		return "redirect:index";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String doLogin(@ModelAttribute("SpringWeb") Account accountLogin, HttpSession session, ModelMap model) {
		Account account = accountRepository.findByUsername(accountLogin.getUsername());
		if (account != null) {
			if (account.getPassword().equals(accountLogin.getPassword())) {
				LOGGER.info("Logging in as '" + account.getUsername() + "' successfully");
				session.setAttribute("user", account);
				return "redirect:index";
			}
		}
		return "redirect:index";
	}

	@RequestMapping(value = "/logout")
	public String doLogout(HttpSession session, ModelMap model) {
		session.removeAttribute("user");
		return "redirect:index";
	}

}
