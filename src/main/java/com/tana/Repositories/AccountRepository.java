package com.tana.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tana.entities.Account;

public interface AccountRepository extends JpaRepository<Account,Long>{
	List<Account> findAll();
	
	Account findByAccountId(long id);
	
	Account findByUsername(String username);
	
	
}
