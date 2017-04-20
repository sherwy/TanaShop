package com.tana.controller;

import java.util.Date;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tana.Repositories.ConfigWebRepository;
import com.tana.Repositories.GeneralDetailRepository;
import com.tana.Repositories.WelcomeDetailRepository;
import com.tana.entities.Account;
import com.tana.entities.ConfigWeb;
import com.tana.entities.GeneralDetail;
import com.tana.entities.WelcomeDetail;
import com.tana.utilities.AlertMessage;
import com.tana.utilities.FolderUtilities;
import com.tana.utilities.SessionUtility;
import com.tana.utilities.UserRole;
import com.tana.utilities.VariableUtility;

@Controller
public class GeneralDetailController extends HeaderController {

	@Autowired
	GeneralDetailRepository generalDetailManager;

	@Autowired
	WelcomeDetailRepository welcomeManager;

	@Autowired
	ConfigWebRepository configManager;

	@RequestMapping(value = "/editGeneralDetail", method = RequestMethod.GET)
	public String editGeneralDetail(HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			GeneralDetail generalDetail = generalDetailManager.getLastest();
			if (generalDetail != null) {
				model.addAttribute("detail", generalDetail);
			}
			model.addAttribute("generalDetail", new GeneralDetail());
			return "EditGeneralDetail";
		}
		model.addAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/editGeneralDetail", method = RequestMethod.POST)
	public String editGeneralDetail(@ModelAttribute GeneralDetail generalDetail,
			@RequestParam("file") MultipartFile file, HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.EDIT_GENERAL_DETAIL_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			generalDetail.setDateChanged(new Date());
			String url = FolderUtilities.uploadFile(file, VariableUtility.getAboutUsPathFile(), "aboutus");
			generalDetail.setImgUrl(url);
			generalDetailManager.save(generalDetail);
		}
		model.addAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/welcomeDetail", method = RequestMethod.GET)
	public String editWelcomeDetail(HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			WelcomeDetail welcome = welcomeManager.getLastest();
			if (welcome != null) {
				model.addAttribute("welcome", welcome);
			}
			model.addAttribute("welcomeDetail", new WelcomeDetail());
			return "WelcomeDetail";
		}
		model.addAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/welcomeDetail", method = RequestMethod.POST)
	public String editWelcomeDetail(@ModelAttribute WelcomeDetail welcomeDetail,
			@RequestParam("welcomeDetailText") String welcomeString, HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.EDIT_WELCOME_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			welcomeDetail.setWelcomeText(welcomeString);
			welcomeManager.save(welcomeDetail);
		}

		model.addAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/configWeb", method = RequestMethod.GET)
	public String configWeb(HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			model.addAttribute("configWeb", new ConfigWeb());
			return "ConfigWeb";
		}
		model.addAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value="/configWeb",method=RequestMethod.POST)
	public String configWeb(@ModelAttribute ConfigWeb configs,HttpSession session,Model model,@RequestParam("fileBN") MultipartFile fileBN,@RequestParam("fileBG") MultipartFile fileBG){
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);
		
		if(successAlert == generatedAlert){
			
			String urlBN = FolderUtilities.uploadFile(fileBN,VariableUtility.getBannerPathFile(), "banner");
			String urlBG = FolderUtilities.uploadFile(fileBG,VariableUtility.getBackgroundPathFile(), "bg");
			configs.setBannerImg(urlBN);
			configs.setBgImg(urlBG);
			configManager.save(configs);
		}
		model.addAttribute("alert",generatedAlert);
		return "index";
	}
	
}
