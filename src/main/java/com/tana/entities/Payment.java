package com.tana.entities;

import java.util.Date;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@SuppressWarnings("serial")
@Entity
@Table(name="payment" , catalog="tana_shopping")
public class Payment implements java.io.Serializable {
	private long id;
	private String paymentMins;
	private String paymentHour;
	private Date paymentDate;
	private String bank;
	private String imgUrl;
	private Orders order;
	public Payment(){}

	public Payment(long id, String paymentMins, String paymentHour, Date paymentDate, String bank, String imgUrl,
			Orders order) {
		super();
		this.id = id;
		this.paymentMins = paymentMins;
		this.paymentHour = paymentHour;
		this.paymentDate = paymentDate;
		this.bank = bank;
		this.imgUrl = imgUrl;
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
	
	@Column(name="payment_mins",nullable=false)
	public String getPaymentMins() {
		return paymentMins;
	}

	public void setPaymentMins(String paymentMins) {
		this.paymentMins = paymentMins;
	}
	
	@Column(name="payment_hour",nullable=false)
	public String getPaymentHour() {
		return paymentHour;
	}

	public void setPaymentHour(String paymentHour) {
		this.paymentHour = paymentHour;
	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "payment", cascade = CascadeType.ALL)
	@JsonManagedReference
	public Orders getOrder() {
		return order;
	}

	public void setOrder(Orders order) {
		this.order = order;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "payment_date", nullable = false)
	public Date getPaymentDate() {
		return paymentDate;
	}
	
	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}

	@Column(name="payment_img" , nullable = false)
	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	
	@Column(name="payment_bank" , nullable=false)
	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}
	
	
}
