package com.cdp.health.board.service;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cdp.health.board.Board;

public interface BoardRepository extends JpaRepository<Board, Integer>{
	
	Board findByNum(Integer num);
	
}
