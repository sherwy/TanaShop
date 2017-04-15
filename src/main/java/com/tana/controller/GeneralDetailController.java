package com.tana.controller;

import java.util.Date;

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
import com.tana.Repositories.WelcomeDetailRepository;
import com.tana.entities.Account;
import com.tana.entities.GeneralDetail;
import com.tana.entities.WelcomeDetail;
import com.tana.utilities.AlertMessage;
import com.tana.utilities.SessionUtility;
import com.tana.utilities.UserRole;

@Controller
public class GeneralDetailController {
	private Logger LOGGER = Logger.getLogger(GeneralDetailController.class);
	
	@Autowired
	AccountRepository accountRepository;
	
	@Autowired
	GeneralDetailRepository generalDetailManager;
	
	@Autowired
	WelcomeDetailRepository welcomeManager;
	
	@ModelAttribute("account")
	public Account getAccount(){
		return new Account();
	}
	
	@RequestMapping(value="/editGeneralDetail",method=RequestMethod.GET)
	public String editGeneralDetail(HttpSession session,Model model){ 
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);
		
		if(successAlert == generatedAlert){
			GeneralDetail generalDetail = generalDetailManager.getLastest();
			if(generalDetail != null){
				model.addAttribute("detail",generalDetail);
			}
			model.addAttribute("generalDetail",new GeneralDetail());
			return "EditGeneralDetail";
		}
		model.addAttribute("alert",generatedAlert);
		return "index";
	}
	
	@RequestMapping(value="/editGeneralDetail",method=RequestMethod.POST)
	public String editGeneralDetail(@ModelAttribute GeneralDetail generalDetail ,HttpSession session,Model model){
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.EDIT_GENERAL_DETAIL_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);
		
		if(successAlert == generatedAlert){
			generalDetail.setDateChanged(new Date());
			generalDetailManager.save(generalDetail);
		}
		model.addAttribute("alert",generatedAlert);
		return "index";
	}
	
	@RequestMapping(value="/welcomeDetail",method=RequestMethod.GET)
	public String editWelcomeDetail(HttpSession session,Model model){
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);
		
		if(successAlert == generatedAlert){
			WelcomeDetail welcome = welcomeManager.getLastest();
			if(welcome != null){
				model.addAttribute("welcome",welcome);
			}
			model.addAttribute("welcomeDetail",new GeneralDetail());
			return "WelcomeDetail";
		}
		model.addAttribute("alert",generatedAlert);
		return "index";
	}
	@RequestMapping(value="/welcomeDetail",method=RequestMethod.POST)
	public String editWelcomeDetail(@ModelAttribute WelcomeDetail welcomeDetail,@RequestParam("welcomeDetailText") String welcomeString ,HttpSession session,Model model){
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.EDIT_WELCOME_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);
		
		if(successAlert == generatedAlert){
			welcomeDetail.setWelcomeText(welcomeString);
			welcomeManager.save(welcomeDetail);
		}
		
		model.addAttribute("alert",generatedAlert);
		return "index";
	}
}
