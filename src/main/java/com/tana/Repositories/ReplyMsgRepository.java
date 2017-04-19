package com.tana.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tana.entities.ReplyMessage;

public interface ReplyMsgRepository  extends JpaRepository<ReplyMessage,Long>{

}
