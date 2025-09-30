package com.cdp.health.main.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cdp.health.admin.ProductRepository;
import com.cdp.health.admin.SliderRepository;
import com.cdp.health.dto.NoticeDTO;
import com.cdp.health.dto.SliderDTO;
import com.cdp.health.entity.ProductEntity;
import com.cdp.health.entity.SliderEntity;
import com.cdp.health.main.service.MainRepository;
import com.cdp.health.main.service.MainService;
import com.cdp.health.mapper.HealthMapper;
import com.cdp.health.user.SiteUser;
import com.cdp.health.user.UserService;
import com.cdp.health.util.MyUtil;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HealthController {
	

	private final UserService userService;
	private final PasswordEncoder passwordEncoder;
	private final SliderRepository sliderRepository;
	private final ProductRepository productRepository;
	private final MainService mainService;
	
	@Autowired
	MyUtil myUtil;
	

		//메인 페이지 화면 띄우기
		@RequestMapping(value = "/", method = RequestMethod.GET)
		public String home3(Model model) {
			//1. 이벤트/공지 슬라이드
			List<SliderEntity> lists = sliderRepository.findAll();
			model.addAttribute("lists",lists);
			
			  // 2. 스토어 상품
		    List<ProductEntity> products = productRepository.findAll();
		    model.addAttribute("products", products);
		    
		    // 3. 좋아요 탑 3
		    model.addAttribute("top3Likes", mainService.getTop3ByLikes());
			
			return "main";
			
		}
	
	
	 @GetMapping("/calendar")
	    public String calendar() {
	        return "aaa/calendar";
	    }
	
	 
		@GetMapping("/memberProfile")
		public String myInfo(Principal principal, Model model) {
			
		    String userId = principal.getName();
		    SiteUser user = userService.getUser(userId);
		    model.addAttribute("user", user);

		    return "/memberProfile"; 
		}
		
		//프로필 사진 저장
		@PostMapping("/memberProfile/updateImage")
	    public String updateProfileImage(
	            @RequestParam("file") MultipartFile file,
	            Principal principal,
	            HttpServletRequest request,
	            RedirectAttributes redirectAttributes) {
			
	        try {
	            String userId = principal.getName();
	            SiteUser user = userService.getUser(userId);
	            
	            userService.updateProfileImage(request, file, user.getId());

	            redirectAttributes.addFlashAttribute("successMsg", "프로필 이미지가 변경되었습니다.");
	        } catch (Exception e) {
	            redirectAttributes.addFlashAttribute("errorMsg", "이미지 변경 중 오류 발생: " + e.getMessage());
	        }

	        return "redirect:/memberProfile";
	    }
		

		//회원 수정
		@PostMapping("/memberProfile/update")
		public String updateInfo(@RequestParam Long id,
		                         @RequestParam String email) {
			
		    userService.updateUserInfo(id, email);
		    return "redirect:/memberProfile";
		}


		//패스워드 수정
		@PostMapping("/memberProfile/updatePassword")
		public String updatePassword(@RequestParam String currentPassword,
		                             @RequestParam String newPassword,
		                             @RequestParam String confirmPassword,
		                             Principal principal,
		                             Model model,
		                             RedirectAttributes redirectAttributes) {

		    SiteUser user = userService.getUser(principal.getName());

		    if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
		        model.addAttribute("errorMsg", "현재 비밀번호가 일치하지 않습니다.");
		        model.addAttribute("user", user);
		        return "/memberProfile";
		    }

		    if (!newPassword.equals(confirmPassword)) {
		        model.addAttribute("errorMsg", "새 비밀번호가 일치하지 않습니다.");
		        model.addAttribute("user", user);
		        return "/memberProfile";
		    }


		    userService.updatePassword(user, newPassword);
		    
		    redirectAttributes.addFlashAttribute("successMsg", "비밀번호가 성공적으로 변경되었습니다.");

		    return "redirect:/memberProfile";
		}


	
	
	
	
	
}
