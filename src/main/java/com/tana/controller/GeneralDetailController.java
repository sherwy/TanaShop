package com.tana.controller;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tana.Repositories.AccountRepository;
import com.tana.Repositories.GeneralDetailRepository;
import com.tana.entities.Account;
import com.tana.entities.AlertMessage;
import com.tana.entities.GeneralDetail;
import com.tana.utilities.SessionUtility;

@Controller
public class GeneralDetailController {
	private Logger LOGGER = Logger.getLogger(GeneralDetailController.class);
	
	@Autowired
	AccountRepository accountRepository;
	
	@Autowired
	GeneralDetailRepository generalDetailManager;
	
	@RequestMapping(value="/editGeneralDetail",method=RequestMethod.GET)
	public String editGeneralDetail(HttpSession session,Model model){
		Account account = SessionUtility.getAccount(session);
		if (account != null) {
			GeneralDetail generalDetail = generalDetailManager.getLastest();
			if(generalDetail != null){
				model.addAttribute("detail",generalDetail);
			}
			model.addAttribute("generalDetail",new GeneralDetail());
			return "EditGeneralDetail";
		}
		return "index";
	}
	
	@RequestMapping(value="/editGeneralDetail",method=RequestMethod.POST)
	public String editGeneralDetail(@ModelAttribute GeneralDetail generalDetail ,HttpSession session,Model model){
		Account account = SessionUtility.getAccount(session);
		if (account != null) {
			generalDetailManager.save(generalDetail);
		}
		AlertMessage success = new AlertMessage();
		return "index";
	}
}
