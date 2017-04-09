package com.tana.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tana.Repositories.AccountRepository;
import com.tana.entities.Account;
import com.tana.entities.ErrorMessage;
import com.tana.utilities.DateUtilities;
import com.tana.utilities.FolderUtilities;
import com.tana.utilities.IconUtility;
import com.tana.utilities.UserRole;
import com.tana.utilities.VariableUtility;

@Controller
public class RegisterController {

	private Logger LOGGER = Logger.getLogger(RegisterController.class);

	@Autowired
	private AccountRepository accountRepository;

	@ModelAttribute("account")
	public Account getAccount() {
		return new Account();
	}

	@GetMapping("/regis")
	public String goToResult(Model model) {
		LOGGER.info("Redirect to result page");
		model.addAttribute("account1",new Account());
		return "Register";
	}

	@RequestMapping(value = "/addRegister", method = RequestMethod.POST)
	public String addRegister(@ModelAttribute("SpringWeb") Account account, @RequestParam("file") MultipartFile file,
			@RequestParam("date") String dateString, ModelMap model) {
		LOGGER.info("Username : " + account.getUsername());

		if (file.isEmpty()) {
			LOGGER.info("File is empty");
			return "redirect:index";
		}
		Date date = DateUtilities.convertStringToDateWithFormat(dateString, "yyyy-MM-dd");
		account.setBirthDate(date);
		account.setRole(UserRole.USER.getRole());
		Account accountReturned = accountRepository.save(account);

		String fileName = null;
		try {
			String filePath = VariableUtility.getUserPathFile(accountReturned.getUsername());
			FolderUtilities.createFolderIfNotExist(filePath);
			// Get the file and save it somewhere
			if(file.getSize() >= 1048576){
				ErrorMessage error = new ErrorMessage(IconUtility.DANGER.getIcon(),IconUtility.DANGER.getStatus(),"ผิดพลาด","ไม่สามารถอัพโหลดรุปได้ กรุณาลองใหม่อีกครั้ง");
				model.addAttribute("errorMsg",error);
				return "redirect:index";
			}
			byte[] bytes = file.getBytes();
			fileName = account.getUsername() + "_" + file.getOriginalFilename();
			LOGGER.info("File name : " + fileName);
			Path path = Paths.get(filePath + fileName);
			LOGGER.info("Path : " + filePath + fileName);
			Files.write(path, bytes);
		} catch (IOException e) {
			e.printStackTrace();
		}

		accountReturned.setImgUrl(fileName);
		accountRepository.save(accountReturned);
		return "index";
	}
}
