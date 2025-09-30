package com.cdp.health.user;

import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.cdp.health.user.SiteUser;
import com.cdp.health.user.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    private final UserRepository userRepository;
    

    
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) {
        OAuth2User oAuth2User = super.loadUser(userRequest);

        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        System.out.println(">>> OAuth2 Login 시도됨: " + userRequest.getClientRegistration().getRegistrationId());
        oAuth2User = super.loadUser(userRequest);
        System.out.println(">>> 카카오 응답: " + oAuth2User.getAttributes());

        // 카카오 로그인 처리
        if ("kakao".equals(registrationId)) {
            Map<String, Object> attributes = oAuth2User.getAttributes();

            Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
            Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");
            System.out.println(">>> 카카오 attributes = " + attributes);

            String kakaoId = attributes.get("id").toString();
            String nickname = (profile != null) ? (String) profile.get("nickname") : "KakaoUser";
            String email = (kakaoAccount != null) ? (String) kakaoAccount.get("email") : kakaoId + "@kakao.com";

            // DB에 존재하는지 확인
            Optional<SiteUser> userOpt = userRepository.findByUserId(kakaoId);

            SiteUser user;
            if (userOpt.isPresent()) {
                user = userOpt.get();
            } else {
                // 처음 로그인한 경우 자동 회원가입
                user = new SiteUser();
                user.setUserId(kakaoId);  // 카카오 ID를 userId로 사용
                user.setUserName(nickname);
                user.setEmail(email);
                user.setPassword(new BCryptPasswordEncoder().encode("SOCIAL_LOGIN"));
                user.setRole(UserRole.USER);

                userRepository.save(user);
            }

            return new DefaultOAuth2User(
                    oAuth2User.getAuthorities(),
                    attributes,
                    "id" // 카카오에서 고유 식별자로 쓸 key
            );
        }
        
        if ("naver".equals(registrationId)) {
            Map<String, Object> attributes = oAuth2User.getAttributes();
            Map<String, Object> response = (Map<String, Object>) attributes.get("response");
            System.out.println(">>> Naver loadUser 진입");
            System.out.println(">>> 네이버 attributes = " + oAuth2User.getAttributes());

            
            String naverId = (String) response.get("id");
            String name = (String) response.get("name");
            String email = (String) response.get("email");
            String nickname = (String) response.get("nickname");

            // DB에서 확인
            Optional<SiteUser> userOpt = userRepository.findByUserId(naverId);

            SiteUser user;
            if (userOpt.isPresent()) {
                user = userOpt.get();
            } else {
                user = new SiteUser();
                user.setUserId(naverId);   // 네이버 고유 id
                user.setUserName(name != null ? name : nickname);
                user.setEmail(email != null ? email : naverId + "@naver.com");
                user.setPassword(new BCryptPasswordEncoder().encode("SOCIAL_LOGIN"));
                user.setRole(UserRole.USER);

                userRepository.save(user);
            }

            return new DefaultOAuth2User(
                    oAuth2User.getAuthorities(),
                    response,  // ⭐ 중요: 네이버는 "response" 맵 안쪽을 써야 함
                    "id"
            );
        }


        return oAuth2User;
    }
}
