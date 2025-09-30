package com.cdp.health.user;

import java.util.UUID;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cdp.health.DataNotFoundException;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class UserController {

	private final UserService userService;
	private final PasswordEncoder passwordEncoder;
	
	@GetMapping("/signup")
	public String signup(UserCreateForm userCreateForm) {
		
		return "/login/signup_form";
		
	}
	
	@PostMapping("/signup")
	public String signup(@Validated UserCreateForm userCreateForm,
			BindingResult bindingResult,Model model) {
		
		if(bindingResult.hasErrors()) {
			model.addAttribute("errors", bindingResult);
			return "/login/signup_form";
		}
		
		if(!userCreateForm.getPassword1()
				.equals(userCreateForm.getPassword2())) {
			
			bindingResult.rejectValue("password2", "passwordInCorrect",
					"2개의 패스워드가 일치하지 않습니다");
			model.addAttribute("errors", bindingResult);
			return "/login/signup_form";			
		}
		
		try {
		
		userService.create(
				userCreateForm.getUserId(),
				userCreateForm.getUserName(),
				userCreateForm.getPassword1(), 
				userCreateForm.getEmail(),
				userCreateForm.getAddress()
				);
		
		}catch (IllegalArgumentException e) {
			
	        // 여기서 e.getMessage()에 "아이디 중복" / "이메일 중복" 각각 들어옴
	        bindingResult.reject("signupFailed", e.getMessage());
	        model.addAttribute("errors", bindingResult);
	        return "/login/signup_form";
	    }
				
		return "redirect:/login";
		
	}
	
	@GetMapping("/login")
	public String login(@RequestParam(value="error", required=false) String error, Model model) {
	    if (error != null) {
	        model.addAttribute("loginError", true);
	    }
	    return "/login/login_form";
	}
	
	
	//비밀번호 찾기 로직
	@GetMapping("/find-password")
	public String showFindPasswordForm() {
	    return "/login/find_password"; // JSP 폼 화면
	}
	
	@PostMapping("/find-password")
	public String findPassword(@RequestParam String username, Model model) {
	    SiteUser user = null;
	    try {
	        user = userService.getUser(username); // 존재하지 않으면 예외 발생
	    } catch (DataNotFoundException e) {
	        model.addAttribute("errorMsg", "해당 아이디가 존재하지 않습니다.");
	        return "/login/find_password";
	    }

	    //임시 비밀번호 생성
	    String tempPassword = UUID.randomUUID().toString().substring(0, 8);

	    //비밀번호만 업데이트
	    userService.updatePassword(user, tempPassword);

	    model.addAttribute("tempPassword", tempPassword);
	    
	    return "/login/find_password";
	}

	
}







