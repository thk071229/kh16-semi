package com.kh.semi.controller;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.AttachmentDao;
import com.kh.semi.dto.AttachmentDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.service.AttachmentService;

@Controller
@RequestMapping("/attachment")
public class AttachmentController {
	@Autowired
	private AttachmentDao attachmentDao;
	
	@Autowired
	private AttachmentService attachmentService;
	
	@GetMapping("/download")
	public ResponseEntity<ByteArrayResource> download(@RequestParam int attachmentNo) throws IOException{
		
		//파일 조회 후 예외 처리
		AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);
		if(attachmentDto == null) throw new TargetNotFoundException("존재하지 않는 파일");
		
		//통과하면 attachmentService에서 파일 불러옴
		ByteArrayResource resource = attachmentService.load(attachmentNo);
		
		return ResponseEntity.ok()
				//문자 인코딩 정보 지정(한글 포함되어도 깨지지 않도록)
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				//파일 MIME 타입 지정
				.header(HttpHeaders.CONTENT_TYPE, attachmentDto.getAttachmentType())
				//파일 크기 설정(브라우저가 다운로드 진행 상태 표시할 때)
				.contentLength(attachmentDto.getAttachmentSize())
				//브라우저에서의 파일 처리 방식 설정
				.header(HttpHeaders.CONTENT_DISPOSITION, ContentDisposition
						//첨부파일로 다운로드하도록 지정
						.attachment()
						//파일 이름을 .getAttachmentName()으로 설정하고 
						//한글 파일명 깨지지 않도록 UTF-8 인코딩 적용
						.filename(attachmentDto.getAttachmentName(), StandardCharsets.UTF_8)
						//build()로 ContentDisposition 객체 완성
						.build()
						//toString()으로 문자열 변환 후 헤더 값 설정
						.toString())
				//본문에 실제 파일 데이터를 담아서 응답
				.body(resource);
	}
}
