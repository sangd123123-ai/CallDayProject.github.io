package com.cdp.health.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ContentDisposition;
import org.springframework.web.servlet.function.ServerRequest.Headers;

public class FileManager {//파일 다운로드, 삭제 기능

	//file download
	public static boolean doFileDownload(HttpServletResponse resp,
				String saveFileName, String originalFileName, String path) {
			
		try {
	        // 파일 경로
	        String filePath = path + File.separator + saveFileName;
	        File f = new File(filePath);
	        
	        System.out.println("파일 다운로드 시도: " + filePath);
            System.out.println("파일 존재 여부: " + f.exists());
            System.out.println("파일 크기: " + f.length());

	        if (!f.exists()) {
	        	System.out.println("파일이 존재하지 않습니다: " + filePath);
	        	return false; // 파일이 없으면 false 반환
	        }

	        // 다운로드될 파일명 지정
	        if (originalFileName == null || originalFileName.equals("")) {
	            originalFileName = saveFileName;
	        }

	        // 파일명 인코딩 (한글 깨짐 방지)
	        String encodedFileName = java.net.URLEncoder.encode(originalFileName, "UTF-8")
	                .replaceAll("\\+", "%20");

	        // 응답 헤더 설정 개선
	        resp.reset(); // 기존 헤더 초기화
	        resp.setContentType("application/octet-stream");//임의의 8비트 데이터
	        resp.setCharacterEncoding("UTF-8");
            //해당 파일은 다운로드용으로 원래 파일명 보여달라고 전달
            resp.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName + "; filename=\"" + encodedFileName + "\"");
            resp.setHeader("Content-Length", String.valueOf(f.length()));
            resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            resp.setHeader("Pragma", "no-cache");
            resp.setHeader("Expires", "0");

	        //파일을 효율적으로 읽어들이기 위해 BufferedInputStream
	        try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(f));
	             OutputStream out = resp.getOutputStream()) {

	            byte[] buffer = new byte[8192];
	            int data;
	            while ((data = bis.read(buffer)) != -1) {
	                out.write(buffer, 0, data);
	            }
	            out.flush();
	            System.out.println("파일 다운로드 완료:" + originalFileName);
	        }

	    } catch (Exception e) {
	        System.out.println("File Download Error: " + e.toString());
	        return false;
	    }
	    return true;
	}
		
	//물리적 file delete 저장된 파일 이름(fileName)과 위치(path)가 필요
	//fileName == saveFileName
	public static void doFileDelete(String fileName, String path) {

		try {

			//실제 파일위치의 주소 + 파일명
			String filePath = path + File.separator + fileName;

			File f = new File(filePath);

			//해당 파일이 존재하는지 확인
			if (f.exists()) {
				boolean delete = f.delete();
				System.out.println("파일 삭제" + (delete?"성공" : "실패") + ": " + filePath);
			}else {
				System.out.println("삭제할 파일이 존재하지 않습니다.: " + filePath);
			}

		} catch (Exception e) {
			System.out.println("파일 삭제 에러: " + e.toString());
			e.printStackTrace();
		}

	}

}
