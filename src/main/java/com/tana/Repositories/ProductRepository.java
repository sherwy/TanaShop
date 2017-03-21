package com.tana.Repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.tana.entities.Product;

public interface ProductRepository  extends CrudRepository<Product,Long>{
	List<Product> findAll();
	
	Product findProductByProductId(long productId);
}
