package com.cdp.health.ai.service;

import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import com.cdp.health.dto.ChatGptRequestDTO;
import com.cdp.health.dto.ChatGptResponseDTO;
import com.cdp.health.dto.DietRecommendationDTO;

@Service
public class ChatGptServiceImpl implements ChatGptService {

    private String apiKey = "API KEY"; // 실제 키는 환경변수로 관리하는 게 안전

    private static final String CHAT_GPT_URL = "https://api.openai.com/v1/chat/completions";

    @Override
    public DietRecommendationDTO getDietRecommendation(String userQuery) {
        DietRecommendationDTO result = new DietRecommendationDTO();
        result.setUserQuery(userQuery); // 사용자가 요청한 질문 저장

        try {
            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("Authorization", "Bearer " + apiKey);

            ChatGptRequestDTO requestDto = new ChatGptRequestDTO();
            requestDto.setModel("gpt-4o-mini"); // 사용할 모델 지정
            requestDto.getMessages().add(
                new ChatGptRequestDTO.Message("system",
                    "당신은 전문 영양사입니다. 사용자의 식단 관련 질문에 대해 건강하고 실용적인 조언을 제공해주세요.")
            );
            requestDto.getMessages().add(
                new ChatGptRequestDTO.Message("user", userQuery) // 실제 질문
            );

            HttpEntity<ChatGptRequestDTO> request = new HttpEntity<>(requestDto, headers);

            ResponseEntity<ChatGptResponseDTO> response = restTemplate.exchange(
                CHAT_GPT_URL,
                HttpMethod.POST,
                request,
                ChatGptResponseDTO.class
            );

            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                ChatGptResponseDTO responseBody = response.getBody();
                if (!responseBody.getChoices().isEmpty()) {
                    String recommendation = responseBody.getChoices().get(0).getMessage().getContent();
                    result.setRecommendation(recommendation);
                    result.setStatus("SUCCESS");
                } else {
                    result.setStatus("ERROR");
                    result.setErrorMessage("응답을 받지 못했습니다.");
                }
            } else {
                result.setStatus("ERROR");
                result.setErrorMessage("API 호출에 실패했습니다.");
            }

        } catch (Exception e) {
            result.setStatus("ERROR");
            result.setErrorMessage("오류 발생: " + e.getMessage());
            e.printStackTrace();
        }

        return result;
    }
}
