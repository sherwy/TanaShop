package com.tana.Repositories;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.tana.entities.OrderLine;

public interface OrderLineRepository extends JpaRepository<OrderLine,Long>{
	
	@Transactional
	@Modifying
	@Query(value = "UPDATE orderline SET amount = ?1 WHERE order_id = ?2 and product_id = ?3",nativeQuery = true)
	void updateAmountByOrderIdAndProductId(int amount,long orderId,long productId);
}
