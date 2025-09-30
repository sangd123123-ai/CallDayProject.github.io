package com.cdp.health.board.answer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cdp.health.board.Board;
import com.cdp.health.dto.answer.Answer;
import com.cdp.health.mapper.answer.AnswerMapper;
import com.cdp.health.user.SiteUser;

@Service
public class AnswerServiceImpl implements AnswerService {//repository를 불러옴
    
	@Autowired
    private AnswerMapper answerMapper;
	@Autowired
	private AnswerRepository answerRepository;

	public void setAnswerRepository(AnswerRepository answerRepository) {
		this.answerRepository = answerRepository;
	}
	
    @Override
    public Answer getAnswer(int num)throws Exception {
        return answerMapper.getAnswer(num);
    }
    
    @Override
    public void createAnswer(Answer answer)throws Exception{
    	answerMapper.createAnswer(answer);
    }

    @Override
    public List<Answer> getAnswerList(int boardNum)throws Exception {
        return answerMapper.getAnswerList(boardNum);
    }
    
    @Override
    public void modify(Answer answer) throws Exception{
    	answerMapper.modify(answer);
    }

    @Override
    public void delete(int num)throws Exception {
    	answerMapper.delete(num);
    }

	@Override
	public void deleteBoardByNum(int boardNum) throws Exception {
		answerMapper.deleteBoardByNum(boardNum);
	}

	@Override
	public int maxNum() throws Exception {
		int maxNum = answerMapper.maxNum();
		return maxNum;
	}

}