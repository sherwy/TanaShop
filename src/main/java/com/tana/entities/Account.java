package com.tana.entities;

import java.util.List;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@SuppressWarnings("serial")
@Entity
@Table(name = "account", catalog = "tana_shopping")
public class Account implements java.io.Serializable {
	private long accountId;
	private String username;
	private String imgUrl;
	private String password;
	private String firstName;
	private String lastName;
	private String telephoneNumber;
	private String address;
	private String zipcode;
	private String role;
	private String email;
	private List<Orders> listOrder;
	private List<ContactMessage> listContactMsg;
	private List<ReplyMessage> listReplyMsg;
	
	public Account() {
	}

	public Account(long accountId, String username, String imgUrl, String password, String firstName, String lastName,
			String telephoneNumber, String address, String zipcode, String role, String email, List<Orders> listOrder) {
		super();
		this.accountId = accountId;
		this.username = username;
		this.imgUrl = imgUrl;
		this.password = password;
		this.firstName = firstName;
		this.lastName = lastName;
		this.telephoneNumber = telephoneNumber;
		this.address = address;
		this.zipcode = zipcode;
		this.role = role;
		this.email = email;
		this.listOrder = listOrder;
	}

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "account_id", unique = true, nullable = false)
	public long getAccountId() {
		return accountId;
	}

	public void setAccountId(long id) {
		this.accountId = id;
	}

	@Column(name = "username", unique = true, nullable = false)
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "password", nullable = false)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "first_name", nullable = false)
	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	@Column(name = "last_name", nullable = false)
	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	@Column(name = "telephone_number", unique = true, nullable = false)
	public String getTelephoneNumber() {
		return telephoneNumber;
	}

	public void setTelephoneNumber(String telephoneNumber) {
		this.telephoneNumber = telephoneNumber;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "customer")
	@JsonManagedReference
	public List<Orders> getListOrder() {
		return listOrder;
	}

	public void setListOrder(List<Orders> listOrder) {
		this.listOrder = listOrder;
	}

	@Column(name = "role", nullable = false)
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Column(name = "img_url", nullable = false)
	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	@Column(name = "address", nullable = false)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "zipcode", nullable = false)
	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	@Column(name = "email", nullable = false ,unique = true)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "msgOwner")
	@JsonManagedReference
	public List<ContactMessage> getListContactMsg() {
		return listContactMsg;
	}

	public void setListContactMsg(List<ContactMessage> listContactMsg) {
		this.listContactMsg = listContactMsg;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "msgOwner")
	@JsonManagedReference
	public List<ReplyMessage> getListReplyMsg() {
		return listReplyMsg;
	}

	public void setListReplyMsg(List<ReplyMessage> listReplyMsg) {
		this.listReplyMsg = listReplyMsg;
	}
	
	
}
