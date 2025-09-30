package com.cdp.health.calendar;

import javax.persistence.Column;
import javax.persistence.Convert;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.cdp.health.calendar.service.YNConverter;
import com.cdp.health.user.SiteUser;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "calendar")
public class Calendar {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Integer calNum;
	
	@Column(name="calSubject")
	private String calSubject;

	@Column(name="calContent")
	private String calContent;
	
	@Column(name="calPart")
	private String calPart;
	
	@Column(name="calName")
	private String calName;
	
	@Column(name="leadTime")
	private String leadTime;
	
	@Column(name="calDate")
	private String calDate;
	
	@Column(name="CALCHECK")   // 대소문자 구분 없음(Oracle), 그냥 명시만
	@Convert(converter = YNConverter.class)
	private Boolean calCheck;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	private SiteUser user;
	
}