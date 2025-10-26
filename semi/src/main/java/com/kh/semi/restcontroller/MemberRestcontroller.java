package com.kh.semi.restcontroller;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.dao.CertDao;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.dto.CertDto;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.service.AttachmentService;
import com.kh.semi.service.EmailService;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/member")
public class MemberRestcontroller {

	@Autowired
	private MemberDao memberDao;
	@Autowired
	private AttachmentService attachmentService;
	@Autowired
	private EmailService emailService;
	@Autowired
	private CertDao certDao;

	@GetMapping("/checkMemberId")
	public boolean checkMemberId(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		return memberDto != null;
	}

	@GetMapping("/checkMemberNickname")
	public boolean checkMemberNickname(@RequestParam String memberNickname) {
		MemberDto memberDto = memberDao.selectOneByNickname(memberNickname);
		return memberDto != null;
	}

	// 프로필 변경 매핑
	@PostMapping("/profile")
	public void profile(HttpSession session, @RequestParam MultipartFile attach)
			throws IllegalStateException, IOException {
		String loginId = (String) session.getAttribute("loginId");

		// 기존 파일 삭제 (없을 수도 있음)
		try {
			int attachmentNo = memberDao.findAttachment(loginId);
			attachmentService.delete(attachmentNo);
		} catch (Exception e) {
			/* 아무것도 안함 */}

		// 신규파일 등록
		if (attach.isEmpty() == false) {
			int attachmentNo = attachmentService.save(attach);			memberDao.connect(loginId, attachmentNo);
		}
	}

	// 프로필 삭제 매핑
	@PostMapping("/delete")
	public void delete(HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");

		// 기존 파일 삭제(없을 수도 있음)
		try {
			int attachmentNo = memberDao.findAttachment(loginId);
			attachmentService.delete(attachmentNo);
		} catch (Exception e) {
			/* 아무것도 안함 */}
	}

	@PostMapping("/certSend")
	public void certSend(@RequestParam String certEmail) {
		emailService.sendCertNumber(certEmail);
	}
	
	@PostMapping("/certCheck")
	public boolean certCheck(@ModelAttribute CertDto certDto) {
		//[1] 이메일로 인증정보를 조회
		CertDto findDto = certDao.selectOne(certDto.getCertEmail());
		if(findDto == null) return false;//인증메일을 보낸적이 없대!
		
		//[2] 유효시간 검사
		LocalDateTime current = LocalDateTime.now();
		LocalDateTime sent = findDto.getCertTime().toLocalDateTime();
		Duration duration = Duration.between(sent, current);
		//if(duration.toMinutes() > 10) return false;//10분 초과! (10분 59초 초과)
		if(duration.toSeconds() > 600) return false;//10분 초과! (10분 0초 초과)
		
		//[3] 인증번호 검사
		//boolean isValid = certDto.getCertNumber() == findDto.getCertNumber();
		boolean isValid = certDto.getCertNumber().equals(findDto.getCertNumber());
		if(isValid == false) return false;//인증번호가 틀렸대!
		
		//다 통과했으면 인증 완료! (+인증내역 삭제)
		certDao.delete(certDto.getCertEmail());
		return true;
	}
}
