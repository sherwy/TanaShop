package com.tana.controller;

import java.sql.Timestamp;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.RequestParam;

import com.tana.Repositories.BankAccountRepository;
import com.tana.Repositories.ContactRepository;
import com.tana.Repositories.DeliveryRepository;
import com.tana.Repositories.OrdersRepository;
import com.tana.Repositories.ReplyMsgRepository;
import com.tana.entities.Account;
import com.tana.entities.BankAccount;
import com.tana.entities.ContactMessage;
import com.tana.entities.Delivery;
import com.tana.entities.Orders;
import com.tana.entities.Product;
import com.tana.entities.ReplyMessage;
import com.tana.utilities.AlertMessage;
import com.tana.utilities.Bank;
import com.tana.utilities.BankType;
import com.tana.utilities.OrderStatusUtilities;
import com.tana.utilities.ProductStatusUtilities;
import com.tana.utilities.SessionUtility;
import com.tana.utilities.UserRole;

@Controller
public class AdminController extends HeaderController {

	private Logger LOGGER = Logger.getLogger(AdminController.class);

	@Autowired
	private OrdersRepository ordersManager;

	@Autowired
	private BankAccountRepository bankAccountManager;

	@Autowired
	private DeliveryRepository deliveryManager;

	@Autowired
	ContactRepository contactManager;

	@Autowired
	ReplyMsgRepository replyManager;

