package com.tana.controller;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tana.Repositories.BankAccountRepository;
import com.tana.Repositories.ContactRepository;
import com.tana.entities.Account;
import com.tana.entities.ContactMessage;
import com.tana.utilities.AlertMessage;
import com.tana.utilities.SessionUtility;
import com.tana.utilities.UserRole;

@Controller
public class GeneralController extends HeaderController {

	@Autowired
	BankAccountRepository bankManager;

	@Autowired
	ContactRepository contactManager;
	
	@RequestMapping(value = "/howTo", method = RequestMethod.GET)
	public String howTo(HttpSession session, Model model) {
		model.addAttribute("listBank", bankManager.findAll());
		return "HowTo";
	}

	@RequestMapping(value = "/aboutUs", method = RequestMethod.GET)
	public String aboutUs(HttpSession session, Model model) {
		return "AboutUs";
	}

	@RequestMapping(value = "/contactUs", method = RequestMethod.GET)
	public String contactUs(HttpSession session, Model model) {

		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.USER, account, successAlert);

		if (successAlert == generatedAlert) {
			List<ContactMessage> listMsg = contactManager.findMsgByAccountId(account.getAccountId());
			model.addAttribute("listMsg",listMsg);
			model.addAttribute("contact", new ContactMessage());
			return "ContactUs";
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}
	
	@RequestMapping(value = "/contactUs", method = RequestMethod.POST)
	public String contactUs(@ModelAttribute ContactMessage contact,HttpServletRequest request,HttpSession session, Model model) {

		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.SEND_CONTACT_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.USER, account, successAlert);

		if (successAlert == generatedAlert) {
			contact.setDatetime(new Timestamp(System.currentTimeMillis()));
			contact.setMsgOwner(account);
			contactManager.save(contact);
			session.setAttribute("alert", generatedAlert);
			return "redirect:"+SessionUtility.getPreviousPage(request);
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}


}
