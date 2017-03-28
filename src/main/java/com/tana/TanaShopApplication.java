package com.tana;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.web.filter.CharacterEncodingFilter;

@SpringBootApplication
public class TanaShopApplication {

	public static void main(String[] args) {
		SpringApplication.run(TanaShopApplication.class, args);
	}
	

}
