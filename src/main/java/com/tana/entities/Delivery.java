package com.tana.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name="delivery" ,catalog="tana_shopping")
public class Delivery {
	private long id;
	private String deliveryCode;
	private String deliveryType;
	private Orders order;
	
	public Delivery(){}
	
	public Delivery(long id, String deliveryCode, String deliveryType, Orders order) {
		super();
		this.id = id;
		this.deliveryCode = deliveryCode;
		this.deliveryType = deliveryType;
		this.order = order;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "delivery_id", unique = true, nullable = false)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(name = "delivery_code", nullable = false)
	public String getDeliveryCode() {
		return deliveryCode;
	}

	public void setDeliveryCode(String deliveryCode) {
		this.deliveryCode = deliveryCode;
	}

	@Column(name = "delivery_type", nullable = false)
	public String getDeliveryType() {
		return deliveryType;
	}

	public void setDeliveryType(String deliveryType) {
		this.deliveryType = deliveryType;
	}
	
	@OneToOne(fetch = FetchType.EAGER)
	@PrimaryKeyJoinColumn
	@JsonManagedReference
	public Orders getOrder() {
		return order;
	}

	public void setOrder(Orders order) {
		this.order = order;
	}
	
	
	
}
