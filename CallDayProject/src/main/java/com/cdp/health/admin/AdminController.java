package com.cdp.health.admin;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cdp.health.dto.ExerciseDTO;
import com.cdp.health.dto.LikeStatsDTO;
import com.cdp.health.dto.ProductDTO;
import com.cdp.health.dto.SliderDTO;
import com.cdp.health.entity.ProductEntity;
import com.cdp.health.entity.SliderEntity;
import com.cdp.health.entity.Vist_logEntity;
import com.cdp.health.exercise.service.ExerciseService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
public class AdminController {

	private final AdminService adminService;
	private final SliderRepository sliderRepository;
	private final ProductRepository productRepository;
	private final ExerciseService exerciseService;
	private final VistLogRepository vistLogRepository;



	@GetMapping("/test-insert")
	@ResponseBody
	public String insertTestData() {
		for (int i = 0; i < 7; i++) {
			Vist_logEntity entity = new Vist_logEntity();
			entity.setIpAddress("127.0.0.1");
			entity.setUserAgent("Test-Agent");
			entity.setVisitTime(LocalDateTime.now().minusDays(i)); // i일 전
			vistLogRepository.save(entity);
		}
		return "7일치 데이터 insert 완료!";
	}





	//관리자 페이지
	@GetMapping("/dashboard")
	public String admin(HttpServletRequest request,Model model) {

		// 어제 방문자 수
		int yesterdayVisitors = adminService.getYesterdayVisitors();
		model.addAttribute("yesterdayVisitors", yesterdayVisitors);

		// 일주일 방문자 수
		List<Map<String, Object>> visitorStats = adminService.getLast7DaysVisitors();
		model.addAttribute("visitorStats", visitorStats);


		List<LikeStatsDTO> likeStats = adminService.getLast7DaysLikes();
		System.out.println("📊 likeStats: " + likeStats); // 확인
		for (LikeStatsDTO dto : likeStats) {
			System.out.println(">>> " + dto.getLikeDate() + " / " + dto.getCnt());
		}

		model.addAttribute("likeStats", likeStats);

		return "admin_layout/layout_test";
	}

	//	//관리자 페이지
	//		@GetMapping("/dashboard")
	//		public String admin() {
	//			return "admin/dashboard";
	//}

	//회원관리
	@GetMapping("/users")
	public String userList(Model model) {
		model.addAttribute("users", adminService.getUserList());


		return "admin/users";
	}

	//공지사항 관리에 데이터 띄우기
	@GetMapping("/mainslider")
	public String mainslider(Model model) {
		//1. 이벤트/공지 슬라이드
		List<SliderEntity> lists = sliderRepository.findAll();
		model.addAttribute("lists",lists);



		return "admin/mainslider";
	}


	//스토어 페이지 관리
	@GetMapping("/mainstore")
	public String mainstore(Model model) {

		//  스토어 상품
		List<ProductEntity> products = productRepository.findAll();
		model.addAttribute("products", products);

		return "admin/mainstore";
	}

	//운동 가이드 관리
	@GetMapping("/admin_exercise")
	public String admin_exercise(Model model) {

		List<ExerciseDTO> exercises = exerciseService.getAllExercises();
		model.addAttribute("exerciseList", exercises);

		return "/admin/admin_exercise";
	}

	//============================== @GetMapping  ==============================
	//==============================		      ==============================
	//==============================    		  ==============================

	// 회원 삭제
	@PostMapping("/users/{id}/delete")
	public String deleteUser(@PathVariable("id") Long id) {
		adminService.deleteUser(id);
		return "redirect:/admin/users"; // 삭제 후 다시 목록으로
	}

	// 회원 수정 (예: 이름/이메일 수정) <수정완료>
	@PostMapping("/users/{id}/update")
	public String updateUser(
			@PathVariable("id") Long id,
			@RequestParam String role) {

		adminService.updateUser(id, role);

		return "redirect:/admin/users"; // 수정 후 다시 목록으로
	}

	//============================== 회원관리  ==============================
	//============================= @PostMapping ============================
	//==============================    	   ==============================

	//공지사항 파일 인서트 로직(여긴 insert고 jsp에 뿌려주는 건 HealthController에 있다.)
	@PostMapping("/mainslider") 
	public String uploadSlider(HttpServletRequest request,
			@ModelAttribute SliderDTO sliderDTO, 
			@RequestParam("imageFile") MultipartFile imageFile) throws Exception{ 

		adminService.saveSlider(request, sliderDTO, imageFile); 

		return "redirect:/admin/mainslider";

	}

