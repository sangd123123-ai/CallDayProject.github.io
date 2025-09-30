package com.cdp.health.exercise.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.cdp.health.dto.ExerciseDTO;
import com.cdp.health.mapper.HealthMapper;

@Service
public class ExerciseServiceImpl implements ExerciseService {
    
    private final HealthMapper healthMapper;
    
     public ExerciseServiceImpl(HealthMapper healthMapper) { 
         this.healthMapper = healthMapper;
     } 
    
    @Override
    public List<ExerciseDTO> getExercisesByPart(String part) {
    	
        return healthMapper.getExercisesByPart(part);
    }
    
    @Override
    public ExerciseDTO getExerciseById(int exId) {
        return new ExerciseDTO(); // 임시 빈 객체 반환
    }
    
    @Override
    public void insertExercise(ExerciseDTO dto) {
        
    	healthMapper.insertExercise(dto);
        
    }
    
    @Override
    public void updateExercise(ExerciseDTO dto) {
       
    	healthMapper.updateExercise(dto);
    	
    }
    
    @Override
    public void deleteExercise(int exId) {
        
    	healthMapper.deleteExercise(exId);
    	
    }

	@Override
	public List<ExerciseDTO> getAllExercises() {
		
		return healthMapper.getAllExercises();
	}
}