package com.cdp.health.board.answer;

import java.security.Principal;
import java.time.LocalDateTime;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.cdp.health.board.Board;
import com.cdp.health.board.service.BoardRepository;
import com.cdp.health.board.service.BoardService;
import com.cdp.health.dto.answer.Answer;
import com.cdp.health.dto.answer.AnswerDTO;
import com.cdp.health.dto.answer.AnswerForm;
import com.cdp.health.user.SiteUser;
import com.cdp.health.user.UserService;
import com.cdp.health.util.MyUtil;

@Controller
public class AnswerController {
	
	@Autowired
	private AnswerService answerService;
	@Autowired
	private UserService userService;
	@Autowired
	private BoardRepository boardRepository;

	//댓글 작성
	@PostMapping("/answer/create/{boardNum}")
    public String createAnswer(
            @PathVariable("boardNum") int boardNum,
            @RequestParam("content") String content,
            @RequestParam(value = "pageNum", defaultValue = "1") String pageNum,
            Principal principal) throws Exception {

        	SiteUser loginUser = userService.getUser(principal.getName());

            // 게시글 존재 확인
            Board board = boardRepository.findByNum(boardNum);
            if (board == null) {
                return "redirect:/imgBoard.action";
            }
            int maxNum = answerService.maxNum();

            //댓글 객체 생성 및 데이터 저장
            Answer answer = new Answer();
            
            answer.setNum(maxNum+1);
            answer.setContent(content);
            answer.setAuthor(loginUser);
            answer.setBoard(board);

            // 댓글 저장
            answerService.createAnswer(answer);

        // 게시글 상세페이지로 리다이렉트
        return "redirect:/imgArticle.action?num=" + boardNum + "&pageNum=" + pageNum;
    }
	
//	//댓글 수정 폼 - 권한 없으면 수정 불가능!
//	@GetMapping("/answer/modify/{answerId}")
//    public String modifyAnswerForm(
//            @PathVariable("answerId") int answerId,
//            @RequestParam("boardNum") int boardNum,
//            @RequestParam(value = "pageNum", defaultValue = "1") String pageNum,
//            Principal principal) throws Exception {
//
//		//현재 로그인한 사용자 정보
//		SiteUser loginUser = userService.getUser(principal.getName());
//		Answer answer = answerService.getAnswer(answerId);
//
//		// 댓글 수정 권한 확인 (answer 또는 author 가 null 인 경우 방어)
//		if (answer == null || answer.getAuthor() == null 
//	            || !answer.getAuthor().getId().equals(loginUser.getId())) {
//	        return "redirect:/imgArticle.action?num=" + boardNum 
//	                + "&pageNum=" + pageNum + "&error=unauthorizedAnswerModify";
//	    }
//
//        return "answerModify";
//    }
	
	@PostMapping("/answer/modify")
	public String modifyAnswer(
	        @RequestParam("answerId") int answerId,
	        @RequestParam("content") String content,
	        @RequestParam("boardNum") int boardNum,
	        @RequestParam(value="pageNum", required=false, defaultValue="1") int pageNum,
	        Principal principal) throws Exception {

	    SiteUser loginUser = userService.getUser(principal.getName());
	    Answer answer = answerService.getAnswer(answerId);

	    if(answer == null || answer.getAuthor() == null 
	    	       || !answer.getAuthor().getId().equals(loginUser.getId())) {
	    	        return "redirect:/imgArticle.action?num=" + boardNum 
	    	                + "&pageNum=" + pageNum + "&error=unauthorizedAnswerModify";
	    	    }
	    
	    answer.setContent(content);
	    answerService.modify(answer);

	    // 댓글 수정 후 게시글 상세보기로 리다이렉트
	    return "redirect:/imgArticle.action?num=" + boardNum + "&pageNum=" + pageNum;
	}

	
	//댓글 삭제
	@GetMapping("/answer/delete/{answerId}")
	@Transactional
    public String deleteAnswer(
            @PathVariable("answerId") int answerId,
            @RequestParam("boardNum") int boardNum,
            @RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
            Principal principal) throws Exception {

		SiteUser loginUser = userService.getUser(principal.getName());
		Answer answer = answerService.getAnswer(answerId);
		
		// 권한 체크
	    if (answer != null && answer.getAuthor() != null 
	            && answer.getAuthor().getId().equals(loginUser.getId())) {
	        answerService.delete(answerId);
	    } else {
	        return "redirect:/imgArticle.action?num=" + boardNum 
	                + "&pageNum=" + pageNum + "&error=unauthorizedAnswerDelete";
	    }

	    return "redirect:/imgArticle.action?num=" + boardNum + "&pageNum=" + pageNum;
	}
	
}	
	
	