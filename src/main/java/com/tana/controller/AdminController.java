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

import com.tana.Repositories.DeliveryRepository;
import com.tana.Repositories.OrdersRepository;
import com.tana.Repositories.ProductRepository;
import com.tana.entities.Account;
import com.tana.entities.Delivery;
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

	@Autowired
	private DeliveryRepository deliveryManager;
	
	@RequestMapping("/listAllOrder")
	public String listAllOrder(HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);

		if (account != null) {
			List<Orders> listOrder = ordersManager.findOrderByOrderStatusOnExcept(OrderStatusUtilities.CART.getStatus());
			List<Orders> listDeliveryOrder = ordersManager.findOrderByOrderStatus(OrderStatusUtilities.PENDING_DELIVERY.getStatus());
			if (listOrder != null) {
				model.addAttribute("listDeliveryOrder",listDeliveryOrder);
				model.addAttribute("listOrder", listOrder);
				model.addAttribute("delivery",new Delivery());
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
	
	@RequestMapping(value = "/verifyOrder/{orderId}", method = RequestMethod.GET)
	public String verifyOrder(@PathVariable("orderId")int orderId, HttpSession session, ModelMap model){
		Account account = SessionUtility.getAccount(session);
		if (account != null) {
			String status = OrderStatusUtilities.PENDING_DELIVERY.getStatus();
			Orders order = ordersManager.findByOrderId(orderId);
			order.setStatus(OrderStatusUtilities.PENDING_DELIVERY.getStatus());
			ordersManager.save(order);
			LOGGER.info("OrderId {"+orderId+"} : Change order status from ["+order.getStatus()+"] to ["+status+"]");
		}
		return "redirect:../listAllOrder";
	}
	
	@RequestMapping(value = "/deliveryOrder", method = RequestMethod.POST)
	public String deliveryOrder(@ModelAttribute Delivery delivery, HttpSession session, ModelMap model){
		Account account = SessionUtility.getAccount(session);
		if (account != null) {
			String status = OrderStatusUtilities.DELIVERED.getStatus();
			long orderId = delivery.getOrder().getOrderId();
			deliveryManager.save(delivery);
			Orders order = ordersManager.findByOrderId(orderId);
			order.setDelivery(delivery);
			order.setStatus(status);
			ordersManager.save(order);
			LOGGER.info("OrderId {"+orderId+"} : Change order status from ["+order.getStatus()+"] to ["+status+"]");
		}
		return "redirect:listAllOrder";
	}

}
