package com.tana.utilities;

public enum BankType {
	
	SAVING("ออมทรัพย์"),FIX_DEPOSIT("เงินฝากประจำ"),CURRENT_ACCOUNT("ฝากกระแสรายวัน");
	
	private String bankType;

	private BankType(String bankType) {
		this.bankType = bankType;
	}

	public String getBankType() {
		return bankType;
	}

	public void setBankType(String bankType) {
		this.bankType = bankType;
	}
}
