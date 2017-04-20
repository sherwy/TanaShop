package com.tana.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="general_shop_detail" , catalog="tana_shopping")
public class GeneralDetail {
	private long id;
	private String shopName;
	private String shopDescription;
	private String shopDetail;
	private String shopTelephone;
	private String email;
	private Date dateChanged;
	private String address;
	private String imgUrl;
	
	public GeneralDetail(){}

	

	public GeneralDetail(long id, String shopName, String shopDescription, String shopDetail, String shopTelephone,
			String email, Date dateChanged, String address, String imgUrl) {
		super();
		this.id = id;
		this.shopName = shopName;
		this.shopDescription = shopDescription;
		this.shopDetail = shopDetail;
		this.shopTelephone = shopTelephone;
		this.email = email;
		this.dateChanged = dateChanged;
		this.address = address;
		this.imgUrl = imgUrl;
	}



	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id",unique=true,nullable=false)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	@Column(name="shop_name")
	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	
	@Column(name="shop_description")
	public String getShopDescription() {
		return shopDescription;
	}

	public void setShopDescription(String shopDescription) {
		this.shopDescription = shopDescription;
	}

	@Column(name="shop_detail")
	public String getShopDetail() {
		return shopDetail;
	}

	public void setShopDetail(String shopDetail) {
		this.shopDetail = shopDetail;
	}
	
	@Column(name="shop_telephone")
	public String getShopTelephone() {
		return shopTelephone;
	}

	public void setShopTelephone(String shopTelephone) {
		this.shopTelephone = shopTelephone;
	}
	
	@Column(name="email")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	@Temporal(TemporalType.DATE)
	@Column(name="date_changed")
	public Date getDateChanged() {
		return dateChanged;
	}

	public void setDateChanged(Date dateChanged) {
		this.dateChanged = dateChanged;
	}


	@Column(name="address")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name="imgUrl")
	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	
	
}
