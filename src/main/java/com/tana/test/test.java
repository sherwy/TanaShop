package com.tana.test;

import com.google.gson.Gson;
import com.tana.entities.GeneralDetail;
import com.tana.utilities.JsonReader;

public class test {

	public static void main(String[] args) throws Exception {

		String json = JsonReader.readUrl("http://localhost:8081/generalDetailShop");

		Gson gson = new Gson();
		GeneralDetail general = gson.fromJson(json, GeneralDetail.class);

		System.out.println(general.getShopName());
		
	}

}
