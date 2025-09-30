package com.cdp.health.dto;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;

@Data
public class NoticeDTO {
	
	private Long id;
	private String userId;
	private String userName;
	private String password;
	private String address;
	private String email;
	
}
