package com.tana.utilities;

public enum OrderStatusUtilities {
	CART("ตะกร้า"),
	PENDING_PAYMENT("รอการชำระเงิน"),
	PENDING_VERIFICATION("รอการตรวจสอบ"),
	PAYMENT_CONFIRMED("ยืนยันการชำระเงิน"),
	PENDING_DELIVERY("รอการจัดส่ง"),
	DELIVERED("จัดส่งแล้ว");

	private String status;

	OrderStatusUtilities(String status) {
		this.status = status;
	}

	public String getStatus() {
		return (this.status);
	}
	
}
