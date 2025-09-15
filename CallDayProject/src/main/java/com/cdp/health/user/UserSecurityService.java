package com.cdp.health.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserSecurityService implements UserDetailsService{

	private final UserRepository userRepository;

	@Override
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		
		//사용자이름으로 SiteUser 객체를 조회
		Optional<SiteUser> searchUser = 
				userRepository.findByUserName(userName);
		
		if(!searchUser.isPresent()) {
			throw new UsernameNotFoundException("사용자를 찾을수 없습니다");			
		}
		
		SiteUser siteUser = searchUser.get();
		
		List<GrantedAuthority> authorities =
				new ArrayList<GrantedAuthority>();
		
		if("admin".equals(userName)) {
			authorities.add(new SimpleGrantedAuthority(UserRole.ADMIN.getValue()));			
		}else {
			authorities.add(new SimpleGrantedAuthority(UserRole.USER.getValue()));
		}
		
		//사용자명,비밀번호,권한을 스프링 시큐리티의 User객체로 생성해서 리턴
		return new User(siteUser.getUserName(),
				siteUser.getPassword(), authorities);
	}
	
	
	
	
	
	
}
