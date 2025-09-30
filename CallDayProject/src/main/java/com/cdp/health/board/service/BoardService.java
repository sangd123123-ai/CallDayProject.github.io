package com.cdp.health.board.service;

import java.util.List;

import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import com.cdp.health.board.Board;
import com.cdp.health.dto.HealthDTO;

@Service
public interface BoardService {
	
	public int maxNum() throws Exception;
	
	public void insertData(Board board) throws Exception;
	
	public int getDataCount(String searchKey, String searchValue) throws Exception;

	public List<HealthDTO> getLists(int start, int end, String searchKey, String searchValue) throws Exception;	
	
	public HealthDTO getReadData(int num) throws Exception;
	
	public void updateData(HealthDTO dto) throws Exception;

	public void deleteData(int num) throws Exception;
	
	void insertBoardLike(@Param("boardNum") int boardNum,
            @Param("voterId") Long voterId);
	
	void deleteBoardLike(int boardNum, Long voterId);

	
}