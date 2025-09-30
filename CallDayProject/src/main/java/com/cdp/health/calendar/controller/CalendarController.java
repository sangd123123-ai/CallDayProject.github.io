package com.cdp.health.calendar.controller;

import java.security.Principal;
import java.sql.Date;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cdp.health.calendar.Calendar;
import com.cdp.health.calendar.WeekView;
import com.cdp.health.calendar.service.CalendarRepository;
import com.cdp.health.calendar.service.CalendarService;
import com.cdp.health.dto.CalendarDTO;
import com.cdp.health.user.SiteUser;
import com.cdp.health.user.UserService;

@Controller
@RequestMapping("/calendar")
public class CalendarController {
	
	@Resource
    private CalendarService calendarService;
    
	@Resource
    private CalendarRepository calendarRepository;
	
	@Resource
	private UserService userService;
	
    @GetMapping("/week")
    public String week(@RequestParam(value = "date", required = false) String dateStr,
    		Principal principal, Model model) throws Exception {
    	
    	if (principal == null) {
    		
            return "redirect:/login";
            
        }
    	
        LocalDate baseDate = (dateStr == null || dateStr.isEmpty())
                ? LocalDate.now()
                : LocalDate.parse(dateStr);
                
		WeekView week = calendarService.buildWeek(baseDate);
		
	    SiteUser user = userService.getUser(principal.getName());
		
		LocalDate startDate = LocalDate.parse(week.getDays().get(0).getIsoYmd());
		LocalDate endDate   = LocalDate.parse(week.getDays().get(week.getDays().size()-1).getIsoYmd());
		
		Map<String, List<CalendarDTO>> byDate =
				calendarService.findByDateRangeAsMap(startDate, endDate, user.getId());
		
		LocalDate date = LocalDate.now();
	    
		if (dateStr != null && !dateStr.isEmpty()) {
	        
	    	try {
	           
	        	date = LocalDate.parse(dateStr);
	        
	        } catch (DateTimeParseException ex) {
	        	
	        }
	        
	    }
		
		String key = date.toString();
		List<CalendarDTO> events =
		        byDate.getOrDefault(key, java.util.Collections.emptyList());

		
		model.addAttribute("user", user);
		model.addAttribute("week", week);
		model.addAttribute("titleYMD", baseDate.format(DateTimeFormatter.ofPattern("yyyy.MM.dd")));
		model.addAttribute("baseDate", baseDate);
		model.addAttribute("byDate", byDate);
		model.addAttribute("selectedDate", date);
		model.addAttribute("schedules", events);

        return "calendar";
        
    }

    // 이전 주/다음 주 이동 (월요일 기준)
    @GetMapping("/week/shift")
    public String shift(@RequestParam("date") String dateStr,
                        @RequestParam("offset") int offsetWeeks) {
    	
        LocalDate base = LocalDate.parse(dateStr);
        LocalDate shifted = base.plusWeeks(offsetWeeks);
        return "redirect:/calendar/week?date=" + shifted;
        
    }

    // 오늘로 이동
    @GetMapping("/week/today")
    public String today() {
    	
        return "redirect:/calendar/week?date=" + LocalDate.now();
        
    }
    
    // 특정 날짜로 점프 (yyyy-MM-dd)
    @PostMapping("/week/jump")
    public String jump(@RequestParam(value="targetDate", required=false) String targetDate) {
    	
    	if (targetDate == null || targetDate.trim().isEmpty()) {
    		
            return "redirect:/calendar/week";
            
        }
    	
        return "redirect:/calendar/week?date=" + targetDate.trim();
        
    }
    
    @PostMapping("/week")
    public String weekPost(@RequestParam("targetDate") String targetDate,
                           @RequestParam(value="calNum", required=false) Integer calNum,
                           Principal principal, Model model) throws Exception {
    	
        LocalDate baseDate = LocalDate.parse(targetDate);

        WeekView week = calendarService.buildWeek(baseDate);
        model.addAttribute("week", week);
        
        SiteUser user = userService.getUser(principal.getName());

        LocalDate startDate = LocalDate.parse(week.getDays().get(0).getIsoYmd());
        LocalDate endDate   = LocalDate.parse(week.getDays().get(week.getDays().size()-1).getIsoYmd());
        
        Map<String, List<CalendarDTO>> byDate =
                calendarService.findByDateRangeAsMap(startDate, endDate, user.getId());
        model.addAttribute("byDate", byDate);

        model.addAttribute("selectedDate", targetDate);

        // 날짜별 일정 목록
        List<CalendarDTO> schedules = byDate.get(targetDate);
        
        model.addAttribute("schedules", schedules);
        
        // 특정 일정 상세
        if (calNum != null && user != null) {
        	
            CalendarDTO dto = calendarService.getReadDataCalendar(calNum, user.getId());
            
            model.addAttribute("selectedEvent", dto);
            
        }
        
        model.addAttribute("user",user);
        
        model.addAttribute("baseDate", baseDate);

        return "calendar";
        
    }
    
