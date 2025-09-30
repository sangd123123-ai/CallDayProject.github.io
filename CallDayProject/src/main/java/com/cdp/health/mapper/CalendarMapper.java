package com.cdp.health.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param; //Param 임포트가 달라서 따로 분류

import com.cdp.health.dto.CalendarDTO;

@Mapper
public interface CalendarMapper {

    CalendarDTO getReadDataCalendar(@Param("calNum") Integer calNum, @Param("userId") Long userId) throws Exception;
	
    List<CalendarDTO> getByDateRange(@Param("startDate") String startDate,
            @Param("endDate") String endDate, @Param("userId") Long userId);
    
    void deleteDataCalendar(@Param("calNum") Integer calNum, @Param("userId") Long userId) throws Exception;
    
	
}
