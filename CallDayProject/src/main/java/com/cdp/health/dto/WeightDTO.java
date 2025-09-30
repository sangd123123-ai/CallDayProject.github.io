package com.cdp.health.dto;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;  // 추가

@Getter
@Setter
@NoArgsConstructor
public class WeightDTO {
    private int weightrecordid;
    private Long siteuserid;
    private double currentweight;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")  
    private LocalDate recorddate;
    
    private String weightmemo;
    private int userheight;
}