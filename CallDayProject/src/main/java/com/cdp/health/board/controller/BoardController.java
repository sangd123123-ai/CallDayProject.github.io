package com.cdp.health.board.controller;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cdp.health.board.Board;
import com.cdp.health.board.answer.AnswerService;
import com.cdp.health.board.service.BoardRepository;
import com.cdp.health.board.service.BoardService;
import com.cdp.health.dto.HealthDTO;
import com.cdp.health.dto.answer.Answer;
import com.cdp.health.user.SiteUser;
import com.cdp.health.user.UserService;
import com.cdp.health.util.FileManager;
import com.cdp.health.util.MyUtil;

@Controller
public class BoardController {
	
	@Resource
	private BoardService boardService;
	@Resource
	private AnswerService answerService;
	@Resource
	private UserService userService;
	@Resource
	private BoardRepository boardRepository;
	
	@Autowired
	MyUtil myUtil;
	
	@Autowired
	private ServletContext servletContext;

	@RequestMapping(value="/")
	public String home() {
		return "imgBoard";
	}
	
	//이미지 파일 업로드 하는 장소
	@GetMapping("/imgCreated.action")
	public ModelAndView imgCreated(Principal principal) {//사용자 정보 조회
		
		ModelAndView mav = new ModelAndView("imgCreated");
		if(principal!=null) {
			String userId = principal.getName();
			mav.addObject("siteUserId",userId);
		}
		return mav;
	}
	
	//데이터 처리 - 파일 받았을 경우
	@PostMapping("/imgCreated.action")
	public ModelAndView imgCreated(
			@RequestParam("subject")String subject,
			@RequestParam("userId")String userId,
			@RequestParam("content")String content,
			@RequestParam("upload")MultipartFile upload,
			Principal principal,HttpServletRequest req) throws Exception{

		ModelAndView mav = new ModelAndView();
		
		try {
			//현재 로그인한 사용자 정보
			SiteUser loginUser = null;
			if(principal!=null) {
				
				loginUser = userService.getUser(principal.getName());
				
			}
			
			// 1. 파일 저장 위치 선정
	        String root = req.getSession().getServletContext().getRealPath("/");
	        String path = root + "pds" + File.separator + "upload";
	        File dir = new File(path);
	        if (!dir.exists()) dir.mkdirs();
	        
	        // 2. 파일명 안전하게 처리 + 중복 방지
	        String originalFileName = upload.getOriginalFilename();
	        String saveFileName = System.currentTimeMillis() + "_" + originalFileName;

	        // 3. 서버에 파일 저장
	        File saveFile = new File(path, saveFileName);
	        upload.transferTo(saveFile);

	        // 4. DTO 객체 생성 및 데이터 설정
	        Board board = new Board();
	        int maxNum = boardService.maxNum();
	       
	        board.setNum(maxNum + 1);
	        board.setSubject(subject);
	        board.setUserId(userId);
	        board.setContent(content);
	        board.setOriginalFileName(originalFileName);
	        board.setSaveFileName(saveFileName);
	        board.setAuthor(loginUser);

	        // 5. DB에 insert
	        boardService.insertData(board);

	        // 6. 목록 페이지로 리다이렉트
	        return new ModelAndView("redirect:/imgBoard.action");
	        
	    } catch (Exception e) {
	    	e.printStackTrace();
	    	mav.addObject("message", "이미지 업로드 중 오류가 발생했습니다.");
	    	mav.setViewName("errorPage");
	    	return mav;
	    	}
		}
		
