package com.tana.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name="order_category" , catalog = "tana_shopping")
public class OrderCategory {
	private long categoryId;
	private String categoryName;
	private String categoryDetail;
	private List<Product> listProduct;
	private List<OrderCategory> listChildCategory;
	private OrderCategory parentCategory;
	
	public OrderCategory(){}

	public OrderCategory(long categoryId, String categoryName, String categoryDetail, List<Product> listProduct,
			List<OrderCategory> listChildCategory, OrderCategory parentCategory) {
		super();
		this.categoryId = categoryId;
		this.categoryName = categoryName;
		this.categoryDetail = categoryDetail;
		this.listProduct = listProduct;
		this.listChildCategory = listChildCategory;
		this.parentCategory = parentCategory;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "category_id", unique = true, nullable = false)
	public long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}
	
	@Column(name="category_name",nullable=false)
	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	@OneToMany(fetch=FetchType.LAZY,mappedBy="category")
	@JsonBackReference
	public List<Product> getListProduct() {
		return listProduct;
	}

	public void setListProduct(List<Product> listProduct) {
		this.listProduct = listProduct;
	}

	@OneToMany(fetch=FetchType.EAGER,mappedBy="parentCategory")
	@JsonBackReference
	public List<OrderCategory> getListChildCategory() {
		return listChildCategory;
	}

	public void setListChildCategory(List<OrderCategory> listChildCategory) {
		this.listChildCategory = listChildCategory;
	}
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="parent_category_id",nullable=true)
	@JsonManagedReference
	public OrderCategory getParentCategory() {
		return parentCategory;
	}

	public void setParentCategory(OrderCategory parentCategory) {
		this.parentCategory = parentCategory;
	}

	@Column(name="category_detail",nullable=true)
	public String getCategoryDetail() {
		return categoryDetail;
	}

	public void setCategoryDetail(String categoryDetail) {
		this.categoryDetail = categoryDetail;
	}
	
	
	
}