	// 공지사항 수정 처리
	@PostMapping("/updateSlider")
	public String updateSlider(HttpServletRequest request,
			@ModelAttribute SliderDTO sliderDTO,
			@RequestParam("imageFile") MultipartFile imageFile) throws Exception {

		adminService.updateSlider(request, sliderDTO, imageFile);

		return "redirect:/admin/mainslider";
	}

	// 공지사항 삭제
	@GetMapping("/deleteSlider")
	public String deleteSlider(@RequestParam("id") Long id) {

		adminService.deleteSlider(id); // 서비스에서 sliderRepository.deleteById(id)

		return "redirect:/admin/mainslider"; // 삭제 후 다시 목록 페이지로
	}

	//============================== 공지사항  ==============================
	//============================= @PostMapping ============================
	//==============================    	   ==============================


	@PostMapping("/mainstore")
	public String saveProduct(HttpServletRequest request,
			@ModelAttribute ProductEntity product,
			@RequestParam("imageFile") MultipartFile imageFile) throws Exception {
		adminService.saveProduct(request, product, imageFile);
		return "redirect:/admin/mainstore";
	}

	// 스토어 수정 처리
	@PostMapping("/updateStore")
	public String updateProduct(HttpServletRequest request,
			@ModelAttribute ProductDTO productDTO,
			@RequestParam(value = "imageFile", required = false) MultipartFile imageFile) throws Exception {

		adminService.updateProduct(request, productDTO, imageFile);
		return "redirect:/admin/mainstore";
	}



	// 스토어 삭제
	@GetMapping("/deleteStore")
	public String deleteStore(@RequestParam("id") Long id) {

		adminService.deleteStore(id);

		return "redirect:/admin/mainstore"; // 삭제 후 다시 목록 페이지로
	}



	//스토어 더미데이터
//	@GetMapping("/testInsertProducts")
//	@ResponseBody
//	public String insertDummyProducts() {
//		List<ProductEntity> list = new ArrayList<>();
//
//		ProductEntity p1 = new ProductEntity();
//		p1.setTitle("아디다스 피트니스");
//		p1.setContent("에어쿨레디 스포츠 헤드밴드");
//		p1.setSaveFileName("이미지4.jpg");
//		p1.setOriginalFileName("이미지4.jpg");
//		p1.setLinkUrl("http://test.com/1");
//		p1.setPrice(19100);
//		list.add(p1);
//
//		ProductEntity p2 = new ProductEntity();
//		p2.setTitle("나이키 운동화");
//		p2.setContent("런닝화 최신 모델");
//		p2.setSaveFileName("이미지2.jpg");
//		p2.setOriginalFileName("이미지2.jpg");
//		p2.setLinkUrl("http://test.com/2");
//		p2.setPrice(59000);
//		list.add(p2);
//
//		ProductEntity p3 = new ProductEntity();
//		p3.setTitle("홈트세트");
//		p3.setContent("덤벨 + 매트 세트");
//		p3.setSaveFileName("이미지3.jpg");
//		p3.setOriginalFileName("이미지3.jpg");
//		p3.setLinkUrl("http://test.com/3");
//		p3.setPrice(35000);
//		list.add(p3);
//
//		ProductEntity p4 = new ProductEntity();
//		p4.setTitle("캡처 상품");
//		p4.setContent("테스트용 캡처 이미지");
//		p4.setSaveFileName("캡처.JPG");  // 대소문자 구분 주의 (운영체제 따라 다름)
//		p4.setOriginalFileName("캡처.JPG");
//		p4.setLinkUrl("http://test.com/4");
//		p4.setPrice(25000);
//		list.add(p4);
//
//		productRepository.saveAll(list);
//
//		return "더미 데이터 저장 완료!";
//	}

	//============================== 스토어 관리 ==============================
	//============================= @PostMapping ============================
	//==============================    	   ==============================

	/** 운동 수정 (POST) */
	@PostMapping("/exercise/update")
	public String update(ExerciseDTO dto) {
		exerciseService.updateExercise(dto); 
		return "redirect:/admin/admin_exercise";
	}

	/** 운동 삭제 (GET or POST) */
	@GetMapping("/exercise/delete")
	public String delete(@RequestParam int exId) {
		exerciseService.deleteExercise(exId);
		return "redirect:/admin/admin_exercise";
	}

	//============================== 운동 가이드 관리 ==============================
	//==============================   @PostMapping   ==============================
	//==============================    	  	        ==============================



}
