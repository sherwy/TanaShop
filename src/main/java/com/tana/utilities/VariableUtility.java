package com.tana.utilities;

import org.apache.log4j.Logger;


public class VariableUtility {

	private static Logger LOGGER = Logger.getLogger(VariableUtility.class);
	public static String IMG_PATH_USERS = "/src/main/webapp/Images/Users/";
	public static String IMG_PATH_PRODUCTS = "/src/main/webapp/Images/Products/";
	public static String IMG_PATH_PAYMENT = "/src/main/webapp/Images/Payment/";
	
	public static String getProductPathFile(String productId,String productName){
		String path = getCurrentDir()+IMG_PATH_PRODUCTS+productId+"_"+productName+"/";
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
	
	private static String getCurrentDir(){
		return System.getProperty("user.dir").replace("\\","/");
	}
}
