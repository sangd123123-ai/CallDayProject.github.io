package com.cdp.health.admin;

import org.springframework.data.jpa.repository.JpaRepository;
import com.cdp.health.entity.SliderEntity;

//관리자 배너,스토어 관리
public interface SliderRepository extends JpaRepository<SliderEntity, Long>{

}