	@RequestMapping(value = "/requestUserView", method = RequestMethod.GET)
	public String requestUserView(HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.REQUEST_USER_VIEW_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);
		if (successAlert == generatedAlert) {
			account.setRole(UserRole.USER.getRole());
			session.setAttribute("user", account);
			session.setAttribute(SessionUtility.isAdminView, "true");
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/backToAdminRole", method = RequestMethod.GET)
	public String backToAdminRole(HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.REQUEST_BACK_TO_ADMIN;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.USER, account, successAlert);
		String isAdminView = (String) session.getAttribute(SessionUtility.isAdminView);
		if (successAlert == generatedAlert) {
			if ("true".equals(isAdminView)) {
				account.setRole(UserRole.ADMIN.getRole());
				session.setAttribute("user", account);
				session.removeAttribute(SessionUtility.isAdminView);
			} else {
				generatedAlert = AlertMessage.GENERAL_ERROR;
			}
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/listAllOrder", method = RequestMethod.GET)
	public String listAllOrder(@RequestParam(value = "alert", required = false) AlertMessage alert, HttpSession session,
			Model model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			List<Orders> listOrder = ordersManager
					.findOrderByOrderStatusOnExcept(OrderStatusUtilities.CART.getStatus());
			List<Orders> listDeliveryOrder = ordersManager
					.findOrderByOrderStatus(OrderStatusUtilities.PENDING_DELIVERY.getStatus());
			if (listOrder != null) {
				model.addAttribute("listDeliveryOrder", listDeliveryOrder);
				model.addAttribute("listOrder", listOrder);
				model.addAttribute("delivery", new Delivery());
			}
			if (alert != null)
				model.addAttribute("alert", alert);
			return "ListOrder";
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/deleteProduct/{productId}", method = RequestMethod.GET)
	public String doEditProduct(@PathVariable("productId") int productId, HttpSession session, ModelMap model) {
		LOGGER.info("Product id '" + productId + "' has requested to edit");
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.DELETE_PRODUCT_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			List<Product> listProductInOrder = productManager.findProductInOrder(productId);
			Product product = productManager.findProductByProductId(productId);
			if (listProductInOrder != null && listProductInOrder.size() > 0) {
				product.setStatus(ProductStatusUtilities.DELETED.getStatus());
				productManager.save(product);
			} else {
				productManager.delete(product);
			}
			session.setAttribute("alert", successAlert);
			return "redirect:/listAdminProduct";
		}
		session.setAttribute("alert", generatedAlert);
		return "../index";
	}

	@RequestMapping(value = "/verifyOrder/{orderId}", method = RequestMethod.GET)
	public String verifyOrder(@PathVariable("orderId") int orderId, HttpServletRequest request, HttpSession session,
			ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.VERIFY_ORDER_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			String status = OrderStatusUtilities.PENDING_DELIVERY.getStatus();
			Orders order = ordersManager.findByOrderId(orderId);
			order.setStatus(OrderStatusUtilities.PENDING_DELIVERY.getStatus());
			ordersManager.save(order);
			LOGGER.info("OrderId {" + orderId + "} : Change order status from [" + order.getStatus() + "] to [" + status
					+ "]");
			session.setAttribute("alert", generatedAlert);
			return "redirect:/listAllOrder";
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/deliveryOrder", method = RequestMethod.POST)
	public String deliveryOrder(@ModelAttribute Delivery delivery, HttpServletRequest request, HttpSession session,
			ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.DELIVER_ORDER_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			String status = OrderStatusUtilities.DELIVERED.getStatus();
			long orderId = delivery.getOrder().getOrderId();
			deliveryManager.save(delivery);
			Orders order = ordersManager.findByOrderId(orderId);
			order.setDelivery(delivery);
			order.setStatus(status);
			ordersManager.save(order);
			LOGGER.info("OrderId {" + orderId + "} : Change order status from [" + order.getStatus() + "] to [" + status
					+ "]");
			session.setAttribute("alert", generatedAlert);
			return "redirect:" + SessionUtility.getPreviousPage(request);
		}
		session.setAttribute("alert", generatedAlert);
		return "redirect:index";
	}

	@RequestMapping(value = "/addBank", method = RequestMethod.GET)
	public String addBank(HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			List<Bank> listBank = Arrays.asList(Bank.values());
			List<BankType> listBankType = Arrays.asList(BankType.values());

			model.addAttribute("listBank", listBank);
			model.addAttribute("listBankType", listBankType);
			model.addAttribute("listAllBank", bankAccountManager.findAll());
			model.addAttribute("bankAccount", new BankAccount());
			return "AddBank";
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/addBank", method = RequestMethod.POST)
	public String addBank(@ModelAttribute BankAccount bankAccount, HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.ADD_BANK_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			List<Bank> listBank = Arrays.asList(Bank.values());
			List<BankType> listBankType = Arrays.asList(BankType.values());

			bankAccountManager.save(bankAccount);

			model.addAttribute("listBank", listBank);
			model.addAttribute("listBankType", listBankType);
			model.addAttribute("listAllBank", bankAccountManager.findAll());
			model.addAttribute("bankAccount", new BankAccount());
			session.setAttribute("alert", generatedAlert);
			return "AddBank";
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/editBank", method = RequestMethod.POST)
	public String editBank(@ModelAttribute BankAccount bankAccount, HttpServletRequest request, HttpSession session,
			ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.EDIT_BANK_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			bankAccountManager.save(bankAccount);
			session.setAttribute("alert", generatedAlert);
			return "redirect:" + SessionUtility.getPreviousPage(request);
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/listPaymentOrder", method = RequestMethod.GET)
	public String listPaymentOrder(HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			HashMap<String, String> map = new HashMap<>();
			model.addAttribute("listOrder",
					ordersManager.findOrderByOrderStatus(OrderStatusUtilities.PENDING_VERIFICATION.getStatus(),
							OrderStatusUtilities.PENDING_DELIVERY.getStatus()));

			map.put("0", OrderStatusUtilities.PENDING_VERIFICATION.getStatus());
			map.put("1", OrderStatusUtilities.PENDING_DELIVERY.getStatus());

			model.addAttribute("mapStatus", map);
			return "ListPaymentOrder";
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/listDeliveryOrder", method = RequestMethod.GET)
	public String listDeliveryOrder(HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			HashMap<String, String> map = new HashMap<>();
			model.addAttribute("listOrder", ordersManager.findOrderByOrderStatus(
					OrderStatusUtilities.PENDING_DELIVERY.getStatus(), OrderStatusUtilities.DELIVERED.getStatus()));

			map.put("0", OrderStatusUtilities.PENDING_DELIVERY.getStatus());
			map.put("1", OrderStatusUtilities.DELIVERED.getStatus());

			model.addAttribute("mapStatus", map);
			model.addAttribute("delivery", new Delivery());
			return "ListDeliveryOrder";
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/printOrder/{orderId}", method = RequestMethod.GET)
	public String printOrder(@PathVariable("orderId") int orderId, HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			Orders order = ordersManager.findByOrderId(orderId);
			model.addAttribute("order", order);
			return "PrintOrder";
		}
		session.setAttribute("alert", generatedAlert);
		return "../index";
	}

	@RequestMapping(value = "/listUser", method = RequestMethod.GET)
	public String listUser(HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			List<Account> listUser = accountRepository.findUserByExceptRole(UserRole.ADMIN.getRole());
			HashMap<String, String> successOrder = new HashMap<>();
			HashMap<String, String> totalPrice = new HashMap<>();
			for (Account user : listUser) {
				int count = accountRepository.findCountOnStatusByUser(user.getAccountId(),
						OrderStatusUtilities.DELIVERED.getStatus());
				successOrder.put(user.getAccountId() + "", "" + count);
				LOGGER.info("Count : " + count);
				double total = 0;
				for (Orders orders : ordersManager.findOrdersByAccountId(user.getAccountId())) {
					double amount = orders.calPrice();
					LOGGER.info("Amount : " + amount);
					total += amount;
				}
				totalPrice.put(user.getAccountId() + "", total + "");
			}

			model.addAttribute("listUser", listUser);
			model.addAttribute("mapSuccessOrder", successOrder);
			model.addAttribute("mapTotalPrice", totalPrice);
			return "ListUser";
		}
		session.setAttribute("alert", generatedAlert);
		return "../index";
	}

	@RequestMapping(value = "/UserDetail/{accountId}", method = RequestMethod.GET)
	public String listUser(@PathVariable("accountId") int accountId, HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			System.out.println("AAAAA");
			model.addAttribute("user", accountRepository.findByAccountId(accountId));
			System.out.println("AAAAA");
			model.addAttribute("listDeliveredOrder",
					ordersManager.findOrderByOrderStatus(OrderStatusUtilities.DELIVERED.getStatus(), accountId));
			System.out.println("AAAAA");
			model.addAttribute("listPaymentOrder", ordersManager
					.findOrderByOrderStatus(OrderStatusUtilities.PENDING_VERIFICATION.getStatus(), accountId));
			System.out.println("AAAAA");
			model.addAttribute("listOrder", ordersManager.findOrderByOrderStatus(
					OrderStatusUtilities.DELIVERED.getStatus(), OrderStatusUtilities.PENDING_VERIFICATION.getStatus()));
			System.out.println("AAAAA");
			return "UserDetail";
		}
		session.setAttribute("alert", generatedAlert);
		return "../index";
	}

	@RequestMapping(value = "/replyContact", method = RequestMethod.GET)
	public String replyContact(HttpSession session, Model model) {

		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			List<ContactMessage> listMsg = contactManager.findAll();
			List<ContactMessage> listNonReplyMsg = contactManager.findMsgThatDidntReply();
			model.addAttribute("listMsg", listMsg);
			model.addAttribute("listNonReplyMsg", listNonReplyMsg);
			model.addAttribute("reply", new ReplyMessage());
			return "ReplyContact";
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/replyContact", method = RequestMethod.POST)
	public String replyContact(@ModelAttribute ReplyMessage reply, HttpServletRequest request, HttpSession session,
			Model model) {

		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.REPLY_CONTACT_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			ContactMessage contact = contactManager.findById(reply.getIssueMsg().getId());
			reply.setDatetime(new Timestamp(System.currentTimeMillis()));
			reply.setMsgOwner(account);
			replyManager.save(reply);
			contact.setReplyMsg(reply);
			contactManager.save(contact);
			session.setAttribute("alert", generatedAlert);
			return "redirect:" + SessionUtility.getPreviousPage(request);
		}
		session.setAttribute("alert", generatedAlert);
		return "index";
	}
}
