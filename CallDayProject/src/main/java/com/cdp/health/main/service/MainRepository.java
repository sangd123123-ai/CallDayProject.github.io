package com.cdp.health.main.service;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cdp.health.user.SiteUser;

public interface MainRepository extends JpaRepository<SiteUser, Long>{
	
	Optional<SiteUser> findByUserId(String userId);

}
