package com.cdp.health.weight.service;

import java.util.List;
import com.cdp.health.dto.WeightDTO;

public interface WeightService {
    
    // 체중 기록 추가
    void addWeightRecord(WeightDTO weightDTO);
    
    // 사용자별 체중 기록 조회
    List<WeightDTO> getWeightRecords(Long siteuserid);
    
    // 최근 체중 기록 조회 (차트용)
    List<WeightDTO> getRecentWeightRecords(Long siteuserid);
    
    // 체중 기록 수정
    void updateWeightRecord(WeightDTO weightDTO);
    
    // 체중 기록 삭제
    void deleteWeightRecord(int weightrecordid);
    
    // 체중 기록 단건 조회
    WeightDTO getWeightById(int weightrecordid);
}