package com.cdp.health.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class ProductEntity {

	 @Id
	    @GeneratedValue(strategy = GenerationType.AUTO)
	    private Long id;

	    @Column(nullable=false, length=50)
	    private String title;         // 상품명

	    @Column(length = 2000)
	    private String content;   // 상품 설명

	    @Column(length = 255, nullable = false)
		private String saveFileName;      //서버 저장 파일명

		@Column(length = 255, nullable = false)
		private String originalFileName;  //원본 파일명

	    @Column(length=255)
	    private String linkUrl;       // 구매/상세 페이지 링크

	    @Column
	    private int price;            // 가격


}