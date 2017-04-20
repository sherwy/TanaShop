package com.tana.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "config_web", catalog = "tana_shopping")
public class ConfigWeb {
	private long id;
	private String footerColor;
	private String bannerImg;
	private String bgImg;
	
	public ConfigWeb(){}
	
	
	public ConfigWeb(long id, String footerColor, String bannerImg, String bgImg) {
		super();
		this.id = id;
		this.footerColor = footerColor;
		this.bannerImg = bannerImg;
		this.bgImg = bgImg;
	}


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(name = "footer_color",nullable = false)
	public String getFooterColor() {
		return footerColor;
	}

	public void setFooterColor(String footerColor) {
		this.footerColor = footerColor;
	}

	@Column(name = "banner_img",nullable = false)
	public String getBannerImg() {
		return bannerImg;
	}

	public void setBannerImg(String bannerImg) {
		this.bannerImg = bannerImg;
	}

	@Column(name = "bg_img",nullable = false)
	public String getBgImg() {
		return bgImg;
	}


	public void setBgImg(String bgImg) {
		this.bgImg = bgImg;
	}
	
	
}
