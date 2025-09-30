package com.cdp.health.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import com.cdp.health.user.SiteUser;

import lombok.Data;

//어제 방문자 수
@Data
@Entity
public class Vist_logEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO) // DB 자동 증가
    private Long id;

    @Column(length = 50, nullable = false)
    private String ipAddress;   // 방문자 IP

    @Column(length = 255)
    private String userAgent;   // 브라우저/디바이스 정보 (선택)

    @Column(name = "VISIT_TIME", nullable = false)
    private LocalDateTime visitTime; // 방문 시각
}