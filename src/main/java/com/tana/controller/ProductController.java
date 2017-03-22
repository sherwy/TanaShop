package com.tana.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tana.Repositories.OrderLineRepository;
import com.tana.Repositories.OrdersRepository;
import com.tana.Repositories.ProductRepository;
import com.tana.entities.Account;
import com.tana.entities.Orders;
import com.tana.entities.OrderLine;
import com.tana.entities.Product;
import com.tana.utilities.SessionUtility;
import com.tana.utilities.VariableUtility;

@Controller
public class ProductController {

	private Logger LOGGER = Logger.getLogger(ProductController.class);

	@Autowired
	private ProductRepository productManager;

	@Autowired
	private OrdersRepository ordersManager;

	@Autowired
	private OrderLineRepository orderLineManager;

	@ModelAttribute("product")
	public Product getProduct() {
		return new Product();
	}

	@GetMapping(value = "/addProduct")
	public String goToAddProduct() {
		return "AddProduct";
	}

	@RequestMapping(value = "/addProduct", method = RequestMethod.POST)
	public String doAddProduct(@ModelAttribute("SpringWeb") Product product,@RequestParam("file")MultipartFile file, HttpSession session, ModelMap model) {
		LOGGER.info("IMG : " + product.getImgUrl());
		
		if (file.isEmpty()) {
            LOGGER.info("File is empty");
            return "redirect:index";
        }
		String fileName = null;
        try {

            // Get the file and save it somewhere
            byte[] bytes = file.getBytes();
            fileName = product.getProductName()+"_"+ file.getOriginalFilename();
            LOGGER.info("File name : "+fileName);
            Path path = Paths.get(VariableUtility.IMG_PATH_PRODUCTS + fileName);
            Files.write(path, bytes);

            
        } catch (IOException e) {
            e.printStackTrace();
        }
		product.setImgUrl(fileName);
		productManager.save(product);
		LOGGER.info("Product '" + product.getProductName() + "' has been saved.");
		return "index";
	}
	@GetMapping(value = "/listProduct")
	public String doListProduct(HttpSession session,ModelMap model) {
		Account account = SessionUtility.getAccount(session);	
		if (account != null) {

			List<Product> listProduct = productManager.findAll();
			Orders orders = ordersManager.findCartByAccountId(account.getAccountId());

			List<Product> listAvaliableProduct = new ArrayList<>();
			if(orders == null){
				for(Product product : listProduct){
					listAvaliableProduct.add(product);
				}
			}else{
				List<Product> listNotAvaliableProduct = new ArrayList<>();
				for(Product product : listProduct){
					boolean isAvaliable = true;
					for(OrderLine orderLine : orders.getListProduct()){
						Product cartProduct = orderLine.getPk().getProduct();
						if(product.getProductId() == cartProduct.getProductId()){
							listNotAvaliableProduct.add(product);
							LOGGER.info("Product ("+product.getProductId()+") added on not avaliable product");
							isAvaliable = false;
							break;
						}
					}
					if(isAvaliable){
						listAvaliableProduct.add(product); 
						LOGGER.info("Product ("+product.getProductId()+") added on avaliable product");
					}
				}
				model.addAttribute("listNotAvaProduct", listNotAvaliableProduct);
			}
			model.addAttribute("listAvaProduct", listAvaliableProduct);
			return "ListProduct";
		
		}else{
			return "redirect:index";
		}
	}

	@RequestMapping(value = "/editProduct/{productId}", method = RequestMethod.GET)
	public String doEditProduct(@PathVariable("productId") int productId, ModelMap model) {
		LOGGER.info("Product id '" + productId + "' has requested to edit");
		return "index";
	}

	
}
