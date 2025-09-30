package com.cdp.health.admin;

import java.io.File;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cdp.health.board.Board;
import com.cdp.health.dto.AdminDTO;
import com.cdp.health.dto.LikeStatsDTO;
import com.cdp.health.dto.ProductDTO;
import com.cdp.health.dto.SliderDTO;
import com.cdp.health.entity.ProductEntity;
import com.cdp.health.entity.SliderEntity;
import com.cdp.health.entity.Vist_logEntity;
import com.cdp.health.mapper.HealthMapper;
import com.cdp.health.user.SiteUser;
import com.cdp.health.user.UserRepository;
import com.cdp.health.user.UserRole;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
//board가져올때도 똑같이하면 됨
public class AdminService {
	
	private final ProductRepository productRepository;
	private final SliderRepository sliderRepository;
	private final UserRepository userRepository;
	private final VistLogRepository vistLogRepository;
	
	//======= 마이바티스 사용연결 다리 =======
	private final HealthMapper healthMapper;
	
	//어제 방문자 수
    public int getYesterdayVisitors() {
        return healthMapper.getYesterdayVisitors();
    }
    
    //일주일 방문자 수
    public List<Map<String, Object>> getLast7DaysVisitors() {
        return healthMapper.getLast7DaysVisitors();
    }
    
 // 좋아요 통계 (일주일 단위)
    public List<LikeStatsDTO> getLast7DaysLikes() {
        return healthMapper.getLast7DaysLikes();
    }
   

    
    //좋아요 탑 3
    public List<Board> getTop3ByLikes() {
		return healthMapper.getTop3ByLikes();
	}
    //========================================
	
