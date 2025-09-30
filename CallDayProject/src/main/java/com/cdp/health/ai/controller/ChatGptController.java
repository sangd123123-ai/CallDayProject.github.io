package com.cdp.health.ai.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.cdp.health.ai.service.ChatGptService;
import com.cdp.health.dto.DietRecommendationDTO;

@Controller
@RequestMapping("/ai")
public class ChatGptController {
    
    @Autowired
    private ChatGptService chatGptService;
    
    @RequestMapping(value="/diet", method=RequestMethod.GET)
    public String dietRecommendationPage() {
        return "diet-recommendation";
    }
    
    @RequestMapping(value="/diet/recommend", method=RequestMethod.POST)
    public String getDietRecommendation(
            HttpServletRequest request,
            @RequestParam(value="userQuery", required=false) String userQuery,
            Model model) {
        
        System.out.println("=== 컨트롤러 호출됨 ===");
        System.out.println("받은 userQuery: [" + userQuery + "]");
        System.out.println("userQuery 길이: " + (userQuery != null ? userQuery.length() : "null"));
        
        System.out.println("=== 모든 파라미터 ===");
        request.getParameterMap().forEach((key, value) -> {
            System.out.println(key + ": " + String.join(", ", value));
        });
        
        try {
            if (userQuery == null || userQuery.trim().isEmpty()) {
                userQuery = "사용자 정보가 제공되지 않았습니다. 일반적인 건강한 식단을 추천해주세요.";
            }
            
            DietRecommendationDTO recommendation = chatGptService.getDietRecommendation(userQuery);
            model.addAttribute("recommendation", recommendation);
            
        } catch (Exception e) {
            System.err.println("에러 발생: " + e.getMessage());
            e.printStackTrace();
            
            DietRecommendationDTO errorRecommendation = new DietRecommendationDTO();
            errorRecommendation.setStatus("ERROR");
            errorRecommendation.setErrorMessage("추천을 받아오는 중 오류가 발생했습니다: " + e.getMessage());
            errorRecommendation.setUserQuery(userQuery);
            model.addAttribute("recommendation", errorRecommendation);
        }
        
        return "diet-recommendation";
    }
}