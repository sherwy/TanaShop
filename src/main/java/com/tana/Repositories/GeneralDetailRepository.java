package com.tana.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.tana.entities.GeneralDetail;


public interface GeneralDetailRepository extends JpaRepository<GeneralDetail,Long>{
	
	@Query(value="SELECT * FROM general_shop_detail ORDER BY id DESC LIMIT 1",nativeQuery=true)
	GeneralDetail getLastest();
}
