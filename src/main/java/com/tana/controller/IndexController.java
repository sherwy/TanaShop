package com.tana.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.tana.Repositories.ProductRepository;
import com.tana.entities.Account;
import com.tana.entities.Product;
import com.tana.utilities.ProductStatusUtilities;

@Controller
public class IndexController {

	private Logger LOGGER = Logger.getLogger(IndexController.class);

	@Autowired
	private ProductRepository productManager;
	
	@ModelAttribute("account")
	public Account getAccount(){
		return new Account();
	}
	
	@GetMapping("/")
	public String start(Model model) {
		LOGGER.info("Redirect to index page");
		List<Product> listNewProd = productManager.findProductByStatus(ProductStatusUtilities.NEW_PROD.getStatus());
		List<Product> listRecommendedProd = productManager.findProductByStatus(ProductStatusUtilities.RECOMMENDED_PROD.getStatus());
		List<Product> listAll = productManager.findProductExceptStatus(ProductStatusUtilities.DELETED.getStatus());
		model.addAttribute("listNewProd",listNewProd);
		model.addAttribute("listRecommendedProd",listRecommendedProd);
		model.addAttribute("listAllProd",listAll);
		return "index";
	}

	@GetMapping("/index")
	public String index(Model model) {
		LOGGER.info("Redirect to index page");
		List<Product> listNewProd = productManager.findProductByStatus(ProductStatusUtilities.NEW_PROD.getStatus());
		List<Product> listRecommendedProd = productManager.findProductByStatus(ProductStatusUtilities.RECOMMENDED_PROD.getStatus());
		List<Product> listAll = productManager.findProductExceptStatus(ProductStatusUtilities.DELETED.getStatus());
		model.addAttribute("listNewProd",listNewProd);
		model.addAttribute("listRecommendedProd",listRecommendedProd);
		model.addAttribute("listAllProd",listAll);
		return "index";
	}
}
