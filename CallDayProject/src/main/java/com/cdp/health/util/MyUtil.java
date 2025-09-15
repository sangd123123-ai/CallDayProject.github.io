package com.cdp.health.util;

public class MyUtil {//페이징 처리
	
	//전체 페이지 갯수
	public int getPageCount(int numPerPage, int dataCount) {
		
		int pageCount = 0;
		
		pageCount = dataCount / numPerPage;
		
		if (dataCount % numPerPage != 0) {
			
			pageCount++;
			
		}
		
		return pageCount;
		
	}
	
	//Ajax 페이징 처리 (자바스크립트)
	public String pageIndexList(int currentPage, int totalPage) {
		
		int numPerBlock = 5;
		
		int currentPageSetup;
		
		int page;
		
		String strList = "";
		
		if (currentPage==0) {
			
			return "";
			
		}
		
		currentPageSetup = (currentPage/numPerBlock) * numPerBlock;
		
		if (currentPage%numPerBlock==0) {
			
			currentPageSetup = currentPageSetup - numPerBlock;
			
		}
		
		if (totalPage > numPerBlock && currentPageSetup > 0) {
			
			strList = "<a onclick='listPage(" + currentPageSetup +
					");'>◀이전</a>&nbsp;";
			
		}
		
		page = currentPageSetup + 1;
		
		while ((page<=totalPage) && (page<=currentPageSetup+numPerBlock)) {
			
			if (page==currentPage) {
				
				strList += "<font color='Fuchsia'>" + page + 
						"</font>&nbsp;";
				
			} else {
				
				strList += "<a onclick='listPage(" + page + ");'>" +
						page + "</a>&nbsp;";
				
			}
			
			page++;
			
		}
		
		if (totalPage-currentPageSetup > numPerBlock) {
			
			strList += "<a onclick='listPage(" + page +
					");'>다음▶</a>&nbsp;";
			
		}
		
		return strList;
		
	}
	
	//페이징 처리 메소드
	public String pageIndexList(int currentPage, int totalPage, String listUrl) {
		
		int numPerBlock = 5; //페이지가 보여지는 갯수
		
		int currentPageSetup;//현재 보여지고 있는 페이지리스트의 전
		
		int page;
		
		StringBuffer sb = new StringBuffer();
		
		if (currentPage==0 || totalPage==0) {
			
			return "";
			
		}
		
		//list.jsp
		//list.jsp?searchKey=name&searchValue=30
		if (listUrl.indexOf("?")!=-1) {//검색
			
//			listUrl = listUrl + "&";
			listUrl += "&";
			
		} else {
			
//			listUrl = listUrl + "?";
			listUrl += "?";
			
		}
		
		//이전의 pageNum
		currentPageSetup = (currentPage/numPerBlock)*numPerBlock;
		
		if (currentPage % numPerBlock == 0) {
			
			currentPageSetup = currentPageSetup - numPerBlock;
			
		}
		
		//이전링크
		if (totalPage>numPerBlock && currentPageSetup>0) {
			
			sb.append("<a href=\"" + listUrl + "pageNum=" + currentPageSetup 
					+ "\">◀이전</a>&nbsp;");
			
		}
		
		//바로가기 페이지
		page = currentPageSetup + 1;
		while (page<=totalPage && page<=(currentPageSetup+numPerBlock)) {
			
			if (page==currentPage) {
				
				sb.append("<font color=#0100FF>" + page +
						"</font>&nbsp;");
				
			} else {
				
				sb.append("<a href=\"" + listUrl + "pageNum=" +
				page + "\">" + page + "</a>&nbsp;");
				
			}
			
			page++;
			
		}
		
		//다음링크
		if (totalPage - currentPageSetup > numPerBlock) {
			
			sb.append("<a href=\"" + listUrl + "pageNum=" + page
					+ "\">다음▶</a>&nbsp;");
			
		}
		
		return sb.toString();
		
	}
	
}
