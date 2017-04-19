package com.tana.utilities;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.tana.entities.Account;

public class SessionUtility {
	
	public static String isAdminView = "IS_ADMIN_VIEW";
	
	public static Account getAccount(HttpSession session){
		return (Account) session.getAttribute("user");
	}
	
	public static void updateAccount(HttpSession session,Account account){
		session.setAttribute("user", account);
	}
	
	public static String getPreviousPage(HttpServletRequest request){
		String fullUrl = request.getHeader("Referer");
		String[] fullUrlSplitted = fullUrl.split("\\/\\/");
		String[] urlSplitted = fullUrlSplitted[1].split("\\/");
		String previousPage = "";
		for(int i=1 ; i<urlSplitted.length ; i++){
			previousPage += urlSplitted[i] + "/";
		}
		System.out.println(previousPage);
		return previousPage;
		
	}
}
