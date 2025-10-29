package com.kh.semi.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.dao.AttachmentDao;
import com.kh.semi.dto.AttachmentDto;
import com.kh.semi.error.TargetNotFoundException;

@Service
public class AttachmentService {
	@Autowired
	private AttachmentDao attachmentDao;
	
	//파일 저장을 위한 경로 생성
	private File home = new File(System.getProperty("user.home"));
	private File upload = new File(home, "my_uploads");
	
	//파일 저장 메소드
	@Transactional
	public int save(MultipartFile attach) throws IllegalStateException, IOException {
		int attachmentNo = attachmentDao.sequence();
		
		if(upload.exists() == false) { //업로드할 폴더 없을 경우
			upload.mkdirs(); //폴더 생성
		}
		//업로드할 폴더 있을 경우 저장 진행
		File target = new File(upload, String.valueOf(attachmentNo));
		attach.transferTo(target);
		
		//DB에 저장된 파일 정보 기록
		AttachmentDto attachmentDto 
			= AttachmentDto.builder()
				.attachmentNo(attachmentNo)
				.attachmentName(attach.getOriginalFilename())
				.attachmentType(attach.getContentType())
				.attachmentSize(attach.getSize())
				.build();
		
		attachmentDao.insert(attachmentDto);
		
		return attachmentNo;
	}
	
	//파일 불러오기
	public ByteArrayResource load(int attachmentNo) throws IOException {
		//파일 찾기
		File target = new File(upload, String.valueOf(attachmentNo));
		//파일 존재하지 않을 경우 예외 처리
		if(target.isFile() == false) throw new TargetNotFoundException("존재하지 않는 파일");
		
		//파일 읽어오기
		//target의 경로를 얻어와서 모든 파일 내용을 바이트 배열로 읽음
		byte[] data = Files.readAllBytes(target.toPath());
		
		//읽어온 바이트 배열을 ByteArrayResource 형태로 포장 
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return resource;
	}
	
	//파일 삭제(DB 및 실물 파일 삭제)
	public void delete(int attachmentNo) {
		
		//파일 존재 여부 확인
		AttachmentDto attachmentDto = attachmentDao.selectOne(attachmentNo);
		//존재하지 않으면 리턴
		 if(attachmentDto == null) {
		        // 파일이 이미 없으면 그냥 리턴
		        return;
		    }
		//실제 파일 삭제
		//경로 정보를 담은 File 객체 생성
		File target = new File(upload, String.valueOf(attachmentNo));
		target.delete();
		
		//DB 정보 삭제
		attachmentDao.delete(attachmentNo);
	}
}
