package com.tana.utilities;

public enum DeliveryTypeUtilities {
	
	REGISTER("ลงทะเบียน",50,"1-3"),
	EMS("ด่วนพิเศษ",30,"3-7");
	
	private String type;
	private int price;
	private String howLong;
	
	
	DeliveryTypeUtilities(String type,int price,String howLong) {
		this.type = type;
		this.price = price;
		this.howLong = howLong;
	}

	public String getType() {
		return (this.type);
	}
	
	public int getPrice() {
		return (this.price);
	}
	
	public String getHowLong() {
		return (this.howLong);
	}
}
