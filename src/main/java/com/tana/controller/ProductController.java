package com.tana.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.EnumSet;
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
import com.tana.Repositories.ProductRepository;
import com.tana.entities.Account;
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
public class ProductController {

	private Logger LOGGER = Logger.getLogger(ProductController.class);

	@Autowired
	private ProductRepository productManager;

	@Autowired
	private OrdersRepository ordersManager;

	@Autowired
	private CategoryRepository categoryManager;

	@ModelAttribute("product")
	public Product getProduct() {
		return new Product();
	}

	@ModelAttribute("account")
	public Account getAccount() {
		return new Account();
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

			// product.setStatus(ProductStatusUtilities.AVAILABLE.getStatus());
			product.setProductDetail(productDetailText);
			Product productReturned = productManager.save(product);

			String fileName = null;
			String imgUrlDB = "";
			try {
				String pathFile = VariableUtility.getProductPathFile(productReturned.getProductId() + "",
						productReturned.getProductName());
				FolderUtilities.createFolderIfNotExist(pathFile);
				for (int i = 0; i < files.length; i++) {
					if (i != 0) {
						imgUrlDB += ",";
					}
					MultipartFile file = files[i];

					byte[] bytes = file.getBytes();
					fileName = product.getProductId() + "_" + product.getProductName() + file.getOriginalFilename();
					LOGGER.info("File name : " + fileName);
					imgUrlDB += fileName;
					Path path = Paths.get(pathFile + fileName);
					Files.write(path, bytes);
				}
				productReturned.setImgUrl(imgUrlDB);
				productManager.save(productReturned);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		model.addAttribute("alert", generatedAlert);
		return "index";
	}

	@RequestMapping(value = "/listProduct", method = RequestMethod.GET)
	public String doListProduct(HttpSession session, ModelMap model) {
		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = null;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(account, successAlert);

		if (successAlert == generatedAlert) {

			List<Product> listProduct = productManager.findAll();
			Orders orders = ordersManager.findCartByAccountId(account.getAccountId());

			List<Product> listAvaliableProduct = new ArrayList<>();
			if (orders == null) {
				for (Product product : listProduct) {
					listAvaliableProduct.add(product);
				}
			} else {
				List<Product> listNotAvaliableProduct = new ArrayList<>();
				for (Product product : listProduct) {
					boolean isAvaliable = true;
					for (OrderLine orderLine : orders.getListProduct()) {
						Product cartProduct = orderLine.getPk().getProduct();
						if (product.getProductId() == cartProduct.getProductId()) {
							listNotAvaliableProduct.add(product);
							LOGGER.info("Product (" + product.getProductId() + ") added on not avaliable product");
							isAvaliable = false;
							break;
						}
					}
					if (isAvaliable) {
						listAvaliableProduct.add(product);
						LOGGER.info("Product (" + product.getProductId() + ") added on avaliable product");
					}
				}
				model.addAttribute("listNotAvaProduct", listNotAvaliableProduct);
			}

			model.addAttribute("listAvaProduct", listAvaliableProduct);
			return "ListProduct";
		}
		model.addAttribute("alert", generatedAlert);
		return "index";
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
	public String doEditProduct(@ModelAttribute("SpringWeb") Product product, @RequestParam("file") MultipartFile file,
			@RequestParam("productDetailText") String productDetailText, HttpSession session, ModelMap model) {

		Account account = SessionUtility.getAccount(session);
		AlertMessage successAlert = AlertMessage.EDIT_PROD_SUCCESS;
		AlertMessage generatedAlert = AlertMessage.generateAlertMsg(UserRole.ADMIN, account, successAlert);

		if (successAlert == generatedAlert) {
			String fileName = null;
			try {
				byte[] bytes = file.getBytes();
				fileName = product.getProductName() + "_" + file.getOriginalFilename();
				LOGGER.info("File name : " + fileName);
				Path path = Paths.get(VariableUtility.IMG_PATH_PRODUCTS + fileName);
				Files.write(path, bytes);

			} catch (IOException e) {
				e.printStackTrace();
			}
			product.setImgUrl(fileName);
			product.setProductDetail(productDetailText);
			productManager.save(product);
			LOGGER.info("Product '" + product.getProductName() + "' has been saved.");
		}
		model.addAttribute("alert", generatedAlert);
		return "index";

	}
}
