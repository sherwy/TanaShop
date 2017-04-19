package com.tana.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.tana.entities.ContactMessage;

public interface ContactRepository extends JpaRepository<ContactMessage,Long>{
	
	ContactMessage findById(long id);
	
	@Query(value="SELECT * FROM contact_msg WHERE account_id = ?1",nativeQuery=true)
	List<ContactMessage> findMsgByAccountId(long id);
	
	@Query(value="SELECT * FROM contact_msg WHERE reply_id is null",nativeQuery=true)
	List<ContactMessage> findMsgThatDidntReply();
}
