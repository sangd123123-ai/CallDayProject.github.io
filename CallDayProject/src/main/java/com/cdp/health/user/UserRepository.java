package com.cdp.health.user;

import java.util.Optional;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<SiteUser, Long>{

	Optional<SiteUser> findByUserId(String userId);
	
	 @Query("SELECT CASE WHEN COUNT(u) > 0 THEN true ELSE false END FROM SiteUser u WHERE u.userId = :userId")
	  boolean existsByUserId(@Param("userId") String userId);

    @Query("SELECT CASE WHEN COUNT(u) > 0 THEN true ELSE false END FROM SiteUser u WHERE u.email = :email")
    boolean existsByEmail(@Param("email") String email);

	
}