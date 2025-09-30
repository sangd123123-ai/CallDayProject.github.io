package com.cdp.health.dto;

import lombok.Getter;
import lombok.Setter;
import java.util.List;
import java.util.ArrayList;

@Getter
@Setter
public class ChatGptRequestDTO {

    private String model;          // 사용할 모델 이름 (예: gpt-4o-mini)
    private List<Message> messages; // 대화 내용 리스트 (system, user, assistant 등 역할 포함)
    private int max_tokens;        // 응답 최대 토큰 수
    private double temperature;    // 창의성 정도 (0~1, 높을수록 다양하고 창의적인 답변)

    public ChatGptRequestDTO() {
        this.model = "gpt-4o-mini";      // 기본 모델 지정
        this.messages = new ArrayList<>(); // 빈 메시지 리스트 생성
        this.max_tokens = 1000;           // 최대 토큰 기본값
        this.temperature = 0.7;           // 기본 온도값
    }
    
    @Getter
    @Setter
    public static class Message {
        private String role;    // 역할: system, user, assistant
        private String content; // 실제 메시지 내용

        public Message(String role, String content) {
            this.role = role;
            this.content = content;
        }
    }
}
