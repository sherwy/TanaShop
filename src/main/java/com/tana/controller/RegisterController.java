package com.tana.controller;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tana.entities.Account;
import com.tana.utilities.AlertMessage;
import com.tana.utilities.FolderUtilities;
import com.tana.utilities.SessionUtility;
import com.tana.utilities.UserRole;
import com.tana.utilities.VariableUtility;

@Controller
public class RegisterController extends HeaderController {

	private Logger LOGGER = Logger.getLogger(RegisterController.class);

	@GetMapping("/regis")
	public String goToResult(HttpSession session, Model model) {
		LOGGER.info("Redirect to result page");
		Account account = SessionUtility.getAccount(session);
		if (account != null) {
			model.addAttribute("alert", AlertMessage.REQUIRED_LOGOUT);
			return "index";
		}
		model.addAttribute("account1", new Account());
		return "Register";
	}

	@RequestMapping(value = "/addRegister", method = RequestMethod.POST)
	public String addRegister(@ModelAttribute("SpringWeb") Account accountForm,
			@RequestParam("file") MultipartFile file, HttpSession session, ModelMap model) {

		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.REGISTER_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(accountForm, successAlert);
		if (account == null) {
			if (successAlert == generatedAlert) {
				Account accountReturned = null;
				try {
					accountForm.setRole(UserRole.USER.getRole());
					accountReturned = accountRepository.save(accountForm);

					String url = FolderUtilities.uploadFile(file,
							VariableUtility.getUserPathFile(accountReturned.getUsername()),
							accountReturned.getUsername());

					accountReturned.setImgUrl(url);
					accountRepository.save(accountReturned);
				} catch (Exception e) {
					LOGGER.info(e.getMessage());
					if (accountReturned != null)
						accountRepository.delete(accountReturned);
					model.addAttribute("account1", accountForm);
					model.addAttribute("alert", AlertMessage.REGISTER_FAIL);
					return "Register";
				}
			}
		} else {
			generatedAlert = AlertMessage.REQUIRED_LOGOUT;
		}
		model.addAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/editProfile", method = RequestMethod.GET)
	public String editProfile(HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.USER, account, successAlert);
		if (successAlert == generatedAlert) {
			Account profile = accountRepository.findByUsername(account.getUsername());
			model.addAttribute("profile", profile);
			return "EditProfile";
		}
		model.addAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/editProfile", method = RequestMethod.POST)
	public String editProfile(@ModelAttribute Account accountForm, @RequestParam("newpassword") String newPass,
			@RequestParam("file") MultipartFile file, HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.EDIT_PROFILE_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.USER, account, successAlert);
		Account returnedAccount = null;
		try {
			if (successAlert == generatedAlert) {
				if (!account.getPassword().equals(accountForm.getPassword())){
					generatedAlert = AlertMessage.EDIT_PROFILE_INVALID_PASSWORD;
					
				}else {
					if (!"".equals(newPass))
						accountForm.setPassword(newPass);
					LOGGER.info((file!=null));
					
					if (file != null && !"".equals(file.getOriginalFilename())) {
						String url = FolderUtilities.uploadFile(file,
								VariableUtility.getUserPathFile(accountForm.getUsername()), accountForm.getUsername());
						accountForm.setImgUrl(url);
					}else{
						accountForm.setImgUrl(account.getImgUrl());
					}
					accountForm.setRole(UserRole.USER.getRole());
					accountForm.setAccountId(account.getAccountId());
					returnedAccount = accountRepository.save(accountForm);
				}
			}
		} catch (Exception e) {
			LOGGER.info("Error " + e.getMessage());
			generatedAlert = AlertMessage.GENERAL_ERROR;
		}
		model.addAttribute("alert", generatedAlert);
		if(returnedAccount != null){
			model.addAttribute("profile", returnedAccount);
			session.setAttribute("user", returnedAccount);
		}else
			model.addAttribute("profile", accountForm);
		return "EditProfile";
	}
}
