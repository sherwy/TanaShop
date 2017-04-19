package com.tana.controller;

import java.util.ArrayList;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.tana.Repositories.CategoryRepository;
import com.tana.Repositories.OrdersRepository;
import com.tana.entities.Account;
import com.tana.entities.OrderCategory;
import com.tana.entities.Orders;
import com.tana.entities.OrderLine;
import com.tana.entities.Product;
import com.tana.utilities.AlertMessage;
import com.tana.utilities.FolderUtilities;
import com.tana.utilities.ProductStatusUtilities;
import com.tana.utilities.SessionUtility;
import com.tana.utilities.UserRole;
import com.tana.utilities.VariableUtility;

@Controller
public class ProductController extends HeaderController {

	private Logger LOGGER = Logger.getLogger(ProductController.class);

	@Autowired
	private OrdersRepository ordersManager;

	@Autowired
	private CategoryRepository categoryManager;

	@ModelAttribute("product")
	public Product getProduct() {
		return new Product();
	}

	@RequestMapping(value = "/addProduct", method = RequestMethod.GET)
	public String goToAddProduct(HttpSession session, Model model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			if (account.getRole().equals(UserRole.ADMIN.getRole())) {
				model.addAttribute("listCategory", categoryManager.findParentCategory());
				model.addAttribute("listProdStatus", listProductStatus());
				return "AddProduct";
			}
		}
		model.addAttribute("alert", generatedAlert);
		return "index";
	}

	public List<ProductStatusUtilities> listProductStatus() {
		List<ProductStatusUtilities> listProdStatus = new ArrayList<ProductStatusUtilities>(
				EnumSet.allOf(ProductStatusUtilities.class));
		listProdStatus.remove(ProductStatusUtilities.DELETED);
		return listProdStatus;
	}

	@RequestMapping(value = "/addProduct", method = RequestMethod.POST)
	public String doAddProduct(@ModelAttribute("SpringWeb") Product product,
			@RequestParam("file") MultipartFile[] files, @RequestParam("productDetailText") String productDetailText,
			HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.ADD_PROD_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			LOGGER.info("IMG : " + product.getImgUrl());
			LOGGER.info("Product '" + product.getProductId() + "' has been saved.");
			LOGGER.info("Product Detail : " + productDetailText);

			product.setProductDetail(productDetailText);
			Product productReturned = productManager.save(product);

			String imgUrl = FolderUtilities.uploadFiles(files,
					VariableUtility.getProductPathFile(productReturned.getProductId() + ""));
			if (imgUrl != null)
				productReturned.setImgUrl(imgUrl);

			productReturned = productManager.save(productReturned);

			model.addAttribute("listCategory", categoryManager.findParentCategory());
			model.addAttribute("listProdStatus", listProductStatus());
			return "AddProduct";

		}
		model.addAttribute("alert", generatedAlert);
		return "index";

	}

	@RequestMapping(value = "/listProduct/{operation}", method = RequestMethod.GET)
	public String doListProduct(@PathVariable("operation") String operation, HttpSession session, ModelMap model) {
		LOGGER.info("Operation <List prod> : "+operation);
		Account account = SessionUtility.getAccount(session);
		List<Product> listProduct = null;
		if("recommended".equals(operation)){
			listProduct = productManager.findProductByStatus(ProductStatusUtilities.RECOMMENDED_PROD.getStatus());
			model.addAttribute("titleHeader","สินค้าแนะนำ");
		}else if("new".equals(operation)){
			listProduct = productManager.findProductByStatus(ProductStatusUtilities.NEW_PROD.getStatus());
			model.addAttribute("titleHeader","สินค้าค้าใหม่");
		}else if("all".equals(operation)){
			listProduct = productManager.findProductExceptStatus(ProductStatusUtilities.DELETED.getStatus());
			model.addAttribute("titleHeader","สินค้าทั้งหมด");
		}
			
		if (listProduct != null) {
			HashMap<Long, String> prodInCart = new HashMap<>();
			if (account != null) {
				Orders orders = ordersManager.findCartByAccountId(account.getAccountId());

				if (orders != null) {
					for (Product product : listProduct) {
						for (OrderLine orderLine : orders.getListProduct()) {
							Product cartProduct = orderLine.getPk().getProduct();
							if (product.getProductId() == cartProduct.getProductId()) {
								prodInCart.put(product.getProductId(), product.getProductName());
								LOGGER.info("Product (" + product.getProductId() + ") is already in cart");
								break;
							}
						}
					}
				}
			}
			model.addAttribute("prodInCart", prodInCart);
			model.addAttribute("listProd", listProduct);
			return "ListProduct";
		}
		model.addAttribute("alert",AlertMessage.INVALID_PAGE);
		return "index";
	}
	
	@RequestMapping(value = "/listProductByCategory/{categoryId}", method = RequestMethod.GET)
	public String doListProduct(@PathVariable("categoryId") int categoryIdArgs, HttpSession session, ModelMap model) {
		LOGGER.info("Category Id <List prod by cat> : "+categoryIdArgs);
		Account account = SessionUtility.getAccount(session);
		List<Product> listProduct = productManager.findProductByCategoryId(categoryIdArgs);
		OrderCategory category = categoryManager.findCategoryById(categoryIdArgs);
		HashMap<Long, String> prodInCart = new HashMap<>();
		if (account != null) {
			Orders orders = ordersManager.findCartByAccountId(account.getAccountId());
			if (orders != null) {
				for (Product product : listProduct) {
					for (OrderLine orderLine : orders.getListProduct()) {
						Product cartProduct = orderLine.getPk().getProduct();
						if (product.getProductId() == cartProduct.getProductId()) {
							prodInCart.put(product.getProductId(), product.getProductName());
							LOGGER.info("Product (" + product.getProductId() + ") is already in cart");
							break;
						}
					}
				}
			}
		}
		model.addAttribute("titleHeader","สินค้าตามหมวดหมู่ ("+category.getCategoryName()+")");
		model.addAttribute("prodInCart", prodInCart);
		model.addAttribute("listProd", listProduct);
		return "ListProduct";
	}

	@GetMapping(value = "/listAdminProduct")
	public String doListAdminProduct(HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			List<Product> listProduct = productManager.findAll();
			model.addAttribute("listAdminProduct", listProduct);
			return "ListAdminProduct";
		}
		model.addAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/editProduct/{productId}", method = RequestMethod.GET)
	public String doEditProduct(@PathVariable("productId") int productId, HttpSession session, ModelMap model) {
		LOGGER.info("Product id '" + productId + "' has requested to edit");
		Account account = SessionUtility.getAccount(session);

		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			Product product = productManager.findProductByProductId(productId);
			model.addAttribute("listCategory", categoryManager.findParentCategory());
			model.addAttribute("product", product);
			model.addAttribute("listProdStatus", listProductStatus());
			return "EditProduct";
		}
		model.addAttribute("alert", generatedAlert);
		return "index";

	}

	@RequestMapping(value = "/editProduct", method = RequestMethod.POST)
	public String doEditProduct(@ModelAttribute Product product, @RequestParam("file") MultipartFile[] files,
			@RequestParam("productDetailText") String productDetailText, HttpSession session, ModelMap model) {

		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.EDIT_PROD_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (!"".equals(productDetailText))
			product.setProductDetail(productDetailText);
		if (successAlert == generatedAlert) {
			String imgUrl = FolderUtilities.uploadFiles(files,
					VariableUtility.getProductPathFile(product.getProductId() + ""));
			if (imgUrl != null && !imgUrl.equals(""))
				product.setImgUrl(imgUrl);
			productManager.save(product);
			List<Product> listProduct = productManager.findAll();
			model.addAttribute("listAdminProduct", listProduct);
			return "ListAdminProduct";
		}
		model.addAttribute("alert", generatedAlert);
		return "index";

	}
}
