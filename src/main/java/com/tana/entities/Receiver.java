package com.tana.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import org.hibernate.annotations.Parameter;
import org.hibernate.annotations.GenericGenerator;
@SuppressWarnings("serial")
@Entity
@Table(name = "receiver", catalog = "tana_shopping")
public class Receiver implements java.io.Serializable {
	private long orderId;
	private Order order;
	private String receiverName;
	private String address;
	private String province;
	private String zipCode;

	public Receiver() {
	}
	
	

	public Receiver(long orderId, Order order, String receiverName, String address, String province, String zipCode) {
		super();
		this.orderId = orderId;
		this.order = order;
		this.receiverName = receiverName;
		this.address = address;
		this.province = province;
		this.zipCode = zipCode;
	}



	@GenericGenerator(name = "generator", strategy = "foreign", parameters = @Parameter(name = "property", value = "order"))
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "order_id", unique = true, nullable = false)
	public long getOrderId() {
		return orderId;
	}

	public void setOrderId(long orderId) {
		this.orderId = orderId;
	}

	@OneToOne(fetch = FetchType.LAZY)
	@PrimaryKeyJoinColumn
	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
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
