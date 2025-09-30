package com.cdp.health.dto;


import lombok.Data;

@Data
public class ProductDTO {
	
	
	    private Long id;
	    private String title;         // 상품명
	    private String content;   // 상품 설명
		private String saveFileName;      //서버 저장 파일명
		private String originalFileName;  //원본 파일명
	    private String linkUrl;       // 구매/상세 페이지 링크
	    private int price;            // 가격


}
