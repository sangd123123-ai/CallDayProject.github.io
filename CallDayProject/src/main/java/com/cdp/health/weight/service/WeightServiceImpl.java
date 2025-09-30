package com.cdp.health.weight.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cdp.health.dto.WeightDTO;
import com.cdp.health.mapper.HealthMapper;



@Service
@Transactional
public class WeightServiceImpl implements WeightService {
    
    @Autowired
    private HealthMapper weightMapper;
    
    @Override
    public void addWeightRecord(WeightDTO weightDTO) {
        weightMapper.insertWeightRecord(weightDTO);
    }
    
    @Override
    public List<WeightDTO> getWeightRecords(Long siteuserid) {
        return weightMapper.getWeightRecordsBySiteuserid(siteuserid);
    }
    
    @Override
    public List<WeightDTO> getRecentWeightRecords(Long siteuserid) {
        return weightMapper.getRecentWeightRecords(siteuserid);
    }
    
    @Override
    public void updateWeightRecord(WeightDTO weightDTO) {
        weightMapper.updateWeightRecord(weightDTO);
    }
    
    @Override
    public void deleteWeightRecord(int weightrecordid) {
        weightMapper.deleteWeightRecord(weightrecordid);
    }
    
    @Override
    public WeightDTO getWeightById(int weightrecordid) {
        return weightMapper.getWeightRecordById(weightrecordid);
    }
}