    @PostMapping("/delete")
    public String calDelete(Principal principal, 
    		@RequestParam(value="calNum", required=false) Integer calNum,
    		@RequestHeader(value="Referer", required=false) String ref) throws Exception{
    	
    	SiteUser user = userService.getUser(principal.getName());
    	
    	calendarService.deleteDataCalendar(calNum, user.getId());
    	
    	if(ref != null && ref.contains("/calendar/week")){
    		
            return "redirect:" + ref;
            
        }
    	
        return "redirect:/calendar/week";
    	
    }
    
    @PostMapping(
    	    value = "/{calNum}/complete",
    	    consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE,
    	    produces = MediaType.APPLICATION_JSON_VALUE
    	)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> complete(@PathVariable Integer calNum) {

	    Calendar updated = calendarService.markComplete(calNum);

	    Map<String, Object> body = new HashMap<>();
	    body.put("calNum", updated.getCalNum());
	    body.put("calCheck", Boolean.TRUE.equals(updated.getCalCheck()));
	    body.put("status", "ok");
	    return ResponseEntity.ok(body);
	}
    
    @GetMapping("/check")
    public String checkPage(@RequestParam(required = false) Integer year,
                            @RequestParam(required = false) Integer month,
                            Principal principal,
                            Model model) {

        YearMonth ym = resolveYearMonth(year, month);
        int resolvedYear  = ym.getYear();
        int resolvedMonth = ym.getMonthValue();

        model.addAttribute("calendarYear", resolvedYear);
        model.addAttribute("calendarMonth", resolvedMonth);

        Long userId = resolveCurrentUserId(principal);

        LocalDate startLd = ym.atDay(1);
        LocalDate endLd   = ym.atEndOfMonth();

        List<CalendarDTO> checked = calendarService.findCompletedByUserAndBetween(
                userId,
                Date.valueOf(startLd),
                Date.valueOf(endLd)
        );

		Set<String> completedDateSet = toCompletedDateSet(checked);
		
		model.addAttribute("calendarCheckedList", checked);
		
		Map<String, Boolean> completedDateMap = new HashMap<>();
		for (String s : completedDateSet) completedDateMap.put(s, Boolean.TRUE);
		model.addAttribute("completedDateMap", completedDateMap);
		
		model.addAttribute("days", buildMonthCells(resolvedYear, resolvedMonth));

        return "calendar_check";
    }


    private YearMonth resolveYearMonth(Integer year, Integer month) {
        LocalDate today = LocalDate.now();
        int y = (year  != null) ? year  : today.getYear();
        int m = (month != null) ? month : today.getMonthValue(); // 1~12
        return YearMonth.of(y, m);
    }

    private Long resolveCurrentUserId(Principal principal) {
        return 1L;
    }

    private Set<String> toCompletedDateSet(List<CalendarDTO> list) {
        if (list == null || list.isEmpty()) return new HashSet<String>(0);
        return list.stream()
                .map(dto -> {
                    Object d = dto.getCalDate();
                    if (d == null) return null;
                    if (d instanceof LocalDate) return ((LocalDate)d).toString(); // yyyy-MM-dd
                    return d.toString();
                })
                .filter(s -> s != null && !s.isEmpty())
                .collect(Collectors.<String>toSet());
    }

    public static class DayCell {
        private final String isoDate;    // yyyy-MM-dd
        private final int dayNum;
        private final boolean outOfMonth;
        private final boolean today;

        public DayCell(String isoDate, int dayNum, boolean outOfMonth, boolean today) {
            this.isoDate = isoDate;
            this.dayNum = dayNum;
            this.outOfMonth = outOfMonth;
            this.today = today;
        }
        public String getIsoDate() { return isoDate; }
        public int getDayNum() { return dayNum; }
        public boolean isOutOfMonth() { return outOfMonth; }
        public boolean isToday() { return today; }
    }

