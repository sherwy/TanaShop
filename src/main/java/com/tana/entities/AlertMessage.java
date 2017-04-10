package com.tana.entities;

public class AlertMessage {
	private String icon;
	private String status;
	private String header;
	private String text;
	
	public AlertMessage(){}
	
	public AlertMessage(String icon, String status, String header, String text) {
		super();
		this.icon = icon;
		this.status = status;
		this.header = header;
		this.text = text;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	
	
	
}
