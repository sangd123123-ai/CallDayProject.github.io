package com.cdp.health.dto.answer;

import java.time.LocalDateTime;
import java.util.Set;

import com.cdp.health.board.Board;
import com.cdp.health.user.SiteUser;

import lombok.Data;

@Data
public class AnswerDTO {
	
	private Integer num;//댓글 번호
	
    private String content;
    
    private Board board;//연관된 게시글 정보
    
    private SiteUser author;//댓글 작성자 정보
    
}
