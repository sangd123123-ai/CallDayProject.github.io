package com.cdp.health.admin;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cdp.health.entity.ProductEntity;

public interface ProductRepository extends JpaRepository<ProductEntity, Long>{

}
