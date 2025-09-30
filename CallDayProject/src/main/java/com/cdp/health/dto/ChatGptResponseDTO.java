package com.cdp.health.dto;

import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
// ChatGPT API 응답용 DTO
public class ChatGptResponseDTO {

    private String id;          // 응답 ID
    private String object;      // 객체 타입 (예: "chat.completion")
    private long created;       // 생성 시간 (타임스탬프)
    private String model;       // 사용한 모델
    private List<Choice> choices; // 모델이 생성한 답변 리스트
    private Usage usage;        // 토큰 사용량 정보
    
    @Getter
    @Setter
    // 각 답변 선택지(Choice)
    public static class Choice {
        private int index;       // 선택지 순번
        private Message message; // 실제 메시지 내용
        private String finish_reason; // 응답 종료 이유 (예: stop, length 등)
    }
    
    @Getter
    @Setter
    // 메시지 단위
    public static class Message {
        private String role;     // 역할: system, user, assistant
        private String content;  // 메시지 내용
    }
    
    @Getter
    @Setter
    // 토큰 사용량 정보
    public static class Usage {
        private int prompt_tokens;     // 요청에 사용된 토큰 수
        private int completion_tokens; // 모델 응답에 사용된 토큰 수
        private int total_tokens;      // 총 사용된 토큰 수
    }
}
