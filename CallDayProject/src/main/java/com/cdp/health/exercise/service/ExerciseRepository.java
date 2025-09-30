package com.cdp.health.exercise.service;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cdp.health.exercise.Exercise;


public interface ExerciseRepository extends JpaRepository<Exercise, Integer> {

	
	
}

