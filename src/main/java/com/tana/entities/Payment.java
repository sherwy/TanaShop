package com.tana.entities;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@SuppressWarnings("serial")
@Entity
@Table(name="payment" , catalog="tana_shopping")
public class Payment implements java.io.Serializable {
	private long id;
	private String paymentMins;
	private String paymentHour;
	private String accountNumber;
	private Bank bank;
	private Orders order;
	public Payment(){}
	
	
	public Payment(long id, String paymentMins, String paymentHour, String accountNumber, Bank bank, Orders order) {
		super();
		this.id = id;
		this.paymentMins = paymentMins;
		this.paymentHour = paymentHour;
		this.accountNumber = accountNumber;
		this.bank = bank;
		this.order = order;
	}


	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="payment_id",unique=true,nullable=false)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	@Column(name="payment_mins",unique=true,nullable=false)
	public String getPaymentMins() {
		return paymentMins;
	}

	public void setPaymentMins(String paymentMins) {
		this.paymentMins = paymentMins;
	}
	
	@Column(name="payment_hour",unique=true,nullable=false)
	public String getPaymentHour() {
		return paymentHour;
	}

	public void setPaymentHour(String paymentHour) {
		this.paymentHour = paymentHour;
	}

	@Column(name="account_number",unique=true,nullable=false)
	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="bank_id",nullable=false)
	@JsonManagedReference
	public Bank getBank() {
		return bank;
	}

	public void setBank(Bank bank) {
		this.bank = bank;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "payment", cascade = CascadeType.ALL)
	@JsonManagedReference
	public Orders getOrder() {
		return order;
	}


	public void setOrder(Orders order) {
		this.order = order;
	}
	
	
}
