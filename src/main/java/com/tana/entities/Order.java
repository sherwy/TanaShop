package com.tana.entities;

import java.util.Date;
import java.util.List;

import javax.persistence.*;


@SuppressWarnings("serial")
@Entity
@Table(name="order", catalog = "tana_shopping")
public class Order implements java.io.Serializable {
	private long orderId;
	private Date datetime;
	private Account customer;
	private List<OrderLine> listProduct;
	private Receiver receiver;
	
	public Order(){}
	
	public Order(long orderId, Date datetime, Account customer, List<OrderLine> listProduct, Receiver receiver) {
		super();
		this.orderId = orderId;
		this.datetime = datetime;
		this.customer = customer;
		this.listProduct = listProduct;
		this.receiver = receiver;
	}



	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="order_id",unique=true,nullable=false)
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
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="account_id",nullable=false)
	public Account getCustomer() {
		return customer;
	}

	public void setCustomer(Account customer) {
		this.customer = customer;
	}
	
	@OneToMany(fetch=FetchType.EAGER,mappedBy="pk.order",cascade=CascadeType.ALL) 
	public List<OrderLine> getListProduct() {
		return listProduct;
	}

	public void setListProduct(List<OrderLine> listProduct) {
		this.listProduct = listProduct;
	}
	
	@OneToOne(fetch=FetchType.EAGER,mappedBy="order", cascade = CascadeType.ALL)
	public Receiver getReceiver() {
		return receiver;
	}

	public void setReceiver(Receiver receiver) {
		this.receiver = receiver;
	}
	
	
}
