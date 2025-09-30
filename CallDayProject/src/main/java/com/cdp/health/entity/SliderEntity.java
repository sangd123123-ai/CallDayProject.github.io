package com.cdp.health.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import com.cdp.health.user.SiteUser;

import lombok.Data;

//이벤트&공지사항
@Data
@Entity
public class SliderEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(length = 100,nullable = false)
	private String title;

	@Column(nullable = false)
	private String content;

	@Column(length = 255)
	private String linkUrl;      //링크

	@Column(length = 255, nullable = false)
	private String saveFileName;      //서버 저장 파일명

	@Column(length = 255, nullable = false)
	private String originalFileName;  //원본 파일명


}
