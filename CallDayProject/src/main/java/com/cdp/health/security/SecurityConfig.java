package com.cdp.health.security;

import com.cdp.health.admin.VisitorInterceptor;
import com.cdp.health.user.CustomOAuth2UserService;
import com.cdp.health.user.UserSecurityService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.http.converter.FormHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.endpoint.DefaultAuthorizationCodeTokenResponseClient;
import org.springframework.security.oauth2.client.endpoint.OAuth2AccessTokenResponseClient;
import org.springframework.security.oauth2.client.endpoint.OAuth2AuthorizationCodeGrantRequest;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;
import org.springframework.security.oauth2.core.http.converter.OAuth2AccessTokenResponseHttpMessageConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.security.web.servlet.util.matcher.MvcRequestMatcher;
import org.springframework.util.StreamUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.handler.HandlerMappingIntrospector;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.*;

@RequiredArgsConstructor
@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

    private final UserSecurityService userSecurityService;
    private final CustomOAuth2UserService customOAuth2UserService;
    

    /** 비밀번호 암호화 */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
  
    /** DaoAuthenticationProvider */
    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userSecurityService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    /** HandlerMappingIntrospector (Spring Security 6.x용) */
    @Bean(name = "mvcHandlerMappingIntrospector")
    public HandlerMappingIntrospector mvcHandlerMappingIntrospector() {
        return new HandlerMappingIntrospector();
    }

    /** SecurityFilterChain */
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http, HandlerMappingIntrospector introspector) throws Exception {
        MvcRequestMatcher.Builder mvc = new MvcRequestMatcher.Builder(introspector);

        http
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(
                    mvc.pattern("/"), mvc.pattern("/index"),
                    mvc.pattern("/login"), mvc.pattern("/signup"),
                    mvc.pattern("/find-password"), mvc.pattern("/error"),
                    mvc.pattern("/css/**"), mvc.pattern("/js/**"),
                    mvc.pattern("/resources/**"), mvc.pattern("/images/**"),
                    mvc.pattern("/pds/**"),  
                    mvc.pattern("/address/**"), mvc.pattern("/addr/**"),
                    mvc.pattern("/api/public/**"), mvc.pattern("/calendar"),
                    mvc.pattern("/oauth2/**"), mvc.pattern("/login/oauth2/**"),
                    mvc.pattern("/imgArticle.action"), 
                    mvc.pattern("/board/view/**"),
                    mvc.pattern("/post/view/**")
                ).permitAll()
                
                .anyRequest().authenticated()
            )
            .formLogin(login -> login
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .failureUrl("/login?form_error=true")
                .usernameParameter("userId")
                .passwordParameter("password")
                .successHandler(authSuccessHandler())
                .permitAll()
            )
            .oauth2Login(oauth2 -> oauth2
                .loginPage("/login")
                .userInfoEndpoint(userInfo -> userInfo.userService(customOAuth2UserService))
                .successHandler(authSuccessHandler())  // ← OAuth2에도 핸들러 추가
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/")
                .permitAll()
            )
            .csrf(csrf -> csrf.disable());

        return http.build();
    }

    @Bean
    public AuthenticationSuccessHandler authSuccessHandler() {
        return (request, response, authentication) -> {
            String ctx = request.getContextPath();
            
            // 1. redirect 파라미터 확인
            String redirect = request.getParameter("redirect");
            if (redirect != null && !redirect.trim().isEmpty()) {
                boolean safe = redirect.startsWith(ctx + "/") || redirect.startsWith("/");
                if (safe && !redirect.startsWith("//")
                        && redirect.indexOf('\r') < 0 && redirect.indexOf('\n') < 0) {
                    response.sendRedirect(redirect);
                    return;
                }
            }
            
            // 2. SavedRequest 확인 (단, 정적 리소스는 제외)
            HttpSessionRequestCache cache = new HttpSessionRequestCache();
            SavedRequest saved = cache.getRequest(request, response);
            if (saved != null) {
                String targetUrl = saved.getRedirectUrl();
                // 이미지나 정적 리소스 URL이면 무시
                if (!targetUrl.contains("/pds/") && 
                    !targetUrl.contains("/images/") &&
                    !targetUrl.contains("/css/") &&
                    !targetUrl.contains("/js/")) {
                    response.sendRedirect(targetUrl);
                    return;
                }
            }
            
            // 3. 권한별 기본 페이지로
            boolean isAdmin = authentication.getAuthorities().stream()
                    .anyMatch(a -> "ROLE_ADMIN".equals(a.getAuthority()));
            String roleDefault = isAdmin ? "/admin/dashboard" : "/";
            response.sendRedirect(roleDefault);
        };
    }

    /** ClientRegistration Repository */
    @Bean
    public ClientRegistrationRepository clientRegistrationRepository() {
        return new InMemoryClientRegistrationRepository(
                kakaoClientRegistration(),
                naverClientRegistration()
        );
    }

    private ClientRegistration kakaoClientRegistration() {
        return ClientRegistration.withRegistrationId("kakao")
                .clientId("76ecdcd0640f5ced3f4f61b41ad2446c")
                .clientAuthenticationMethod(ClientAuthenticationMethod.NONE) //  여기 핵심
                .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
                .redirectUri("{baseUrl}/login/oauth2/code/{registrationId}")
                .scope("profile_nickname", "profile_image")
                .authorizationUri("https://kauth.kakao.com/oauth/authorize")
                .tokenUri("https://kauth.kakao.com/oauth/token")
                .userInfoUri("https://kapi.kakao.com/v2/user/me")
                .userNameAttributeName("id")
                .clientName("Kakao")
                .build();
    }

    private ClientRegistration naverClientRegistration() {
        return ClientRegistration.withRegistrationId("naver")
            .clientId("CciVWNiuQV2sIrCL0O1N").clientSecret("VHLG2F6NoG")
            .clientAuthenticationMethod(ClientAuthenticationMethod.POST)
            .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
            .redirectUri("{baseUrl}/login/oauth2/code/{registrationId}") // ← 여기!
            .scope("name","email")
            .authorizationUri("https://nid.naver.com/oauth2.0/authorize")
            .tokenUri("https://nid.naver.com/oauth2.0/token")
            .userInfoUri("https://openapi.naver.com/v1/nid/me")
            .userNameAttributeName("response")
            .clientName("Naver")
            .build();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }
}
