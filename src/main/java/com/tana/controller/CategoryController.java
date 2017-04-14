package com.tana.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tana.Repositories.CategoryRepository;
import com.tana.entities.Account;
import com.tana.entities.OrderCategory;
import com.tana.utilities.SessionUtility;

@Controller
public class CategoryController {
	private Logger LOGGER = Logger.getLogger(CategoryController.class);

	@Autowired
	private CategoryRepository categoryManager;

	@ModelAttribute("account")
	public Account getAccount(){
		return new Account();
	}
	
	@RequestMapping(value = "/addCategory", method = RequestMethod.GET)
	public String doAddCategory(HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);
		if (account != null) {
			List<OrderCategory> listCategory = categoryManager.findParentCategory();
			model.addAttribute("listCategory", listCategory);
			model.addAttribute("category", new OrderCategory());
			return "AddCategory";
		} else {
			return "redirect:index";
		}
	}

	@RequestMapping(value = "/addCategory", method = RequestMethod.POST)
	public String doAddCategory(@ModelAttribute OrderCategory category,@RequestParam("categoryDetail") String categoryDetail, HttpSession session, Model model) {
		
		Account account = SessionUtility.getAccount(session);
		LOGGER.info("Category : "+category.getCategoryName());
		if (account != null) {
			LOGGER.info("Detail : "+categoryDetail);
			category.setCategoryDetail(categoryDetail);
			categoryManager.save(category);
		}
		return "redirect:index";

	}
}
