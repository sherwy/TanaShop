package com.tana.utilities;

public enum ProductStatusUtilities {
	
	NEW_PROD("สินค้าใหม่"),
	RECOMMENDED_PROD("สินค้าแนะนำ"),
	DELETED("Deleted");
	
	private String status;

	ProductStatusUtilities(String status) {
		this.status = status;
	}

	public String getStatus() {
		return (this.status);
	}
}
