package com.tana.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.tana.entities.GeneralDetail;


public interface GeneralDetailRepository extends JpaRepository<GeneralDetail,Long>{
	
	@Query(value="SELECT * FROM tana_shopping.general_shop_detail ORDER BY date_changed LIMIT 1",nativeQuery=true)
	public GeneralDetail getLastest();
}
