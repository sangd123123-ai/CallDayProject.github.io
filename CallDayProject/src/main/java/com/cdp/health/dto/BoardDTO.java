package com.cdp.health.dto;

import lombok.Data;

@Data
//좋아요 통계 받기 위한 DTO
public class BoardDTO {
	
	private Integer num;       // 게시글 번호
    private String subject;    // 제목
    private int likeCount;     // 좋아요 수
    private String saveFileName; // 이미지 경로

}
