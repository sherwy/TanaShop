package com.tana.utilities;

import javax.servlet.http.HttpSession;

import com.tana.entities.Account;

public class SessionUtility {
	
	public static Account getAccount(HttpSession session){
		return (Account) session.getAttribute("user");
	}
	
	public static void updateAccount(HttpSession session,Account account){
		session.setAttribute("user", account);
	}
}
