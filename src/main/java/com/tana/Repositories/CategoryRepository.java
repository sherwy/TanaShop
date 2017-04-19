package com.tana.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.tana.entities.OrderCategory;

public interface CategoryRepository extends JpaRepository<OrderCategory,Long>{
	
	List<OrderCategory> findByCategoryId(long id);
	
	@Query(value="SELECT * FROM order_category WHERE parent_category_id is null",nativeQuery= true)
	List<OrderCategory> findParentCategory();
	
	@Query(value="SELECT * FROM order_category WHERE category_id = ?1",nativeQuery= true)
	OrderCategory findCategoryById(long id);
}
