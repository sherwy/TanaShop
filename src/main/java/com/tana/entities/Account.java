package com.tana.entities;

import java.util.List;

import javax.persistence.*;

@SuppressWarnings("serial")
@Entity
@Table(name="account", catalog = "tana_shopping")
public class Account implements java.io.Serializable {
	private long accountId;
	private String username;
	private String password;
	private String firstName;
	private String lastName;
	private String gender;
	private String birthDate;
	private String telephoneNumber;
	private List<Order> listOrder;
	
	public Account(){}
	
	public Account(long accountId, String username, String password, String firstName, String lastName, String gender,
			String birthDate, String telephoneNumber, List<Order> listOrder) {
		super();
		this.accountId = accountId;
		this.username = username;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
		this.gender = gender;
		this.birthDate = birthDate;
		this.telephoneNumber = telephoneNumber;
		this.listOrder = listOrder;
	}



	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="account_id",unique=true,nullable=false)
	public long getAccountId() {
		return accountId;
	}
	public void setAccountId(long id) {
		this.accountId = id;
	}

	@Column(name="username",unique=true,nullable=false)
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name="password",nullable=false)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	@Column(name="first_name",nullable=false)
	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	
	@Column(name="last_name",nullable=false)
	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	@Column(name="gender",nullable=false)
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	@Column(name="birthdate",nullable=false)
	public String getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	
	@Column(name="telephone_number",unique=true,nullable=false)
	public String getTelephoneNumber() {
		return telephoneNumber;
	}

	public void setTelephoneNumber(String telephoneNumber) {
		this.telephoneNumber = telephoneNumber;
	}
	
	@OneToMany(fetch=FetchType.LAZY,mappedBy="customer")
	public List<Order> getListOrder() {
		return listOrder;
	}

	public void setListOrder(List<Order> listOrder) {
		this.listOrder = listOrder;
	}
	
	
	
	
}
