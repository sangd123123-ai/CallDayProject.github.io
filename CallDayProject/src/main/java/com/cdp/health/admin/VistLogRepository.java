package com.cdp.health.admin;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cdp.health.entity.Vist_logEntity;

//홈페이지 방문자 수 인서트는 jpa,집계는 마이바티스로 할거임
public interface VistLogRepository extends JpaRepository<Vist_logEntity, Long>{

}
