package com.tana.utilities;

import com.tana.entities.Account;

public enum AlertMessage {
	NON_PERMISSION("ผิดพลาด", "คุณไม่มีสิทธิ์ในการเข้าถึงหน้านี้", IconUtility.DANGER), 
	ANONYMOUS_USER("คุณไม่ได้เข้าสู่ระบบ", "กรุณาเข้าสู่ระบบก่อนทำรายการนี้",IconUtility.DANGER), 
	ADD_PROD_SUCCESS("เรียบร้อย !", "คุณได้ทำการเพิ่มสินค้าสำเร็จ",IconUtility.SUCCESS), 
	EDIT_WELCOME_SUCCESS("สำเร็จ", "คุณได้ทำการแก้ไขข้อความต้อนรับสำเร็จ",
							IconUtility.SUCCESS), 
	DELETE_PRODUCT_SUCCESS("สำเร็จ", "คุณได้ทำการลบสินค้าสำเร็จ",IconUtility.SUCCESS), 
	VERIFY_ORDER_SUCCESS("สำเร็จ","คุณได้ทำการตรวจสอบรายการสั่งซื้อสำเร็จ </br> สถานะสินได้เปลี่ยนจาก<b>"+ OrderStatusUtilities.PENDING_VERIFICATION.getStatus()
													+ "</b>เป็น<b>" + OrderStatusUtilities.PENDING_DELIVERY.getStatus()+ "</b>",IconUtility.SUCCESS),
	CONFIRM_CART_SUCCESS("สำเร็จ","คุณได้ทำการยืนยันการสั่งซื้อสินค้าเรียบร้อยแล้ว",IconUtility.SUCCESS),
	REMOVE_PRODUCT_OUTOFCART_SUCCESS("สำเร็จ","คุณได้ทำการลบสินค้าในตะกร้าสำเร็จ",IconUtility.SUCCESS),
	ADD_PRODUCT_TOCART_SUCCESS("สำเร็จ","คุณได้เพิ่มสินค้าลงตะกร้า",IconUtility.SUCCESS);

	private String alertTitle;
	private String alertDetail;
	private IconUtility icon;

	private AlertMessage(String alertTitle, String alertDetail, IconUtility icon) {
		this.alertTitle = alertTitle;
		this.alertDetail = alertDetail;
		this.icon = icon;
	}

	public static AlertMessage generateAlertMsg(UserRole expectedRole, Account account, AlertMessage successAlert) {
		if (account != null) {
			if (expectedRole.isRole(account)) {
				return successAlert;
			} else {
				return NON_PERMISSION;
			}
		} else {
			return ANONYMOUS_USER;
		}
	}

	public String getAlertTitle() {
		return alertTitle;
	}

	public void setAlertTitle(String alertTitle) {
		this.alertTitle = alertTitle;
	}

	public String getAlertDetail() {
		return alertDetail;
	}

	public void setAlertDetail(String alertDetail) {
		this.alertDetail = alertDetail;
	}

	public IconUtility getIcon() {
		return icon;
	}

	public void setIcon(IconUtility icon) {
		this.icon = icon;
	}

}
