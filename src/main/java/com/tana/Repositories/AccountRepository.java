package com.tana.Repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.tana.entities.Account;

public interface AccountRepository extends CrudRepository<Account,Long>{
	List<Account> findAll();
	
	Account findByUsername(String username);
}
