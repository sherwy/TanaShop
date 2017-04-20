package com.tana.controller;

import java.util.List;


import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.tana.Repositories.AccountRepository;
import com.tana.Repositories.CategoryRepository;
import com.tana.Repositories.GeneralDetailRepository;
import com.tana.Repositories.OrdersRepository;
import com.tana.Repositories.ProductRepository;
import com.tana.Repositories.WelcomeDetailRepository;
import com.tana.entities.Account;
import com.tana.entities.OrderCategory;
import com.tana.entities.Product;
import com.tana.utilities.ProductStatusUtilities;

public class HeaderController {

	private Logger LOGGER = Logger.getLogger(HeaderController.class);
	
	@Autowired
	protected AccountRepository accountRepository;
	
	@Autowired
	protected GeneralDetailRepository generalDetailManager;
	
	@Autowired
	protected WelcomeDetailRepository welcomeManager;
	
	@Autowired
	protected ProductRepository productManager;

	@Autowired
	protected CategoryRepository categoryManager;
	
	@Autowired
	private OrdersRepository ordersManager;
	
	@ModelAttribute("listNewProd")
	protected List<Product> getNewProds(){
		return productManager.findProductByStatus(ProductStatusUtilities.NEW_PROD.getStatus());
	}
	
	@ModelAttribute("listRecommendedProd")
	protected List<Product> getRecProds(){
		return productManager.findProductByStatus(ProductStatusUtilities.RECOMMENDED_PROD.getStatus());
	}
	
	@ModelAttribute("listAllProd")
	protected List<Product> getProds(){
		return productManager.findProductExceptStatus(ProductStatusUtilities.DELETED.getStatus());
	}
	
	@ModelAttribute("listNavCategory")
	protected List<OrderCategory> getListCategory(){
		return categoryManager.findParentCategory();
	}
	
	@ModelAttribute("account")
	protected Account getAccount(){
		return new Account();
	}
	
	
}
