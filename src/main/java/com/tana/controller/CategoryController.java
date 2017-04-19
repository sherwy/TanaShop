package com.tana.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tana.Repositories.CategoryRepository;
import com.tana.entities.Account;
import com.tana.entities.OrderCategory;
import com.tana.entities.Product;
import com.tana.utilities.AlertMessage;
import com.tana.utilities.SessionUtility;
import com.tana.utilities.UserRole;

@Controller
public class CategoryController extends HeaderController{
	private Logger LOGGER = Logger.getLogger(CategoryController.class);

	@Autowired
	CategoryRepository categoryManager;
	
	@RequestMapping(value = "/addCategory", method = RequestMethod.GET)
	public String doAddCategory(HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);
		
		if(successAlert == generatedAlert){
			List<OrderCategory> listCategory = categoryManager.findParentCategory();
			model.addAttribute("listCategory", listCategory);
			model.addAttribute("category", new OrderCategory());
			return "ManageCategory";
		}
		model.addAttribute("alert",generatedAlert);
		return "index";
		
	}

	@RequestMapping(value = "/addCategory", method = RequestMethod.POST)
	public String doAddCategory(@ModelAttribute OrderCategory category, HttpServletRequest request,HttpSession session, Model model) {
		
		Account account = SessionUtility.getAccount(session);
		LOGGER.info("Category : "+category.getCategoryName());
		AlertMessage successAlert = AlertMessage.ADD_CATEGORY_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);
		
		if(successAlert == generatedAlert){
			categoryManager.save(category);
			session.setAttribute("alert",generatedAlert);
			return "redirect:"+SessionUtility.getPreviousPage(request);
		}
		session.setAttribute("alert",generatedAlert);
		return "index";

	}
	
	@RequestMapping(value = "/editCategory", method = RequestMethod.POST)
	public String doEditCategory(@ModelAttribute OrderCategory category, HttpServletRequest request,HttpSession session, Model model) {
		
		Account account = SessionUtility.getAccount(session);
		LOGGER.info("Category : "+category.getCategoryName());
		AlertMessage successAlert = AlertMessage.EDIT_CATEGORY_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);
		
		if(successAlert == generatedAlert){
			categoryManager.save(category);
			session.setAttribute("alert",generatedAlert);
			return "redirect:"+SessionUtility.getPreviousPage(request);
		}
		session.setAttribute("alert",generatedAlert);
		return "index";
	}
	
	@RequestMapping(value = "/deleteCategory/{categoryId}", method = RequestMethod.GET)
	public String deleteCategory(@PathVariable("categoryId") int categoryId, HttpServletRequest request,HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.DELETE_CATEGORY_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);
		
		if(successAlert == generatedAlert){
			OrderCategory category = categoryManager.findCategoryById(categoryId);
			for(Product prod : category.getListProduct()){
				productManager.updateProductCategoryToNullByProductId(prod.getProductId());
			}
			for(OrderCategory childCat : category.getListChildCategory()){
				categoryManager.updateParentCategoryToNullByCategoryId(childCat.getCategoryId());
			}
			categoryManager.delete(category);
			session.setAttribute("alert",generatedAlert);
			return "redirect:/addCategory";
		}
		session.setAttribute("alert",generatedAlert);
		return "../index";
	}
}
