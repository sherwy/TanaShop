package com.tana.entities;

import java.util.Date;
import java.util.List;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;

@SuppressWarnings("serial")
@Entity
@Table(name = "orders", catalog = "tana_shopping")
public class Orders implements java.io.Serializable {
	private long orderId;
	private Date datetime;
	private Account customer;
	private List<OrderLine> listProduct;
	private Receiver receiver;
	private String orderStatus;
	private Payment payment;

	public Orders() {
	}

	public Orders(long orderId, Date datetime, Account customer, List<OrderLine> listProduct, Receiver receiver,
			String orderStatus, Payment payment) {
		super();
		this.orderId = orderId;
		this.datetime = datetime;
		this.customer = customer;
		this.listProduct = listProduct;
		this.receiver = receiver;
		this.orderStatus = orderStatus;
		this.payment = payment;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "order_id", unique = true, nullable = false)
	public long getOrderId() {
		return orderId;
	}

	public void setOrderId(long orderId) {
		this.orderId = orderId;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "order_date", nullable = false)
	public Date getDatetime() {
		return datetime;
	}

	public void setDatetime(Date datetime) {
		this.datetime = datetime;
	}

	@Column(name = "order_status")
	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "account_id", nullable = false)
	@JsonBackReference
	public Account getCustomer() {
		return customer;
	}

	public void setCustomer(Account customer) {
		this.customer = customer;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "pk.orders", cascade = CascadeType.ALL)
	public List<OrderLine> getListProduct() {
		return listProduct;
	}

	public void setListProduct(List<OrderLine> listProduct) {
		this.listProduct = listProduct;
	}

	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JsonBackReference
	public Receiver getReceiver() {
		return receiver;
	}

	public void setReceiver(Receiver receiver) {
		this.receiver = receiver;
	}

	@OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JsonBackReference
	public Payment getPayment() {
		return payment;
	}

	public void setPayment(Payment payment) {
		this.payment = payment;
	}

}
