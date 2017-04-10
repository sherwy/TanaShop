package com.tana.controller;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tana.Repositories.AccountRepository;
import com.tana.entities.Account;
import com.tana.utilities.SessionUtility;

@Controller
public class GeneralDetailController {
	private Logger LOGGER = Logger.getLogger(GeneralDetailController.class);
	
	@Autowired
	AccountRepository accountRepository;
	
	@RequestMapping(value="/editGeneralDetail",method=RequestMethod.GET)
	public String editGeneralDetail(HttpSession session,Model model){
		Account account = SessionUtility.getAccount(session);
		if (account != null) {
			return "EditGeneralDetail";
		}
		return "index";
	}
}
