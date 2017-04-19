package com.tana.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tana.entities.BankAccount;


public interface BankAccountRepository extends JpaRepository<BankAccount,Long> {
	
}
