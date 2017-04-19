package com.tana.entities;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name = "reply_msg", catalog = "tana_shopping")
public class ReplyMessage {
	private long id;
	private Timestamp datetime;
	private Account msgOwner;
	private ContactMessage issueMsg;
	private String text;
	
	public ReplyMessage(){}

	public ReplyMessage(long id, Timestamp datetime, Account msgOwner, ContactMessage issueMsg, String text) {
		super();
		this.id = id;
		this.datetime = datetime;
		this.msgOwner = msgOwner;
		this.issueMsg = issueMsg;
		this.text = text;
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

	@Column(name = "reply_date")
	public Timestamp getDatetime() {
		return datetime;
	}

	public void setDatetime(Timestamp datetime) {
		this.datetime = datetime;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "account_id", nullable = false)
	@JsonBackReference
	public Account getMsgOwner() {
		return msgOwner;
	}

	public void setMsgOwner(Account msgOwner) {
		this.msgOwner = msgOwner;
	}

	@OneToOne(fetch=FetchType.LAZY, mappedBy="replyMsg")
	public ContactMessage getIssueMsg() {
		return issueMsg;
	}

	public void setIssueMsg(ContactMessage issueMsg) {
		this.issueMsg = issueMsg;
	}

	@Column(name="text",nullable=false)
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	
	
}
