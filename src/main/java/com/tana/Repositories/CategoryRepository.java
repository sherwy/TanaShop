package com.tana.Repositories;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.tana.entities.OrderCategory;

public interface CategoryRepository extends JpaRepository<OrderCategory,Long>{
	
	List<OrderCategory> findByCategoryId(long id);
	
	@Query(value="SELECT * FROM order_category WHERE parent_category_id is null",nativeQuery= true)
	List<OrderCategory> findParentCategory();
	
	@Query(value="SELECT * FROM order_category WHERE category_id = ?1",nativeQuery= true)
	OrderCategory findCategoryById(long id);
	
	@Transactional
	@Modifying
	@Query(value = "UPDATE order_category SET parent_category_id = null WHERE category_id = ?1",nativeQuery = true)
	void updateParentCategoryToNullByCategoryId(long categoryId);
}
