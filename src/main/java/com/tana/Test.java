package com.tana;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.tana.entities.Account;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Account acc = new Account();
		acc.setFirstName("Tana");
		GsonBuilder builder = new GsonBuilder();
        Gson gson = builder.create();
        System.out.println(gson.toJson(acc));
        
        
	}

}
