package com.tana.utilities;

public enum ProductStatusUtilities {
	
	AVAILABLE("Available"),DELETED("Deleted");
	
	private String status;

	ProductStatusUtilities(String status) {
		this.status = status;
	}

	public String getStatus() {
		return (this.status);
	}
}
