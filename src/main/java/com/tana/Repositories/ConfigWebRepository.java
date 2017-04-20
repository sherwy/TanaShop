package com.tana.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.tana.entities.ConfigWeb;

public interface ConfigWebRepository  extends JpaRepository<ConfigWeb,Long>{
	@Query(value="SELECT * FROM config_web ORDER BY id DESC LIMIT 1",nativeQuery=true)
	ConfigWeb getLastest();
}
