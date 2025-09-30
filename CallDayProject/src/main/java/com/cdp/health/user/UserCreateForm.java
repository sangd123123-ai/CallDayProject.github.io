package com.cdp.health.user;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserCreateForm {
	
	@Size(min = 5, max = 25)
	@NotEmpty(message = "ID는 필수항목입니다")
	@Pattern(regexp = "^[a-zA-Z0-9]+$", message = "아이디는 영어와 숫자만 입력할 수 있습니다.")
	private String userId;
	
	@Size(min = 3,max = 25)
	@NotEmpty(message = "이름은 필수항목입니다")
	@Pattern(regexp = "^[가-힣]+$", message = "한글만 입력할 수 있습니다.")
	private String userName;
	
	@NotEmpty(message = "비밀번호는 필수항목입니다")
	@Pattern(
		    regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+=-]).+$",
		    message = "비밀번호는 영어, 숫자, 특수문자를 모두 포함해야 합니다."
		)
	private String password1;
	
	@NotEmpty(message = "비밀번호 확인은 필수항목입니다")
	private String password2;
	
	@NotEmpty(message = "이메일은 필수항목입니다")
	@Email
	private String email;
	@NotEmpty(message = "성별은 필수항목입니다")
	private String address;
	
}



