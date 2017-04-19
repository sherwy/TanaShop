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
	private Payment payment;
	private String status;
	private Delivery delivery;
	private int otherAmount;
	
	public Orders() {
	}

	public Orders(long orderId, Date datetime, Account customer, List<OrderLine> listProduct, Payment payment,
			String status, Delivery delivery, int otherAmount) {
		super();
		this.orderId = orderId;
		this.datetime = datetime;
		this.customer = customer;
		this.listProduct = listProduct;
		this.payment = payment;
		this.status = status;
		this.delivery = delivery;
		this.otherAmount = otherAmount;
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

	@OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@JsonBackReference
	public Payment getPayment() {
		return payment;
	}

	public void setPayment(Payment payment) {
		this.payment = payment;
	}

	@Column(name="order_status",nullable=false)
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	@OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JsonBackReference
	public Delivery getDelivery() {
		return delivery;
	}

	public void setDelivery(Delivery delivery) {
		this.delivery = delivery;
	}

	@Column(name = "other_amount", nullable = true)
	public int getOtherAmount() {
		return otherAmount;
	}

	public void setOtherAmount(int otherAmount) {
		this.otherAmount = otherAmount;
	}
	
	public double calPrice(){
		double total = otherAmount;
		for(OrderLine orderLine : listProduct){
			int amount = orderLine.getAmount();
			double price = orderLine.getPk().getProduct().getPrice();
			total += (amount*price);
		}
		return total;
	}

}
