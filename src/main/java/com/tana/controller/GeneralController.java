package com.tana.controller;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tana.entities.Account;


@Controller
public class GeneralController {
	
	@ModelAttribute("account")
	public Account getAccount(){
		return new Account();
	}
	
	@RequestMapping(value = "/howTo", method = RequestMethod.GET)
	public String doAddCategory(HttpSession session, Model model) {
		return "HowTo";
	}
	
}
