package com.cdp.health.user;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "SITEUSER")
public class SiteUser {
	

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(unique = true)  
    private String userId;

    @Column(nullable = true)
    private String userName;

    private String password;

    @Column(unique = true)
    private String email;

    @Column
    private String address;

    @Enumerated(EnumType.STRING)   // enum을 문자열로 DB에 저장
    private UserRole role;
    
    @Column(length = 255)
    private String profileImage;

	
}













