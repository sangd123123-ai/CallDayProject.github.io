package com.cdp.health.main.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.cdp.health.board.Board;
import com.cdp.health.mapper.HealthMapper;
import com.cdp.health.user.SiteUser;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainService {
	
	private final  MainRepository mainRepository;
	private final  PasswordEncoder passwordEncoder;
	private final  HealthMapper healthMapper;
	
	public SiteUser createUser(String userId,String userName,
			String password,String email,String address) {
		
		SiteUser su = new SiteUser();
		su.setUserId(userId);
		su.setUserName(userName);
		su.setPassword(passwordEncoder.encode(password));
		su.setAddress(address);
		su.setEmail(email);
//		su.setRole("ROLE USER")
		;
		
		return mainRepository.save(su);
	}
	
    //좋아요 탑 3
    public List<Board> getTop3ByLikes() {
		return healthMapper.getTop3ByLikes();
	}


}
