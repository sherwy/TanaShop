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
@Table(name = "contact_msg", catalog = "tana_shopping")
public class ContactMessage {
	private long id;
	private Timestamp datetime;
	private Account msgOwner;
	private String title;
	private String text;
	private ReplyMessage replyMsg;
	
	public ContactMessage(){}
	
	public ContactMessage(long id, Timestamp datetime, Account msgOwner, String title, String text,
			ReplyMessage replyMsg) {
		super();
		this.id = id;
		this.datetime = datetime;
		this.msgOwner = msgOwner;
		this.title = title;
		this.text = text;
		this.replyMsg = replyMsg;
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

	@Column(name = "contact_date")
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

	@Column(name="title",nullable=false)
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@Column(name="text",nullable=false)
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@OneToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="reply_id")
	public ReplyMessage getReplyMsg() {
		return replyMsg;
	}

	public void setReplyMsg(ReplyMessage replyMsg) {
		this.replyMsg = replyMsg;
	}
	
}
