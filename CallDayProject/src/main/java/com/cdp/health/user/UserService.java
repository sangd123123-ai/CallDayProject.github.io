package com.cdp.health.user;

import java.io.File;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cdp.health.DataNotFoundException;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserService {

	private final UserRepository userRepository;

	private final PasswordEncoder passwordEncoder;

	public SiteUser create (String userId, String userName,String password,
			String email, String address) {

		// 아이디 중복 체크
		if (userRepository.existsByUserId(userId)) {
			throw new IllegalArgumentException("이미 사용 중인 아이디입니다.");
		}

		// 이메일 중복 체크
		if (userRepository.existsByEmail(email)) {
			throw new IllegalArgumentException("이미 사용 중인 이메일입니다.");
		}
		SiteUser user = new SiteUser();
		user.setUserId(userId);
		user.setUserName(userName);
		user.setEmail(email);
		user.setAddress(address);

		user.setPassword(passwordEncoder.encode(password));		

		//로그인 했을때 admin이면 관리자취급, 아니면 그냥 USER 취급
		if("admin".equals(userId)) {
			user.setRole(UserRole.ADMIN);
		} else {
			user.setRole(UserRole.USER);
		}

		userRepository.save(user);

		return user;
	}

	public SiteUser getUser(String userId) {
		Optional<SiteUser> siteUser = userRepository.findByUserId(userId);
		if (siteUser.isPresent()) {
			return siteUser.get();
		} else {
			throw new DataNotFoundException("User Not Found");
		}
	}

	// 회원정보수정
	public void updateUserInfo(Long id, String email) {
		Optional<SiteUser> optionalUser = userRepository.findById(id);
		if (optionalUser.isPresent()) {
			SiteUser user = optionalUser.get();
			user.setEmail(email);

			userRepository.save(user); 
		} else {
			throw new DataNotFoundException("User Not Found");
		}
	}



	//내 정보창에서 새로운 비밀번호로 수정했을때 로직 or 로그인 창에서 비밀번호 찾을때
	public void updatePassword(SiteUser user, String rawPassword) {
		// 새 비밀번호 암호화
		String encodedPw = passwordEncoder.encode(rawPassword);
		// 엔티티 비밀번호 갱신
		user.setPassword(encodedPw);
		// DB 저장 (update 쿼리 발생)
		userRepository.save(user);
	}

	//프로필 사진 업로드
	public void updateProfileImage(HttpServletRequest request, MultipartFile file, Long userId) throws Exception {
		if (!file.isEmpty()) {

			String root = request.getServletContext().getRealPath("/");
			String uploadDir = root + "resources" + File.separator + "profile";
			File dir = new File(uploadDir);

			if (!dir.exists()) 
				dir.mkdirs();

			String originalFileName = file.getOriginalFilename();
			String saveFileName = System.currentTimeMillis() + "_" + originalFileName;
			File saveFile = new File(uploadDir, saveFileName);
			file.transferTo(saveFile);

			SiteUser user = userRepository.findById(userId)
					.orElseThrow(() -> new Exception("유저를 찾을 수 없습니다."));

			user.setProfileImage(saveFileName);
			userRepository.save(user);
		}

	}

}
