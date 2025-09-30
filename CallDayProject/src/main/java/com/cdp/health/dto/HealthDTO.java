package com.cdp.health.dto;


import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import com.cdp.health.dto.answer.Answer;
import com.cdp.health.user.SiteUser;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class HealthDTO {
	
	private Integer num;//게시글 번호
	private String userId;//유저 아이디
	private String subject;//제목
	private String content;//내용
	private String saveFileName;//파일 저장이름
	private String originalFileName;//원본 파일이름

	private long authorId;//사용자 정보
	
	//답글도 함께 지워지는 역할
	//fetchType을 통해 데이터를 다 읽어올 수 있도록 설정
	private List<Answer> answerList = new ArrayList<>();
	
	private Set<SiteUser> voter;
	
}
