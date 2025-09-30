package com.cdp.health.calendar.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cdp.health.calendar.Calendar;
import com.cdp.health.calendar.WeekView;
import com.cdp.health.dto.CalendarDTO;

public interface CalendarService {
	
	WeekView buildWeek(LocalDate anyDayInWeek);
	
	CalendarDTO getReadDataCalendar( @Param("calNum") Integer calNum, @Param("userId") Long userId) throws Exception;
	
	Map<String, List<CalendarDTO>> findByDateRangeAsMap(LocalDate start, LocalDate end, Long userId) throws Exception;
	
	void deleteDataCalendar(@Param("calNum") Integer calNum, @Param("userId") Long userId) throws Exception;
	
	public Calendar toggleComplete(Integer calNum, boolean done);
	
	List<CalendarDTO> findCompletedByUserAndBetween(Long userId, Date start, Date end);
	
	Calendar markComplete(Integer calNum);
	
	int markDoneOnce(Integer calNum, String userId);
	
	Calendar updateSchedule(Long userId, Integer calNum, CalendarDTO in);
	
	Calendar getByCalNumAndUser(Integer calNum, Long userId);
	
}
