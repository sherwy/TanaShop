package com.tana.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.tana.entities.Product;

public interface ProductRepository  extends CrudRepository<Product,Long>{
	List<Product> findAll();
	
	Product findProductByProductId(long productId);
	
	@Query(value="SELECT * FROM orderline ol INNER JOIN product p ON ol.product_id = p.product_id WHERE p.product_id = ?1",nativeQuery=true)
	List<Product> findProductInOrder(long productId);
	
	List<Product> findProductByStatus(String staus);
	
	@Query(value="SELECT * FROM product p  WHERE p.status <> ?1",nativeQuery=true)
	List<Product> findProductExceptStatus(String status);
}
