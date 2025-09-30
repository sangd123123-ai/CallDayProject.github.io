package com.cdp.health.dto;

import com.cdp.health.user.UserRole;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

//BoardEntity 필요 (게시판 관리를 위해)
@Data
@NoArgsConstructor	//파라미터 없는 생성자
@AllArgsConstructor //모든 필드 받는 생성자
public class AdminDTO {
	
		//회원 정보 DTO
	    private Long id;
	    private String userId;
	    private String userName;
//	    private String password;
	    private String email;
	    private String address;
	    private UserRole role;

	

}