	//imgBoard - 이미지 확인 저장소 = list
	@GetMapping("/imgBoard.action")
	public ModelAndView imgBoard(Principal principal,
			HttpServletRequest req)throws Exception{
		
		ModelAndView mav = new ModelAndView("imgBoard");
		
		//로그인한 사용자 id를 전달 받기 위해서 사용
		SiteUser currentUser = null;
		if(principal!=null) {
			String userId = principal.getName();
			currentUser = userService.getUser(userId);
			mav.addObject("siteUserId",userId);
		}
				
		//1.현재 페이지 구하기
		String pageNum = req.getParameter("pageNum");
		
		int currentPage = 1;
		
		if(pageNum!=null) {
			currentPage = Integer.parseInt(pageNum);
		}else {
			pageNum = "1";
		}
		
		//2.검색어 처리
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		
		if(searchValue==null) {
			searchKey = "subject";
			searchValue = "";
		}else {
			if(req.getMethod().equalsIgnoreCase("GET")) {
				searchValue = URLDecoder.decode(searchValue,"UTF-8");
			}
		}
		//3.전체 데이터 갯수, 페이징 처리
		int dataCount = boardService.getDataCount(searchKey,searchValue);
		int numPerPage = 9;
		int totalPage = myUtil.getPageCount(numPerPage, dataCount);
		
		if(currentPage>totalPage) {
			currentPage = totalPage;
		}
		
		int start = (currentPage-1)*numPerPage+1;
		int end = currentPage*numPerPage;
		
		//4.이미지 목록 가져오기
		List<HealthDTO> lists = boardService.getLists(start,end,searchKey,searchValue);
		
		//좋아요 정보 조회해서 map으로 만들어 jsp로 전달!
		Map<Integer, Boolean> likedMap = new HashMap<>();
		Map<Integer, Integer> likeCountMap = new HashMap<>();
		
		for(HealthDTO dto : lists) {
		    Integer key = dto.getNum();
		    Board board = boardRepository.findByNum(dto.getNum());
		    
		    if(board!=null && board.getVoter()!=null) {
		        likeCountMap.put(key, board.getVoter().size());
		        boolean liked = false;
		        for (SiteUser u : board.getVoter()) {
			        if (u.getId().equals(currentUser.getId())) {
			        	liked = true;
			        	likedMap.put(key, liked);
			            break;
			        }
			    }
		        
		    }else {
		        likeCountMap.put(key, 0);
		        likedMap.put(key, false);
		    }
		}
		
		//5.페이징 처리
		String param = "";
		
		if(searchValue!=null && !searchValue.equals("")) {
			param = "searchKey=" +searchKey;
			param += "&searchValue=" + URLEncoder.encode(searchValue,"UTF-8");
		}
		
		String listUrl = req.getContextPath() + "/imgBoard.action";
		
		if(!param.equals("")) {
			listUrl += "?" + param;
		}
		
		String pageIndexList = myUtil.pageIndexList(currentPage, totalPage,listUrl);
		
		//글보기 주소
		String articleUrl = req.getContextPath() + "/imgArticle.action?pageNum=" + currentPage;
		
		//이미지 경로
		String imgPath = req.getContextPath() + "/pds/upload";
		
		if(!param.equals("")) {
			articleUrl += "&" + param;
		}
		
		//7.ModelAndView 페이지에 넘길 데이터
		mav.addObject("lists",lists);
		mav.addObject("pageIndexList",pageIndexList);
		mav.addObject("dataCount",dataCount);
		mav.addObject("articleUrl",articleUrl);
		mav.addObject("pageNum",pageNum);
		mav.addObject("imgPath",imgPath);
		mav.addObject("likeCountMap",likeCountMap);
		mav.addObject("likedMap",likedMap);

		mav.setViewName("imgBoard");
		return mav;
	}
	
	//article - 댓글 기능 추가
	@GetMapping("/imgArticle.action")
	public ModelAndView imgArticle(
			@RequestParam("num")int num,
			@RequestParam(value="pageNum",required = false)String pageNum,
			Principal principal, HttpServletRequest req)throws Exception{
		
		//게시글 가져오기
		HealthDTO dto = boardService.getReadData(num);
		
		if(dto == null) {
			return new ModelAndView("redirect:/imgBoard.action?pageNum=" + pageNum);
		}
		
		//좋아요를 위해 추가
		Board board = boardRepository.findByNum(num);
		
		int likeCount = 0;
		boolean isLiked = false;
		SiteUser currentUser = null;
		
		if(principal!=null) {
			currentUser = userService.getUser(principal.getName());
		}
		
		if(board!=null && board.getVoter()!=null) {
			likeCount = board.getVoter().size();
			
		    for (SiteUser u : board.getVoter()) {
		        if (u.getId().equals(currentUser.getId())) {
		            isLiked = true;
		            break;
		        }
		    }
		}
		ModelAndView mav = new ModelAndView();
		//현재 로그인한 사용자 정보
		if(principal!=null) {
			String userId = principal.getName();
			mav.addObject("siteUserId",userId);
		}
		
		//이미지 경로
		String imgPath = req.getContextPath() + "/pds/upload";
		//이미지 파일 다운로드
		String downloadPath = req.getContextPath() + "/download.action";	
		//이미지 파일 삭제
		String deletePath = req.getContextPath() + "/deleted.action";
		
		//댓글 목록 추가!
		List<Answer> answerList = answerService.getAnswerList(num);
		
		System.out.println(board.getVoter().contains(currentUser));

				
		mav.setViewName("imgArticle");
		mav.addObject("dto",dto);
		mav.addObject("pageNum",pageNum);
		mav.addObject("imgPath",imgPath);
		mav.addObject("board",board);
		mav.addObject("isLiked",isLiked);
		mav.addObject("likeCount",likeCount);
		mav.addObject("currentUser",currentUser);
		mav.addObject("downloadPath",downloadPath);
		mav.addObject("deletePath",deletePath);
		mav.addObject("answerList", answerList);
		
		return mav;
	}
		
