package com.tana.Repositories;


import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.tana.entities.Account;
import com.tana.entities.Orders;

public interface OrdersRepository extends JpaRepository<Orders,Long>{
	
	@Query(value="SELECT * FROM orders o inner join account a on o.account_id = a.account_id WHERE o.order_status = ?1 and o.account_id = ?2",nativeQuery=true)
	Orders findByStatusAndAccountId(String orderStatus,long accountId);
	
	Orders findByStatus(String orderStatus);
	
	@Query(value = "SELECT * FROM orders o inner join account a on o.account_id = a.account_id WHERE o.order_status = 'ตะกร้า' and o.account_id = ?1",nativeQuery=true)
	Orders findCartByAccountId(long accountId);
	
	@Query(value = "SELECT * FROM orders o inner join account a on o.account_id = a.account_id WHERE o.order_status = ?1",nativeQuery=true)
	List<Orders> findOrderByOrderStatus(String orderStauts);
	
	@Query(value = "SELECT * FROM orders o inner join account a on o.account_id = a.account_id WHERE o.order_status != ?1",nativeQuery=true)
	List<Orders> findOrderByOrderStatusOnExcept(String orderStauts);
	
	Orders findByStatusAndCustomer(String orderStatus,Account customer);
	
	@EntityGraph(attributePaths = { "customer" })
	Orders findByOrderIdNotNull(long orderId); 
	
	Orders findByOrderId(long orderId);
	
	@Transactional
	@Modifying
	@Query(value = "UPDATE orders SET order_status = ?2 WHERE order_id = ?1",nativeQuery = true)
	void updateOrderStatusByOrderId(long orderId,String status);

	@Transactional
	@Modifying
	@Query(value = "DELETE FROM orderline WHERE order_id = ?1 and product_id = ?2",nativeQuery = true)
	void removeOrderByOrderIdAndProductId(long orderId,long productId);

}

