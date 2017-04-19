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
	
	@Query(value = "SELECT * FROM orders o inner join account a on o.account_id = a.account_id WHERE o.order_status = ?1 and a.account_id = ?2",nativeQuery=true)
	List<Orders> findOrderByOrderStatus(String orderStauts,long accId);
	
	
	@Query(value = "SELECT * FROM orders o inner join account a on o.account_id = a.account_id WHERE o.order_status = ?1 or o.order_status = ?2",nativeQuery=true)
	List<Orders> findOrderByOrderStatus(String orderStauts,String orderStatus_2);
	
	@Query(value = "SELECT * FROM orders o inner join account a on o.account_id = a.account_id WHERE o.order_status != ?1",nativeQuery=true)
	List<Orders> findOrderByOrderStatusOnExcept(String orderStauts);
	
	@Query(value="SELECT  (p.product_price * ol.amount) FROM orders o INNER JOIN orderline ol ON (o.order_id = ol.order_id) INNER JOIN product p ON (ol.product_id = p.product_id) WHERE o.order_id = ?1",nativeQuery=true)
	double findTotalAmountByOrderId(long orderId);
	
	@Query(value="SELECT * FROM account a INNER JOIN orders o ON (a.account_id = o.account_id) WHERE a.account_id = ?1",nativeQuery=true)
	List<Orders> findOrdersByAccountId(long accountId);
	
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
	@Query(value = "UPDATE orders SET other_amount = ?2 WHERE order_id = ?1",nativeQuery = true)
	void updateAmountByOrderId(long orderId,int amount);
	
	@Transactional
	@Modifying
	@Query(value = "DELETE FROM orderline WHERE order_id = ?1 and product_id = ?2",nativeQuery = true)
	void removeOrderByOrderIdAndProductId(long orderId,long productId);

}

