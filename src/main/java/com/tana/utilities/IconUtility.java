package com.tana.utilities;

public enum IconUtility {
	
	DANGER("glyphicon glyphicon-remove-sign","danger"),
	WARNING("glyphicon glyphicon-minus-sign","warning"),
	INFO("glyphicon glyphicon-flag","info"),
	SUCCESS("glyphicon glyphicon-ok-sign","success");
	
	private String icon;
	private String status;
	
	private IconUtility(String icon, String status) {
		this.icon = icon;
		this.status = status;
	}

	public String getIcon() {
		return icon;
	}

	public String getStatus() {
		return status;
	}
	
	
}
