package com.tana.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tana.Repositories.BankAccountRepository;



@Controller
public class GeneralController extends HeaderController{
	
	
	@Autowired
	BankAccountRepository bankManager;
	
	@RequestMapping(value = "/howTo", method = RequestMethod.GET)
	public String howTo(HttpSession session, Model model) {
		model.addAttribute("listBank",bankManager.findAll());
		return "HowTo";
	}
	
	@RequestMapping(value = "/aboutUs", method = RequestMethod.GET)
	public String aboutUs(HttpSession session, Model model) {
		return "AboutUs";
	}
	
}
