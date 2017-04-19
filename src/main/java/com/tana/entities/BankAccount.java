package com.tana.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "bank_account", catalog = "tana_shopping")
public class BankAccount {
	private long id;
	private String bankName;
	private String branch;
	private String bankAccountName;
	private String bankAccountNumber;
	private String bankAccountType;
	private List<Payment> payment;
	
	public BankAccount(){}
	
	public BankAccount(long id, String bankName, String bankAccountName, String bankAccountNumber,
			String bankAccountType, List<Payment> payment) {
		super();
		this.id = id;
		this.bankName = bankName;
		this.bankAccountName = bankAccountName;
		this.bankAccountNumber = bankAccountNumber;
		this.bankAccountType = bankAccountType;
		this.payment = payment;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public long getId() {
		return id;
	}
	
	public void setId(long id) {
		this.id = id;
	}
	
	@Column(name = "bank_name",nullable = false)
	public String getBankName() {
		return bankName;
	}
	
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	
	@Column(name = "bank_account_name",nullable = false)
	public String getBankAccountName() {
		return bankAccountName;
	}
	
	public void setBankAccountName(String bankAccountName) {
		this.bankAccountName = bankAccountName;
	}
	
	@Column(name = "bank_account_number",nullable = false)
	public String getBankAccountNumber() {
		return bankAccountNumber;
	}
	
	public void setBankAccountNumber(String bankAccountNumber) {
		this.bankAccountNumber = bankAccountNumber;
	}
	
	@Column(name = "bank_account_type",nullable = false)
	public String getBankAccountType() {
		return bankAccountType;
	}
	
	public void setBankAccountType(String bankAccountType) {
		this.bankAccountType = bankAccountType;
	}

	@OneToMany(fetch = FetchType.EAGER,mappedBy="bank")
	public List<Payment> getPayment() {
		return payment;
	}

	public void setPayment(List<Payment> payment) {
		this.payment = payment;
	}

	
	@Column(name = "branch",nullable = false)
	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}
	
	
	
}
