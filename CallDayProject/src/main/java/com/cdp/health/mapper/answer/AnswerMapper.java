package com.cdp.health.mapper.answer;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.cdp.health.board.Board;
import com.cdp.health.dto.answer.Answer;
import com.cdp.health.user.SiteUser;

@Mapper
@Repository
public interface AnswerMapper {
	
	//1개 댓글 조회
	public Answer getAnswer(int num) throws Exception ;
	
	//댓글 삽입
	public void createAnswer(Answer answer) throws Exception;
	
	//특정 게시글 댓글 목록 조회
	public List<Answer> getAnswerList(int boardNum) throws Exception;
	
	//댓글 수정
	public void modify(Answer answer) throws Exception;
	
	//댓글 삭제
	public void delete(int num) throws Exception;
	
	//게시글 삭제
	public void deleteBoardByNum(int boardNum) throws Exception;

	public int maxNum() throws Exception;

}