	//이미지 게시판 수정
	@GetMapping("/imgUpdated.action")
	public ModelAndView updated(
		@RequestParam("num") int num,
        @RequestParam(value="pageNum", required=false, defaultValue="1") String pageNum,
        Principal principal,HttpServletRequest req) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		HealthDTO dto = boardService.getReadData(num);
		
		if(dto==null) {
			return new ModelAndView("redirect:/imgBoard.action?pageNum=" + pageNum);
		}
		
		//로그인 사용자
		SiteUser loginUser = null;
		if(principal!=null) {
			loginUser = userService.getUser(principal.getName());
		}
		
		//작성자와 로그인 사용자 체크
		if(loginUser==null || dto.getAuthorId()!=loginUser.getId()) {
			//권한 없으면 → 상세보기 페이지(imgArticle)로 보내고 알림
	        return new ModelAndView("redirect:/imgArticle.action?num=" + num 
	                                + "&pageNum=" + pageNum 
	                                + "&error=unauthorizedUpdate");
		}
		
		mav.setViewName("imgUpdated");
		mav.addObject("dto",dto);
		mav.addObject("pageNum",pageNum);
		
		String imgPath = req.getContextPath() + "/pds/upload";
		mav.addObject("imgPath", imgPath);
		
		return mav;
	}
	
	//수정 눌렀을 때 넘어가는 방식으로 post 방식
	@PostMapping("/imgUpdated_ok.action")
	public ModelAndView imgUpdated_ok(
		@RequestParam("num") int num,
		@RequestParam("subject")String subject,
		@RequestParam("userId")String userId,
		@RequestParam("content")String content,
		@RequestParam(value="upload", required=false) MultipartFile upload,
		Principal principal,HttpServletRequest req) throws Exception{

		ModelAndView mav = new ModelAndView();
	
	try {
		
		//현재 로그인한 사용자 정보
		SiteUser loginUser = null;
		if(principal!=null) {
			loginUser = userService.getUser(principal.getName());
		}
		
		//게시글 가져오기
		HealthDTO dto = boardService.getReadData(num);
		
		if(dto == null) {
			return new ModelAndView("redirect:/imgBoard.action?pageNum=" + num);
		}
		
		// 작성자 권한 확인
        if(loginUser == null || dto.getAuthorId() != loginUser.getId()) {
            //권한 없으면 상세보기 페이지로 돌려보내고 알림
            return new ModelAndView("redirect:/imgArticle.action?num=" + num 
                                    + "&pageNum=1" 
                                    + "&error=unauthorizedUpdate");
        }
		
		//제목,내용 수정
		dto.setSubject(subject);
		dto.setUserId(userId);
		dto.setContent(content);
		
		//파일 업로드 처리
		if(upload!=null && !upload.isEmpty()) {
			//기존 파일삭제
			String root = req.getSession().getServletContext().getRealPath("/");
			String path = root + "pds" + File.separator + "upload";
			
			File oldFile = new File(path, dto.getSaveFileName());
			if(oldFile.exists()) oldFile.delete();
			
			String originalFileName = upload.getOriginalFilename();
			String saveFileName = System.currentTimeMillis() + "_" + originalFileName;

	        //서버에 파일 저장
	        File saveFile = new File(path, saveFileName);
	        upload.transferTo(saveFile);

	        dto.setOriginalFileName(originalFileName);
	        dto.setSaveFileName(saveFileName);
		}
			boardService.updateData(dto);
			return new ModelAndView("redirect:/imgArticle.action?num=" + num);

	}catch (Exception e) {
		e.printStackTrace();
		mav.addObject("message","이미지 수정 중 오류가 발생했습니다.");
		mav.setViewName("errorPage");
		return mav;
	}
	
}
	//삭제 - 업로드 & 로그인 회원 일치하지 않을 경우 삭제 불가능!
	@GetMapping("/deleted.action")
	public ModelAndView deleted(@RequestParam("num") int num,
	                           @RequestParam(value = "pageNum", required = false, defaultValue = "1") String pageNum,
	                           HttpServletRequest req,
	                           Principal principal) throws Exception {

	    ModelAndView mav = new ModelAndView();
	    
	    // 1. DB에서 HealthDTO 가져오기
	    HealthDTO dto = boardService.getReadData(num);
	    if (dto == null) {
	        mav.setViewName("redirect:/imgBoard.action?pageNum=" + pageNum);
	        return mav;
	    }
	    
	    SiteUser currentUser = userService.getUser(principal.getName());
	    /*
	    주의! 삭제 시 authorid가 일치하지 않으면 에러발생!
	    가입한 유저의 author와 파일 업로드한 유저가 일치해야 삭제 가능!
	    확인 파일 : xml,dto 확인! 
	    진행 정도 확인을 위해 syso로 확인!
	    */
	    
	    if (dto.getAuthorId()==currentUser.getId()) {
	        // 3. 서버 파일 경로 구하기
	        String deletePath = req.getServletContext().getRealPath("/pds/upload");

	        // 4. 첨부 파일 삭제
	        if (dto.getSaveFileName() != null && !dto.getSaveFileName().isEmpty()) {
	            FileManager.doFileDelete(dto.getSaveFileName(), deletePath);
	        }
	        
	        //게시글 삭제 (댓글도 자동 삭제됨)
	        boardService.deleteData(num);
	        
	        System.out.println("삭제 완료");
	        mav.setViewName("redirect:/imgBoard.action?pageNum=" + pageNum);
	        
	    }else {
	    	mav.setViewName("redirect:/imgArticle.action?num=" + num + "&pageNum=" + pageNum + "&error=unauthorized");
	    }

	    return mav;
	}

	@GetMapping("/download.action")
	public void download(@RequestParam("num") int num,
			HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		HealthDTO dto = boardService.getReadData(num);
		
		if(dto==null) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND,"파일을 찾을 수 없습니다.");
			return;
		}
		
		String downloadPath = req.getServletContext().getRealPath("/pds/upload");
		System.out.println("파일 경로: " + downloadPath);
		System.out.println("다운로드 시도: " + dto.getOriginalFileName());
		System.out.println("저장된 파일명: " + dto.getSaveFileName());
		
		//파일 존재 여부 확인
		File file = new File(downloadPath, dto.getSaveFileName());
		
		if(!file.exists()) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND,"파일이 존재하지 않습니다."
					+ dto.getOriginalFileName());
			return;
		}
		
		boolean result = FileManager.doFileDownload(resp, dto.getSaveFileName(),
				dto.getOriginalFileName(),downloadPath);
		
		if(!result) {
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
					"파일 다운로드 중 오류가 발생했습니다.");
		}else {
			System.out.println("파일 다운로드 성공: " + dto.getOriginalFileName());
		}
	}
	
	//좋아요 - 좋아요 누르더라도 삭제가능!
	@PostMapping("/board/voter/{boardNum}")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> toggleLike(@PathVariable int boardNum, Principal principal) {
	    
		Map<String, Object> result = new HashMap<>();
	    
	    try {
	        
	        Board board = boardRepository.findByNum(boardNum);
	        
	        //현재 사용자 조회
	        String userId = principal.getName();
	        SiteUser currentUser = userService.getUser(userId);
	        
	        if (board.getVoter() == null) {
	            board.setVoter(new HashSet<>());
	        }
	        
	        //좋아요 토글 처리
	        boolean isLiked;
	        
	        if (board.getVoter().contains(currentUser)) {
	            // 좋아요 취소
	            board.getVoter().remove(currentUser);
	            isLiked = false;
	        } else {
	            // 좋아요 추가
	            board.getVoter().add(currentUser);
	            isLiked = true;
	        }
	        
	        //DB에 저장
	        boardRepository.save(board);
	        
	        //응답 데이터 구성
	        result.put("likeCount", board.getVoter().size());
	        result.put("liked", isLiked);
	        
	        return ResponseEntity.ok(result);
	        
	    } catch (Exception e) {
	    	result.put("liked", false);
	        result.put("likeCount", 0);
	        
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(result);
	    }
	}
	
	
	
}