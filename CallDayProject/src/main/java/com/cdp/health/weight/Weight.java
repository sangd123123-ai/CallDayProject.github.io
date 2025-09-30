package com.cdp.health.weight;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.FetchType;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDate;
import com.cdp.health.user.SiteUser;

@Entity
@Getter
@Setter
public class Weight {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer weightrecordid;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "siteuserid")
    private SiteUser siteuser;      // SiteUser와 연관관계
    
    @Column
    private double currentweight;   // 체중 (kg)
    
    @Column
    private LocalDate recorddate;   // 기록 날짜
    
    @Column
    private String weightmemo;      // 메모
    
    @Column
    private int userheight;         // 키 (cm)

}