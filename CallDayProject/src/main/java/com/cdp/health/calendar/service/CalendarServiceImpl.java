package com.cdp.health.calendar.service;

import java.sql.Date;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cdp.health.calendar.Calendar;
import com.cdp.health.calendar.WeekDay;
import com.cdp.health.calendar.WeekView;
import com.cdp.health.dto.CalendarDTO;
import com.cdp.health.mapper.CalendarMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CalendarServiceImpl implements CalendarService{

	// 한국 기준 월요일 시작(월~일)
    private static final DateTimeFormatter DTF_YMD = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final DateTimeFormatter DTF_MD  = DateTimeFormatter.ofPattern("M/d");
    private static final DateTimeFormatter DTF_E   = DateTimeFormatter.ofPattern("E"); // 요일
	

	@Resource
	private CalendarRepository calendarRepository;
	
	@Resource
	private CalendarService calendarService;
	
	private final CalendarMapper calendarMapper;

	@Override
	public CalendarDTO getReadDataCalendar(Integer calNum, Long userId) throws Exception{
		
		return calendarMapper.getReadDataCalendar(calNum, userId); // MyBatis가 DTO로 바로 매핑
		
	}
    
	@Override
	public WeekView buildWeek(LocalDate anyDayInWeek) {
		
        LocalDate monday = anyDayInWeek.with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        LocalDate sunday = monday.plusDays(6);

        List<WeekDay> days = new ArrayList<>(7);
        for (int i = 0; i < 7; i++) {
            LocalDate d = monday.plusDays(i);
            days.add(new WeekDay(
                    d,
                    d.format(DTF_YMD),
                    d.format(DTF_MD),
                    d.format(DTF_E),
                    d.equals(LocalDate.now())
            ));
            
        }

        LocalDate prevWeek = monday.minusWeeks(1);
        LocalDate nextWeek = monday.plusWeeks(1);

        return WeekView.builder()
                .monday(monday)
                .sunday(sunday)
                .prevWeek(prevWeek)
                .nextWeek(nextWeek)
                .days(days)
                .build();
        
	}
	
    @Override
    public Map<String, List<CalendarDTO>> 
    	findByDateRangeAsMap(LocalDate start, LocalDate end, Long userId) {
    	
        String startStr = start.toString();
        String endStr   = end.toString();

        List<CalendarDTO> rows = calendarMapper.getByDateRange(startStr, endStr, userId);

        return rows.stream().collect(Collectors.groupingBy(dto ->
                dto.getCalDate() != null ? dto.getCalDate() : "unknown"
        ));
    }

	@Override
	public void deleteDataCalendar(Integer calNum, Long userId) throws Exception {
		
		calendarMapper.deleteDataCalendar(calNum, userId);
		
	}
	
    @Transactional
    public Calendar toggleComplete(Integer calNum, boolean done) {
        
    	Calendar cal = calendarRepository.findById(calNum)
            .orElseThrow(() -> new IllegalArgumentException("not found: " + calNum));
        
    	cal.setCalCheck(Boolean.valueOf(done));

        return calendarRepository.save(cal);
    	
    }
    
    @Override
    public List<CalendarDTO> findCompletedByUserAndBetween(Long userId, Date start, Date end) {
        String startStr = start.toLocalDate().toString();
        String endStr   = end.toLocalDate().toString();

        List<Calendar> rows = calendarRepository
            .findByUser_IdAndCalDateBetweenAndCalCheckIsTrue(userId, startStr, endStr);

        return rows.stream().map(c -> CalendarDTO.builder()
            .calNum(c.getCalNum())
            .calDate(c.getCalDate()) 
            .calCheck(Boolean.TRUE)
            .calSubject(c.getCalSubject())
            .calPart(c.getCalPart())
            .calName(c.getCalName())
            .leadTime(c.getLeadTime())
            .userId(userId)
            .build()
        ).collect(Collectors.toList());
        
    }
    
    @Transactional
    public Calendar markComplete(Integer calNum) {
        Calendar entity = calendarRepository.findById(calNum)
            .orElseThrow(() -> new IllegalArgumentException("일정을 찾을 수 없습니다: " + calNum));

        if (Boolean.TRUE.equals(entity.getCalCheck())) {
            return entity;
        }
        entity.setCalCheck(true);
        return calendarRepository.save(entity);
    }
    
    @Override
    @Transactional
    public int markDoneOnce(Integer calNum, String userId) {
        return calendarRepository.markDoneOnce(calNum, userId);
    }
    
    @Transactional
    public Calendar updateSchedule(Long userId, Integer calNum, CalendarDTO dto) {
        Calendar cal = calendarRepository
            .findByCalNumAndUser_Id(calNum, userId)
            .orElseThrow(() -> new IllegalArgumentException("일정을 찾을 수 없거나 권한이 없습니다: " + calNum));

        cal.setCalSubject(dto.getCalSubject());
        cal.setCalContent(dto.getCalContent());
        cal.setCalPart(dto.getCalPart());
        cal.setCalName(dto.getCalName());
        cal.setLeadTime(dto.getLeadTime());
        cal.setCalDate(dto.getCalDate());

        return calendarRepository.save(cal);
        
    }
    
    @Transactional(readOnly = true)
    public Calendar getByCalNumAndUser(Integer calNum, Long userId) {
    	
        return calendarRepository.findByCalNumAndUser_Id(calNum, userId)
            .orElseThrow(() -> new IllegalArgumentException("일정을 찾을 수 없거나 권한이 없습니다."));
   
    }

}
