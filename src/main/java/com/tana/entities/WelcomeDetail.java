package com.tana.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="welcome_detail" , catalog="tana_shopping")
public class WelcomeDetail {
	private long id;
	private String welcomeText;
	
	public WelcomeDetail(){}

	public WelcomeDetail(long id, String welcomeText) {
		super();
		this.id = id;
		this.welcomeText = welcomeText;
	}
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id",unique=true,nullable=false)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(name="welcome_text")
	public String getWelcomeText() {
		return welcomeText;
	}

	public void setWelcomeText(String welcomeText) {
		this.welcomeText = welcomeText;
	}
	
	
	
	
	
	
	
	
}
