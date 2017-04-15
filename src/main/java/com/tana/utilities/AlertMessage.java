package com.tana.utilities;

import com.tana.entities.Account;

public enum AlertMessage {
	// GENERAL
	LOGIN_SUCCESS("ยินดีต้อนรับ !", "คุณได้ทำการเข้าสู่ระบบสำเร็จ", IconUtility.SUCCESS), 
	LOGIN_FAIL("ผิดพลาด","ชื่อผู้ใช้/รหัสผ่านผิดพลาด กรุณาลองใหม่อีกครั้ง", IconUtility.DANGER), 
	LOGOUT_SUCCESS("สำเร็จ","คุณได้ทำการออกจากระบบสำเร็จ", IconUtility.SUCCESS), 
	NON_PERMISSION("ผิดพลาด","คุณไม่มีสิทธิ์ในการเข้าถึงหน้านี้", IconUtility.DANGER), 
	ANONYMOUS_USER("คุณไม่ได้เข้าสู่ระบบ", "กรุณาเข้าสู่ระบบก่อนทำรายการนี้", IconUtility.DANGER),
	REQUIRED_LOGOUT("คำเตือน","กรุณาออกจากระบบก่อนทำรายการ",IconUtility.WARNING),
	REGISTER_SUCCESS("สำเร็จ","คุณได้ทำการสมัครสมาชิกแล้ว",IconUtility.SUCCESS),
	
	// ADMIN ROLE
	ADD_PROD_SUCCESS("เรียบร้อย !", "คุณได้ทำการเพิ่มสินค้าสำเร็จ", IconUtility.SUCCESS), 
	EDIT_PROD_SUCCESS("สำเร็จ","คุณได้ทำการแก้ไขข้อมูลสินค้าสำเร็จ",IconUtility.SUCCESS),
	ADD_CATEGORY_SUCCESS("เรียบร้อย !", "คุณได้ทำการเพิ่มประเภทสินค้าสำเร็จ", IconUtility.SUCCESS), 
	EDIT_WELCOME_SUCCESS("สำเร็จ","คุณได้ทำการแก้ไขข้อความต้อนรับสำเร็จ", IconUtility.SUCCESS), 
	EDIT_GENERAL_DETAIL_SUCCESS("สำเร็จ","คุณได้ทำการแก้ไขข้อมูลทั่วไปสำเร็จ", IconUtility.SUCCESS), 
	DELETE_PRODUCT_SUCCESS("สำเร็จ","คุณได้ทำการลบสินค้าสำเร็จ", IconUtility.SUCCESS), 
	VERIFY_ORDER_SUCCESS("สำเร็จ","คุณได้ทำการตรวจสอบรายการสั่งซื้อสำเร็จ",IconUtility.SUCCESS), 
	DELIVER_ORDER_SUCCESS("สำเร็จ","คุณได้ทำการยืนยันการส่งสินค้าสำเร็จ", IconUtility.SUCCESS),

	// USER FOLE
	CONFIRM_CART_SUCCESS("สำเร็จ", "คุณได้ทำการยืนยันการสั่งซื้อสินค้าเรียบร้อยแล้ว",IconUtility.SUCCESS), 
	REMOVE_PRODUCT_OUTOFCART_SUCCESS("สำเร็จ", "คุณได้ทำการลบสินค้าในตะกร้าสำเร็จ",IconUtility.SUCCESS), 
	ADD_PRODUCT_TOCART_SUCCESS("สำเร็จ", "คุณได้เพิ่มสินค้าลงตะกร้า",IconUtility.SUCCESS), 
	CONFIRM_PAYMENT_SUCCESS("สำเร็จ", "คุณได้ทำการแจ้งชำระเงินสำเร็จ",IconUtility.SUCCESS), 
	NO_PAYMENT_ORDER_WARNING("คำเตือน","คุณไม่มีรายการค้างชำระเงิน", IconUtility.WARNING);

	private String alertTitle;
	private String alertDetail;
	private IconUtility icon;

	private AlertMessage(String alertTitle, String alertDetail, IconUtility icon) {
		this.alertTitle = alertTitle;
		this.alertDetail = alertDetail;
		this.icon = icon;
	}

	public static AlertMessage generateAlertMsg(Account account, AlertMessage successAlert) {
		if (account != null)
			return successAlert;
		else
			return ANONYMOUS_USER;
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
