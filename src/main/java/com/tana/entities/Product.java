package com.tana.entities;

import java.util.List;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonManagedReference;
@SuppressWarnings("serial")
@Entity
@Table(name="product", catalog = "tana_shopping")
public class Product implements java.io.Serializable {
	private long productId;
	private String productName;
	private String imgUrl;
	private double price;
	private String productDetail;
	private List<OrderLine> listOrder;
	
	
	public Product(){}

	public Product(long productId, String productName, String imgUrl, double price, String productDetail,
			List<OrderLine> listOrder) {
		super();
		this.productId = productId;
		this.productName = productName;
		this.imgUrl = imgUrl;
		this.price = price;
		this.productDetail = productDetail;
		this.listOrder = listOrder;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="product_id",unique=true,nullable=false)
	public long getProductId() {
		return productId;
	}

	public void setProductId(long productId) {
		this.productId = productId;
	}
	
	@Column(name="product_name",nullable=false)
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
	
	@Column(name="img_url")
	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	
	@Column(name="product_price",nullable=false)
	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
	
	@Column(name="product_detail")
	public String getProductDetail() {
		return productDetail;
	}

	public void setProductDetail(String productDetail) {
		this.productDetail = productDetail;
	}
	
	@OneToMany(fetch=FetchType.LAZY,mappedBy="pk.product")
	public List<OrderLine> getListOrder() {
		return listOrder;
	}

	public void setListOrder(List<OrderLine> listOrder) {
		this.listOrder = listOrder;
	}
	
	
}
