package com.cdp.health.dto.answer;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.cdp.health.board.Board;
import com.cdp.health.user.SiteUser;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Answer {//jpa방식
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    private Integer num;//답변 고유 번호
	
	@Column(length = 100)
    private String content;//답변 내용
	
    @ManyToOne
    private SiteUser author;//사용자 정보

    @ManyToOne
    @JoinColumn(name = "board_id")//answer는 자식,댓글은 어떤 게시글에 속해야함을 의미
    private Board board;
	

}