package com.tana.entities;

import java.util.List;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;

@SuppressWarnings("serial")
@Entity
@Table(name="bank" , catalog = "tana_shopping")
public class Bank implements java.io.Serializable {
	private long id;
	private String bankName;
	private List<Payment> listPayment;
	
	public Bank(){}
	
	public Bank(long id, String bankName,List<Payment> listPayment) {
		super();
		this.id = id;
		this.bankName = bankName;
		this.listPayment = listPayment;
	}
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="bank_id",unique=true,nullable=false)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	@Column(name="bank_name",unique=true,nullable=false)
	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	@OneToMany(cascade=CascadeType.ALL,mappedBy="bank")
	@JsonBackReference
	public List<Payment> getListPayment() {
		return listPayment;
	}

	public void setListPayment(List<Payment> listPayment) {
		this.listPayment = listPayment;
	}
	
	
}
