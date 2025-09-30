package com.cdp.health.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DietRecommendationDTO {
    private String userQuery;        // 사용자 질문
    private String recommendation;   // ChatGPT 응답
    private String status;          // 성공/실패 상태
    private String errorMessage;    // 에러 메시지 (있을 경우)
    
}