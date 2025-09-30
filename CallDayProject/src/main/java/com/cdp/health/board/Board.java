package com.cdp.health.board;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.cdp.health.dto.answer.Answer;
import com.cdp.health.user.SiteUser;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Board {//spring boot board answer처럼

	@Id//기본키
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer num;//게시글 번호
	
	@Column(length = 100)
	private String subject;//제목
	
	private String userId;
	
	@Column(length = 500)
	private String content;//내용
	
	private String saveFileName;//파일 저장이름
	private String originalFileName;//원본 파일이름
	
	//아래 게시물 관련 코딩
	
	@ManyToOne
	private SiteUser author;//사용자 정보
	
	//질문을 남겼을 때 답글도 함께 지워지는 역할
	//fetchType을 통해 데이터를 다 읽어올 수 있도록 설정
	@OneToMany(mappedBy = "board", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	private List<Answer> answers = new ArrayList<>();
	
	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)//좋아요
	private Set<SiteUser> voter;//set은 중복값을 허용하지 않음
	
	
	
}
