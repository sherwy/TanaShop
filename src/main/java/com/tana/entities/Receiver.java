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
import org.hibernate.annotations.Parameter;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import org.hibernate.annotations.GenericGenerator;
@SuppressWarnings("serial")
@Entity
@Table(name = "receiver", catalog = "tana_shopping")
public class Receiver implements java.io.Serializable {
	private long receiverId;
	private Orders orders;
	private String receiverName;
	private String address;
	private String province;
	private String zipCode;

	public Receiver() {
	}
	
	

	public Receiver(long receiverId, Orders orders, String receiverName, String address, String province, String zipCode) {
		super();
		this.receiverId = receiverId;
		this.orders = orders;
		this.receiverName = receiverName;
		this.address = address;
		this.province = province;
		this.zipCode = zipCode;
	}



	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "receiver_id", unique = true, nullable = false)
	public long getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(long receiverId) {
		this.receiverId = receiverId;
	}

	@OneToOne(fetch = FetchType.EAGER)
	@PrimaryKeyJoinColumn
	@JsonManagedReference
	public Orders getOrders() {
		return orders;
	}

	public void setOrders(Orders orders) {
		this.orders = orders;
	}

	@Column(name = "receiver_name", nullable = false)
	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	@Column(name = "address", nullable = false)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "province", nullable = false)
	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	@Column(name = "zipcode", nullable = false)
	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

}
