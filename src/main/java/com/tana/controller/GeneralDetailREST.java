package com.tana.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.tana.Repositories.AccountRepository;
import com.tana.Repositories.GeneralDetailRepository;
import com.tana.Repositories.OrdersRepository;
import com.tana.Repositories.ProductRepository;
import com.tana.Repositories.WelcomeDetailRepository;
import com.tana.entities.Account;
import com.tana.entities.GeneralDetail;
import com.tana.entities.OrderLine;
import com.tana.entities.Orders;
import com.tana.entities.Product;
import com.tana.entities.WelcomeDetail;
import com.tana.utilities.ProductStatusUtilities;

@RestController
@RequestMapping("/rest")
public class GeneralDetailREST {
	
	private Logger LOGGER = Logger.getLogger(GeneralDetailREST.class);
	
	@Autowired
	private GeneralDetailRepository generalDetailManager;

	@Autowired
	private WelcomeDetailRepository welcomeDetailManager;
	
	@Autowired
	private AccountRepository accountManager;
	
	@Autowired
	private ProductRepository productManager;
	
	@Autowired
	private OrdersRepository ordersManager;
	
	@RequestMapping(value="/generalDetailShop",method = RequestMethod.GET)
	public ResponseEntity<GeneralDetail> getDetail() {
		GeneralDetail detail = generalDetailManager.getLastest();
		if(detail == null){
			detail = new GeneralDetail();
			detail.setShopName("Tana");
			detail.setShopDetail("EverydayKPop shop");
			detail.setShopDescription("Korean");
			detail.setImgUrl("/Images/banner/banner.jpg");
			try {
				detail.setDateChanged(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss Z").parse(new Date().toString()));
			} catch (ParseException e) {
				detail.setDateChanged(null);
			}
			detail.setEmail("tanabodee.l@outlook.com");
		}
		return new ResponseEntity<>(detail,HttpStatus.OK);
	}
	
	@RequestMapping(value="/welcomeDetail",method = RequestMethod.GET)
	public ResponseEntity<WelcomeDetail> getWelcomeDetail() {
		WelcomeDetail detail = welcomeDetailManager.getLastest();
		if(detail == null){
			detail = new WelcomeDetail();
			detail.setWelcomeText("<b>Welcome to my shop</b>");
		}
		return new ResponseEntity<>(detail,HttpStatus.OK);
	}
	
	@RequestMapping(value="/getCart",method = RequestMethod.GET)
	public ResponseEntity<HashMap<Long,String>> getCartMap(@RequestParam(value="userid") int userid){
		Account account = accountManager.findByAccountId(userid);
		List<Product> listProduct = productManager.findProductExceptStatus(ProductStatusUtilities.DELETED.getStatus());
		HashMap<Long,String> prodInCart = new HashMap<>();
		if (account != null) {
			Orders orders = ordersManager.findCartByAccountId(account.getAccountId());
			if (orders != null) {
				for (Product product : listProduct) {
					for (OrderLine orderLine : orders.getListProduct()) {
						Product cartProduct = orderLine.getPk().getProduct();
						if (product.getProductId() == cartProduct.getProductId()) {
							prodInCart.put(product.getProductId(),product.getProductName());
							LOGGER.info("Product (" + product.getProductId() + ") is already in cart");
							break;
						}
					}
				}
			}
		}
		return new ResponseEntity<>(prodInCart,HttpStatus.OK);
	}
}
