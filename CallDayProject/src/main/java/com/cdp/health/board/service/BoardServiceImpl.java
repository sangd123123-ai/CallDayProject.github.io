package com.cdp.health.board.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cdp.health.board.Board;
import com.cdp.health.board.answer.AnswerService;
import com.cdp.health.dto.HealthDTO;
import com.cdp.health.mapper.HealthMapper;
import com.cdp.health.mapper.answer.AnswerMapper;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private HealthMapper healthMapper;
	@Autowired
	private AnswerService answerService;
	
	private BoardRepository boardRepository;
	
	public void setBoardRepository(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}

	@Override
	public int maxNum() throws Exception {
		return healthMapper.maxNum();
	}

	@Override
	public void insertData(Board board) throws Exception {
		healthMapper.insertData(board);
	}

	@Override
	public int getDataCount(String searchKey, String searchValue) throws Exception {
		return healthMapper.getDataCount(searchKey, searchValue);
	}

	@Override
	public List<HealthDTO> getLists(int start, int end, String searchKey, String searchValue) throws Exception {
		return healthMapper.getLists(start, end, searchKey, searchValue);
	}	
	
	@Override
	public HealthDTO getReadData(int num) throws Exception {
		return healthMapper.getReadData(num);
	}

	@Override
	public void updateData(HealthDTO dto) throws Exception {
		healthMapper.updateData(dto);
	}
	
	@Override
    @Transactional
    public void deleteData(int num) throws Exception {
		
		//좋아요 삭제
		healthMapper.deleteBoardLikes(num);
		
        //댓글 삭제
        answerService.deleteBoardByNum(num);

        //게시글 삭제
        healthMapper.deleteData(num);
    }

	@Override
	public void insertBoardLike(int boardNum, Long voterId) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBoardLike(int boardNum, Long voterId) {
		// TODO Auto-generated method stub
		
	}

}