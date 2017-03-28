package com.tana.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="bank_account" , catalog="tana_shopping")
public class BankAccount {
	private long bankAccountId;
	private String bankAccountNumber;
	private String bankAccountName;
	private String bankAccountType;
	
	public BankAccount(long bankAccountId, String bankAccountNumber, String bankAccountName, String bankAccountType,
			Account account, Orders order) {
		super();
		this.bankAccountId = bankAccountId;
		this.bankAccountNumber = bankAccountNumber;
		this.bankAccountName = bankAccountName;
		this.bankAccountType = bankAccountType;
		
	}
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="bank_account_id",unique=true,nullable=false)
	public long getBankAccountId() {
		return bankAccountId;
	}
	public void setBankAccountId(long bankAccountId) {
		this.bankAccountId = bankAccountId;
	}
	
	@Column(name="bank_account_number",unique=true,nullable=false)
	public String getBankAccountNumber() {
		return bankAccountNumber;
	}
	public void setBankAccountNumber(String bankAccountNumber) {
		this.bankAccountNumber = bankAccountNumber;
	}
	
	@Column(name="bank_account_name",nullable=false)
	public String getBankAccountName() {
		return bankAccountName;
	}
	public void setBankAccountName(String bankAccountName) {
		this.bankAccountName = bankAccountName;
	}
	
	@Column(name="bank_account_type")
	public String getBankAccountType() {
		return bankAccountType;
	}
	public void setBankAccountType(String bankAccountType) {
		this.bankAccountType = bankAccountType;
	}

	
	
}
