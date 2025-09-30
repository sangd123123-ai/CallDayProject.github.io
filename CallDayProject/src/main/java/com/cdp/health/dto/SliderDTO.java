package com.cdp.health.dto;

import lombok.Data;

@Data
public class SliderDTO {

	private Long id;
	private String title;
	private String content;
	private String linkUrl; //자세히 보기 누르는 링크
	private String saveFileName;      // 서버 저장용 파일명
	private String originalFileName;  // 사용자가 업로드한 원본 파일명

}
