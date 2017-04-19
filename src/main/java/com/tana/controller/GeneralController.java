package com.tana.controller;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
public class GeneralController extends HeaderController{
	
	@RequestMapping(value = "/howTo", method = RequestMethod.GET)
	public String doAddCategory(HttpSession session, Model model) {
		return "HowTo";
	}
	
}
