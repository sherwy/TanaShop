package com.tana.utilities;

import com.tana.entities.Account;

public enum UserRole {
	USER("user"),ADMIN("admin");

	private String role;

	UserRole(String role) {
		this.role = role;
	}

	public String getRole() {
		return (this.role);
	}
	
	public boolean isRole(Account account){
		if(account.getRole().equals(role))
			return true;
		else
			return false;
	}
	
}
