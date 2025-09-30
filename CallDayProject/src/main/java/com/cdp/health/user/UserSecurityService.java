package com.cdp.health.user;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserSecurityService implements UserDetailsService{

	private final UserRepository userRepository;
	
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		
		//사용자이름으로 SiteUser 객체를 조회
		Optional<SiteUser> searchUser = 
				userRepository.findByUserId(userId);
		 
		
		System.out.println(">>> loadUserByUsername 호출됨, 입력 userId=" + userId);
		
		if(!searchUser.isPresent()) {
			throw new UsernameNotFoundException("사용자를 찾을수 없습니다");			
		}
		
		
		
		SiteUser siteUser = searchUser.get();
		 // 비번 로그 찍기
	    System.out.println("=== 로그인 시도 ===");
	    System.out.println(">>> loadUserByUsername 호출됨, 입력 userId=" + userId);
        System.out.println("DB userId=" + siteUser.getUserId());
        System.out.println("DB role=" + siteUser.getRole());

	    //권한 세팅
		List<GrantedAuthority> authorities =
				new ArrayList<GrantedAuthority>();
		
		//DB role 값 가져오기 (UserRole enum 객체)
		UserRole role = siteUser.getRole();  
		System.out.println(">>> DB role=" + role);
	    System.out.println(">>> 권한 부여: " + role.getValue());
		//ROLE_ prefix가 enum 안에 이미 들어있음 (ROLE_ADMIN, ROLE_USER)
		//따라서 그대로 사용하면 돼
		authorities.add(new SimpleGrantedAuthority(role.getValue()));
		
		// 핵심: 소셜 로그인 계정일 경우 비밀번호 검증 안함
		  if ("SOCIAL_LOGIN".equals(siteUser.getPassword())) {
		        return User.withUsername(siteUser.getUserId())
		                .password("{noop}SOCIAL_LOGIN") // {noop}으로 비밀번호 인코딩 스킵
		                .authorities(authorities)
		                .build();
		    }
		
		//사용자명,비밀번호,권한을 스프링 시큐리티의 User객체로 생성해서 리턴
		//Id로 되어야 아이디로 로그인가능
		return new User(siteUser.getUserId(),
				siteUser.getPassword(), authorities);
	}
	
}
