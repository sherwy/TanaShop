package com.tana.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.tana.entities.WelcomeDetail;


public interface WelcomeDetailRepository extends JpaRepository<WelcomeDetail,Long>{
	
	@Query(value="SELECT * FROM welcome_detail ORDER BY id DESC LIMIT 1",nativeQuery=true)
	WelcomeDetail getLastest();

}