	//공지사항 관리(insert)
	public void saveSlider(HttpServletRequest request,
						   SliderDTO dto, 
						   MultipartFile imageFile) throws Exception{

        if (!imageFile.isEmpty()) {
        	
            // 1. 업로드 경로 (프로젝트 내부 /resources/main/slider)
            String root = request.getServletContext().getRealPath("/");
            String uploadDir = root + "resources" + File.separator + "main" + File.separator + "slider";

            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs(); // 폴더 없으면 자동 생성
            }

            // 2. 파일명 처리
            String originalFileName = imageFile.getOriginalFilename();
            String saveFileName = System.currentTimeMillis() + "_" + originalFileName;

            // 3. 파일 저장
            File saveFile = new File(uploadDir, saveFileName);
            imageFile.transferTo(saveFile);

            // 4. DTO → Entity 변환
            SliderEntity entity = new SliderEntity();
            entity.setTitle(dto.getTitle());
            entity.setContent(dto.getContent());
            entity.setLinkUrl(dto.getLinkUrl());
            entity.setOriginalFileName(originalFileName);
            entity.setSaveFileName(saveFileName);

            // 5. DB 저장
            sliderRepository.save(entity);
        }
		
	}
	
	//공지사항 관리(update)
	public void updateSlider(HttpServletRequest request,
	                         SliderDTO dto,
	                         MultipartFile imageFile) throws Exception {

	    // 1. 기존 엔티티 조회
	    SliderEntity entity = sliderRepository.findById(dto.getId())
	            .orElseThrow(() -> new RuntimeException("해당 배너를 찾을 수 없습니다."));

	    // 2. 텍스트 값 업데이트
	    entity.setTitle(dto.getTitle());
	    entity.setContent(dto.getContent());
	    entity.setLinkUrl(dto.getLinkUrl());

	    // 3. 파일이 새로 올라왔을 경우에만 교체
	    if (imageFile != null && !imageFile.isEmpty()) {
	        String root = request.getServletContext().getRealPath("/");
	        String uploadDir = root + "resources" + File.separator + "main" + File.separator + "slider";

	        File dir = new File(uploadDir);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }

	        String originalFileName = imageFile.getOriginalFilename();
	        String saveFileName = System.currentTimeMillis() + "_" + originalFileName;

	        File saveFile = new File(uploadDir, saveFileName);
	        imageFile.transferTo(saveFile);

	        entity.setOriginalFileName(originalFileName);
	        entity.setSaveFileName(saveFileName);
	    }

	    // 4. DB 저장 (update 동작)
	    sliderRepository.save(entity);
	}



    // 삭제(공지사항 관리)
    public void deleteSlider(Long id) {
    	System.out.println("삭제 시도 ID = " + id);
        sliderRepository.deleteById(id);
    }

    //========================== 공지사항 관리 ==========================
 	//==========================  	밑에는	   ==========================
    //==========================  스토어 관리  ==========================
    
    // 스토어 관리 (insert)
    public void saveProduct(HttpServletRequest request, 
    						ProductEntity product, 
    						MultipartFile imageFile) throws Exception {
        if (!imageFile.isEmpty()) {
            String root = request.getServletContext().getRealPath("/");
            String uploadDir = root + "resources" + File.separator + "main" + File.separator + "store";

            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String originalFileName = imageFile.getOriginalFilename();
            String saveFileName = System.currentTimeMillis() + "_" + originalFileName;

            File saveFile = new File(uploadDir, saveFileName);
            imageFile.transferTo(saveFile);

            product.setOriginalFileName(originalFileName);
            product.setSaveFileName(saveFileName);
        }

        productRepository.save(product);
    }
    
    // 스토어 관리(update)
    public void updateProduct(HttpServletRequest request,
            ProductDTO productDTO,
            MultipartFile imageFile) throws Exception {

		ProductEntity dbProduct = productRepository.findById(productDTO.getId())
		.orElseThrow(() -> new RuntimeException("상품을 찾을 수 없습니다."));
		
		dbProduct.setTitle(productDTO.getTitle());
		dbProduct.setContent(productDTO.getContent());
		dbProduct.setPrice(productDTO.getPrice());
		dbProduct.setLinkUrl(productDTO.getLinkUrl());

        // 이미지 파일이 새로 올라온 경우
        if (!imageFile.isEmpty()) {
            String root = request.getServletContext().getRealPath("/");
            String uploadDir = root + "resources" + File.separator + "main" + File.separator + "store";

            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String originalFileName = imageFile.getOriginalFilename();
            String saveFileName = System.currentTimeMillis() + "_" + originalFileName;

            File saveFile = new File(uploadDir, saveFileName);
            imageFile.transferTo(saveFile);

            dbProduct.setOriginalFileName(originalFileName);
            dbProduct.setSaveFileName(saveFileName);
        }

        // DB 반영
        productRepository.save(dbProduct);
    }
    
    // 삭제(스토어 관리)
    public void deleteStore(Long id) {
        productRepository.deleteById(id);
    }

    
  //========================== 스토어 관리 ==========================
  //==========================    밑에는   ==========================
  //========================== 회원 관리   ==========================
	
	
	
	//회원 정보들(권한만 수정하게 바꿨기에 필요할까?)
	public List<AdminDTO> getUserList() {
	    List<SiteUser> users = userRepository.findAll();
	    List<AdminDTO> dtos = new ArrayList<>();

	    for (SiteUser user : users) {
	        AdminDTO dto = new AdminDTO(
	            user.getId(),
	            user.getUserId(),
	            user.getUserName(),
	            user.getEmail(),
	            user.getAddress(),
	            user.getRole()
	        );
	        dtos.add(dto);
	    }

	    return dtos;
	}
	
	// 삭제
	public void deleteUser(Long id) {
	    userRepository.deleteById(id);
	}

	//회원관리 수정 (관리자 전용 수정 메서드)
	public void updateUser(Long id, String role) {
		Optional<SiteUser> optionalUser = userRepository.findById(id);
		
		if (optionalUser.isPresent()) {
		    SiteUser user = optionalUser.get();
		    

		    user.setRole(UserRole.valueOf(role)); // enum이면 이렇게
		    
	    userRepository.save(user);
	    
		} else {
		    throw new RuntimeException("User not found");
		}
	}
	
	 //========================== 방문자 수 관리 ==========================
	 //==========================    		     ==========================
	 //==========================   		     ==========================
	
	
	////VisitorInterceptor + WebMvcConfig 가 방문자 수 집계를 하면 여길 통해 DB에 넣음
	public void logVisit(String ip, String userAgent) {
        Vist_logEntity log = new Vist_logEntity();
        log.setIpAddress(ip);
        log.setUserAgent(userAgent);
        log.setVisitTime(LocalDateTime.now());
        
        vistLogRepository.save(log); // insert 실행
        System.out.println(">> DB 저장 시도: " + log);
    }

	
	

}
