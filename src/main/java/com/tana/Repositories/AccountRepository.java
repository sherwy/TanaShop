package com.tana.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.tana.entities.Account;

public interface AccountRepository extends JpaRepository<Account,Long>{
	List<Account> findAll();
	
	@Query(value="SELECT * FROM account WHERE account_id = ?1",nativeQuery=true)
	Account findByAccountId(long id);
	
	Account findByUsername(String username);
	
	@Query(value="SELECT * FROM account WHERE role <> ?1",nativeQuery=true)
	List<Account> findUserByExceptRole(String role);
	
	@Query(value="SELECT COUNT(order_status) FROM orders o INNER JOIN account a ON(o.account_id = a.account_id) WHERE a.account_id = ?1 and  o.order_status = ?2",nativeQuery=true)
	int findCountOnStatusByUser(long accId,String status);
}
