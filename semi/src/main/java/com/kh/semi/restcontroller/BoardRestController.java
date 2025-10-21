package com.kh.semi.restcontroller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.service.AttachmentService;

@CrossOrigin
@RestController
@RequestMapping("/rest/board")
public class BoardRestController {
	
	@Autowired
	private AttachmentService attachmentService;
	
	//임시 이미지 업로드를 위한 매핑
	@PostMapping("/temp")
	public int temp(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		if(attach.isEmpty()) throw new TargetNotFoundException("파일이 업로드 되지 않았습니다");
		
		return attachmentService.save(attach);
	}
	
	//여러 개의 이미지를 업로드 하기 위한 매핑
	@PostMapping("/temps")
	public List<Integer> temps(@RequestParam(value = "attach") List<MultipartFile> attachList) throws IllegalStateException, IOException{
		List<Integer> numbers = new ArrayList<>();
		//attachList에서 attach를 꺼내온다
		for(MultipartFile attach : attachList) {
			//파일이 있을 경우에만 저장하고 numbers에 attachmentNo 추가
			if(attach.isEmpty() == false) {
				int attachmentNo = attachmentService.save(attach);
				numbers.add(attachmentNo);
			}
		}
		return numbers;
	}
}