    private List<DayCell> buildMonthCells(int year, int month) {
        YearMonth ym = YearMonth.of(year, month);
        LocalDate first = ym.atDay(1);
        LocalDate last  = ym.atEndOfMonth();

        int firstDow = first.getDayOfWeek().getValue() % 7;

        int daysInMonth = last.getDayOfMonth();
        java.util.ArrayList<DayCell> list = new java.util.ArrayList<DayCell>(42);
        LocalDate today = LocalDate.now();

        LocalDate prev = first.minusDays(firstDow);
        for (int i = 0; i < firstDow; i++) {
            LocalDate d = prev.plusDays(i);
            list.add(new DayCell(d.toString(), d.getDayOfMonth(), true, d.equals(today)));
        }

        for (int d = 1; d <= daysInMonth; d++) {
            LocalDate cur = ym.atDay(d);
            list.add(new DayCell(cur.toString(), d, false, cur.equals(today)));
        }

        while (list.size() < 42) {
            LocalDate lastCell = LocalDate.parse(list.get(list.size() - 1).getIsoDate());
            LocalDate nxt = lastCell.plusDays(1);
            list.add(new DayCell(nxt.toString(), nxt.getDayOfMonth(), true, nxt.equals(today)));
        }
        return list;
    }
    
    @GetMapping(value = "/api/completed", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public List<Map<String,Object>> apiCompleted(@RequestParam int year,
                                                 @RequestParam int month,
                                                 Principal principal) {
        
		SiteUser user = userService.getUser(principal.getName());
		
		Long userId = user.getId();
    	
        YearMonth ym = YearMonth.of(year, month);
        LocalDate start = ym.atDay(1);
        LocalDate end   = ym.atEndOfMonth();

        List<CalendarDTO> checked = calendarService.findCompletedByUserAndBetween(
                userId, java.sql.Date.valueOf(start), java.sql.Date.valueOf(end));

        List<Map<String,Object>> out = new ArrayList<>();
        for (CalendarDTO d : checked) {
            Map<String,Object> m = new HashMap<>();
            m.put("date", d.getCalDate());        // "yyyy-MM-dd" 문자열이면 그대로
            m.put("calCheck", d.isCalCheck());    // true
            out.add(m);
        }
        return out;
    }
    
    @PostMapping("/calendar/done")
    @ResponseBody
    public Map<String, Object> markDone(@RequestParam Integer calNum,
                                        Principal principal) {
        String userId = principal.getName();
        int updated = calendarService.markDoneOnce(calNum, userId);

        Map<String, Object> res = new HashMap<>();
        if (updated > 0) {
            res.put("status", "done");          // 이번에 완료됨
        } else {
            res.put("status", "already_done");  // 이미 완료였음
        }
        return res;
    }
    
    @PostMapping(value="/{calNum}/update", consumes=MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String update(@PathVariable Integer calNum,
                         @RequestParam Map<String,String> form,
                         Principal principal,
                         @RequestHeader(value="Referer", required=false) String ref) {

        Long userId = (principal != null)
            ? userService.getUser(principal.getName()).getId()
            : null;

        String calSubject = form.get("calSubject");
        String calContent = form.get("calContent");
        String calPart    = form.get("calPart");
        String calName    = form.get("calName");
        String leadTimeStr= form.get("leadTime");
        String calDateStr = form.get("calDate");
        String back       = form.get("back");

        CalendarDTO dto = CalendarDTO.builder()
            .calSubject(calSubject)
            .calContent(calContent)
            .calPart(calPart)
            .calName(calName)
            .leadTime(leadTimeStr)
            .calDate(calDateStr)
            .userId(userId)
            .build();

        calendarService.updateSchedule(userId, calNum, dto);

        if (StringUtils.hasText(back)) {
        	
            return "redirect:" + back;
            
        }
        
        return "redirect:/calendar/week";
        
    }
    
    @GetMapping("/edit")
    public String edit(@RequestParam("calNum") Integer calNum, Principal principal, 
    		Model model, @RequestHeader(value="Referer", required=false) String referer) {
    	
        Long userId = userService.getUser(principal.getName()).getId();
        
        Calendar cal = calendarService.getByCalNumAndUser(calNum, userId);

        CalendarDTO dto = CalendarDTO.builder()
                .calNum(cal.getCalNum())
                .calSubject(cal.getCalSubject())
                .calContent(cal.getCalContent())
                .calPart(cal.getCalPart())
                .calName(cal.getCalName())
                .leadTime(cal.getLeadTime())
                .calDate(cal.getCalDate())
                .userId(cal.getUser() != null ? cal.getUser().getId() : null)
                .build();

        model.addAttribute("calendar", dto);
        model.addAttribute("back", (referer != null && referer.contains("/calendar")) ? referer : "/calendar/week");
        
        return "edit";
        
    }
    
}
