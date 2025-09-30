package com.cdp.health.ai.service;

import com.cdp.health.dto.DietRecommendationDTO;

public interface ChatGptService {

    DietRecommendationDTO getDietRecommendation(String userQuery);
}
