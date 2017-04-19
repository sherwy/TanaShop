package com.tana.utilities;

public enum Bank {
	
	KBANK("กสิกร","#"),SCB("ไทยพาณิชย์","#"),BANGKOK("กรุงเทพ","#"),KRUNGSRI("กรุงศรี","#"),TMB("ทหารไทย","#"),KRUNGTHAI("กรุงไทย","#");
	
	private String bankName;
	private String bankImg;
	
	private Bank(String bankName, String bankImg) {
		this.bankName = bankName;
		this.bankImg = bankImg;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankImg() {
		return bankImg;
	}
	public void setBankImg(String bankImg) {
		this.bankImg = bankImg;
	}
	
	
}
