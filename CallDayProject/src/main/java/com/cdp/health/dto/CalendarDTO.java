package com.cdp.health.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CalendarDTO {
	
    private Integer calNum;
    private String calSubject;
    private String calContent;
    private String calPart;
    private String calName;
    private String leadTime;
    private String calDate;
    private boolean calCheck;
    private Long userId;
    
}
