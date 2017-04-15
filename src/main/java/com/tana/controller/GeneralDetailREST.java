package com.tana.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.tana.Repositories.GeneralDetailRepository;
import com.tana.Repositories.WelcomeDetailRepository;
import com.tana.entities.GeneralDetail;
import com.tana.entities.WelcomeDetail;

@RestController
@RequestMapping("/rest")
public class GeneralDetailREST {
	
	private Logger LOGGER = Logger.getLogger(GeneralDetailREST.class);
	
	@Autowired
	private GeneralDetailRepository generalDetailManager;

	@Autowired
	private WelcomeDetailRepository welcomeDetailManager;
	
	@RequestMapping(value="/generalDetailShop",method = RequestMethod.GET)
	public ResponseEntity<GeneralDetail> getDetail() {
		GeneralDetail detail = generalDetailManager.getLastest();
		if(detail == null){
			detail = new GeneralDetail();
			detail.setShopName("Tana");
			detail.setShopDetail("EverydayKPop shop");
			detail.setShopDescription("Korean");
			try {
				detail.setDateChanged(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss Z").parse(new Date().toString()));
			} catch (ParseException e) {
				detail.setDateChanged(null);
			}
			detail.setEmail("tanabodee.l@outlook.com");
		}
		return new ResponseEntity<>(detail,HttpStatus.OK);
	}
	
	@RequestMapping(value="/welcomeDetail",method = RequestMethod.GET)
	public ResponseEntity<WelcomeDetail> getWelcomeDetail() {
		WelcomeDetail detail = welcomeDetailManager.getLastest();
		if(detail == null){
			detail = new WelcomeDetail();
			detail.setWelcomeText("<b>Welcome to my shop</b>");
		}
		return new ResponseEntity<>(detail,HttpStatus.OK);
	}
	
	
}
