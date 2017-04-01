package com.tana.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tana.entities.Payment;


public interface PaymentRepository extends JpaRepository<Payment,Long>{

}
