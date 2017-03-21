package com.tana.utilities;

public enum OrderStatus {
	ORDER_CART("Cart"), ORDER_PENDING_PAYMENT("Pending Payment"), ORDER_PENDING_CONFIRM_PAYMENT(
			"Pending Confirm Payment"), ORDER_PENDING_SENDING("Pending Sending"), ORDER_COMPLETE("Complete");

	private String status;

	OrderStatus(String status) {
		this.status = status;
	}

	public String getStatus() {
		return (this.status);
	}
	
}
