package com.tana.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tana.Repositories.OrdersRepository;
import com.tana.Repositories.ProductRepository;
import com.tana.entities.Account;
import com.tana.entities.OrderCategory;
import com.tana.entities.Orders;
import com.tana.entities.Product;
import com.tana.utilities.OrderStatusUtilities;
import com.tana.utilities.ProductStatusUtilities;
import com.tana.utilities.SessionUtility;

@Controller
public class AdminController {

	private Logger LOGGER = Logger.getLogger(AdminController.class);

	@Autowired
	private OrdersRepository ordersManager;

	@Autowired
	private ProductRepository productManager;

	@RequestMapping("/listAllOrder")
	public String listAllOrder(HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);

		if (account != null) {
			List<Orders> listOrder = ordersManager
					.findOrderByOrderStatusOnExcept(OrderStatusUtilities.CART.getStatus());
			if (listOrder != null) {
				model.addAttribute("listOrder", listOrder);
			}
			return "ListOrder";
		} else {
			return "redirect:index";
		}

	}

	@RequestMapping(value = "/deleteProduct/{productId}", method = RequestMethod.GET)
	public String doEditProduct(@PathVariable("productId") int productId, HttpSession session, ModelMap model) {
		LOGGER.info("Product id '" + productId + "' has requested to edit");

		Account account = SessionUtility.getAccount(session);
		if (account != null) {

			List<Product> listProductInOrder = productManager.findProductInOrder(productId);
			Product product = productManager.findProductByProductId(productId);
			if (listProductInOrder != null && listProductInOrder.size() > 0) {
				product.setStatus(ProductStatusUtilities.DELETED.getStatus());
				productManager.save(product);
			} else {
				productManager.delete(product);
			}
		}
		return "redirect:../listAdminProduct";
	}

}
