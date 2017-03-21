package com.tana.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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

        try {

            // Get the file and save it somewhere
            byte[] bytes = file.getBytes();
            Path path = Paths.get(VariableUtility.IMG_PATH + file.getOriginalFilename());
            Files.write(path, bytes);

            
        } catch (IOException e) {
            e.printStackTrace();
        }
		product.setImgUrl(file.getOriginalFilename());
		productManager.save(product);
		LOGGER.info("Product '" + product.getProductName() + "' has been saved.");
		return "index";
	}
	@GetMapping(value = "/listProduct")
	public String doListProduct(ModelMap model) {
		List<Product> listProduct = productManager.findAll();
		model.addAttribute("listProduct", listProduct);
		return "ListProduct";
	}

	@RequestMapping(value = "/editProduct/{productId}", method = RequestMethod.GET)
	public String doEditProduct(@PathVariable("productId") int productId, ModelMap model) {
		LOGGER.info("Product id '" + productId + "' has requested to edit");
		return "index";
	}

	@RequestMapping(value = "/addToCart/{productId}", method = RequestMethod.GET)
	public String doAddToCart(@PathVariable("productId") int productId, HttpSession session, ModelMap model) {
		LOGGER.info("Product id '" + productId + "' has requested to add to my cart");
		Account account = SessionUtility.getAccount(session);
		if (account != null) {
			Orders orders = ordersManager.findCartByAccountId(account.getAccountId());
			Product product = productManager.findOne(((Integer) productId).longValue());
			OrderLine orderLine = null;
			if (orders == null) {
				LOGGER.info("New Cart");
				orders = new Orders();
				orders.setOrderStatus("cart");
				orders.setCustomer(account);
				orders.setDatetime(new Date());
				ordersManager.save(orders);
				LOGGER.info("My cart '" + orders.getOrderId() + "'");
			}

			orderLine = new OrderLine();
			orderLine.getPk().setProduct(product);
			orderLine.getPk().setOrders(orders);
			orderLine.setAmount(3);
			LOGGER.info("\tAdd Product :  '" + product.getProductName() + "'");
			orderLineManager.save(orderLine);

			model.addAttribute("orderList", orderLine);

			return "redirect:../listProduct";
		}
		return "redirect:index.jsp";

	}
}
