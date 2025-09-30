package com.cdp.health.exercise.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cdp.health.calendar.Calendar;
import com.cdp.health.calendar.service.CalendarRepository;
import com.cdp.health.dto.ExerciseDTO;
import com.cdp.health.exercise.service.ExerciseRepository;
import com.cdp.health.exercise.service.ExerciseService;
import com.cdp.health.user.SiteUser;
import com.cdp.health.user.UserService;

@Controller
@RequestMapping("/exercise")
public class ExerciseController {
    
    private final ExerciseService exerciseService;
    private final ExerciseRepository exerciseRepository;
    
	@Resource
    private CalendarRepository calendarRepository;
    
    @Resource
	private UserService userService;
    
    public ExerciseController(ExerciseService exerciseService, ExerciseRepository exerciseRepository) {
        this.exerciseService = exerciseService;
        this.exerciseRepository = exerciseRepository;
    }
    
    @GetMapping("/recommend")
    public String getExerciseByPart(String part, Model model) {
        List<ExerciseDTO> Shoulder = exerciseService.getExercisesByPart("어깨");
        List<ExerciseDTO> Chest = exerciseService.getExercisesByPart("가슴");
        List<ExerciseDTO> Arm = exerciseService.getExercisesByPart("팔");
        List<ExerciseDTO> Abs = exerciseService.getExercisesByPart("복근");
        List<ExerciseDTO> Back = exerciseService.getExercisesByPart("등");
        List<ExerciseDTO> Hip = exerciseService.getExercisesByPart("둔근");
        List<ExerciseDTO> Thigh = exerciseService.getExercisesByPart("허벅지");
        List<ExerciseDTO> Calf = exerciseService.getExercisesByPart("종아리");
        
        model.addAttribute("part", part);
        model.addAttribute("Shoulder", Shoulder);
        model.addAttribute("Chest", Chest);
        model.addAttribute("Arm", Arm);
        model.addAttribute("Abs", Abs);
        model.addAttribute("Back", Back);
        model.addAttribute("Hip", Hip);
        model.addAttribute("Thigh", Thigh);
        model.addAttribute("Calf", Calf);
        
        return "exercise";
    }
    
    @GetMapping("/detail")
    public String getExerciseDetail(@RequestParam int exId, Model model) {
        ExerciseDTO exercise = exerciseService.getExerciseById(exId);
        model.addAttribute("exercise", exercise); 
        return "health/exDetail";
    }
    
    @GetMapping("/ex_create")
    public String getCreateForm(Principal principal) {
    	
    	if (principal == null) {
    		
            return "redirect:/login";
            
        }
    	
        return "ex_create";
    }
    
    @GetMapping("/test")
    public String test() {
        return "manage";
    }
    
    @PostMapping("/save")
    public String saveSchedule(@RequestParam Map<String,String> form, 
    		Principal principal, Model model) {
    	
    	SiteUser user = userService.getUser(principal.getName());
    	
		String calSubject = form.get("title");
        String calContent = form.get("content");
        String calPart    = form.get("exerciseCategory");
        String calName    = form.get("exerciseType");
        String leadTimeStr= form.get("duration");
        String calDateStr = form.get("date");

        Integer leadTime = null;
        
        if (StringUtils.hasText(leadTimeStr)) {
        	
            try { leadTime = Integer.valueOf(leadTimeStr.trim()); } catch (NumberFormatException ignore) {}
        
        }

        Calendar cal = new Calendar();
        cal.setUser(user);
        cal.setCalPart(calPart);
        cal.setCalName(calName);
        cal.setCalSubject(calSubject);
        cal.setCalContent(calContent);
        cal.setCalDate(calDateStr);
        cal.setLeadTime(leadTimeStr);
        cal.setCalCheck(false);
		
        calendarRepository.save(cal);
    	
    	return "redirect:/calendar/week";
      
    }

//    @GetMapping("/add-arm-exercises")
//    @ResponseBody
//    public String addArmExercises() {
//        try {
//            List<Exercise> armExercises = createArmExercisesEntity();
//            exerciseRepository.saveAll(armExercises);
//            return "팔운동 " + armExercises.size() + "개 추가 완료!";
//        } catch (Exception e) {
//            return "오류: " + e.getMessage();
//        }
//    }
//
//    private List<Exercise> createArmExercisesEntity() {
//        List<Exercise> list = new ArrayList<>();
//        
//        list.add(createExerciseEntity("가슴", "덤벨 플랫 벤치 프레스", "대흉근, 삼각근, 삼두근", 
//        	    "가슴 전체 발달, 가슴 두께 증가, 상체 파워 향상", 
//        	    "벤치에 누워 어깨너비보다 약간 넓게 덤벨 잡기 덤벨을 가슴 위로 천천히 내리기 (가슴에 닿을 정도) 힘을 주며 원래 자리로 밀어올리기 12-15회 × 3세트", 
//        	    "https://www.youtube.com/watch?v=xTQL6jvVMNA"));
//
//        return list;
//    }
//    private Exercise createExerciseEntity(String part, String name, String target, String effect, String method, String url) {
//        Exercise entity = new Exercise();
//        entity.setExPart(part);
//        entity.setExName(name);
//        entity.setTargetMuscle(target);
//        entity.setEffect(effect);
//        entity.setMethod(method);
//        entity.setYoutubeUrl(url);
//        return entity;
//    }
}
    