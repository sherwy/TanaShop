package com.tana.utilities;

import org.apache.log4j.Logger;


public class VariableUtility {

	private static Logger LOGGER = Logger.getLogger(VariableUtility.class);
	private static String IMG_PATH_USERS = "/src/main/webapp/Images/Users/";
	private static String IMG_PATH_PRODUCTS = "/src/main/webapp/Images/Products/";
	private static String IMG_PATH_PAYMENT = "/src/main/webapp/Images/Payment/";
	private static String IMG_PATH_ABOUTUS = "/src/main/webapp/Images/AboutUs/";
	private static String IMG_PATH_GENERAL = "/src/main/webapp/Images/General/";
	private static String IMG_PATH_BANNER = "/src/main/webapp/Images/Bannner/";
	private static String IMG_PATH_BG = "/src/main/webapp/Images/background/";
	
	public static String getProductPathFile(String productId){
		String path = getCurrentDir()+IMG_PATH_PRODUCTS+productId+"/";
		LOGGER.info("Get product path file : "+path);
		return path;
	}  
	
	public static String getUserPathFile(String username){
		String path = getCurrentDir()+IMG_PATH_USERS+username+"/";
		LOGGER.info("Get user path file : "+path);
		return path;
	}
	
	public static String getPaymentPathFile(String orderId){
		String path = getCurrentDir()+IMG_PATH_PAYMENT+orderId+"/";
		LOGGER.info("Get payment path file : "+path);
		return path;
	}
	
	public static String getAboutUsPathFile(){
		String path = getCurrentDir()+IMG_PATH_ABOUTUS;
		LOGGER.info("Get payment path file : "+path);
		return path;
	}
	
	public static String getGeneralPathFile(){
		String path = getCurrentDir()+IMG_PATH_GENERAL;
		LOGGER.info("Get payment path file : "+path);
		return path;
	}
	public static String getBannerPathFile(){
		String path = getCurrentDir()+IMG_PATH_BANNER;
		LOGGER.info("Get payment path file : "+path);
		return path;
	}
	public static String getBackgroundPathFile(){
		String path = getCurrentDir()+IMG_PATH_BG;
		LOGGER.info("Get payment path file : "+path);
		return path;
	}
	
	private static String getCurrentDir(){
		return System.getProperty("user.dir").replace("\\","/");
	}
}
