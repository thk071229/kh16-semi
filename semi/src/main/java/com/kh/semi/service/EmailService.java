package com.kh.semi.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Random;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.semi.dao.CertDao;
import com.kh.semi.dto.CertDto;
import com.kh.semi.dto.MemberDto;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {
	@Autowired
	private JavaMailSender sender;
	@Autowired
	private CertDao certDao;
	
	public void sendEmail(String to, String subject, String text) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject(subject);
		message.setText(text);
		sender.send(message);
	}

	public void sendCertNumber(String email) {
		//랜덤번호 생성
		Random r = new Random();
		int number = r.nextInt(1000000);
		DecimalFormat df = new DecimalFormat("000000");
		String certNumber = df.format(number);
		
		//메세지 생성 및 전송
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("[KH정보교육원] 인증번호를 확인하세요");
		message.setText("인증번호는 ["+certNumber+"] 입니다");
		sender.send(message);
		
		//인증번호를 DB에 저장하는 코드
		CertDto certDto = certDao.selectOne(email);
		if(certDto == null) {//인증메일을 보낸 기록이 없다면 ----> insert
			certDao.insert(CertDto.builder()
						.certEmail(email).certNumber(certNumber)
					.build());
		}
		else {//인증메일을 보낸 기록이 있다면 ----> update
			certDao.update(CertDto.builder()
						.certEmail(email).certNumber(certNumber)
					.build());
		}
	}
	
	public void sendWelcomeMail(MemberDto memberDto) throws MessagingException, IOException {
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		
		helper.setTo(memberDto.getMemberEmail());
		helper.setSubject("[KH정보교육원] 가입을 환영합니다!");
		
		//이메일 본문 생성
		ClassPathResource resource = new ClassPathResource("templates/welcome2.html");
		File target = resource.getFile();
		
		StringBuffer buffer = new StringBuffer();
		BufferedReader reader = new BufferedReader(new FileReader(target));
		while(true) {
			String line = reader.readLine();
			if(line == null) break;
			buffer.append(line);
		}
		reader.close();
		
		//helper.setText(buffer.toString(), true);//기존 코드(그대로 전송)
		
		//(+추가) 불러온 HTML 템플릿에서 특정 태그를 찾아 내용을 변경 후 전송
		//jQuery였다면...   $("#target").text("???")  ,  $("#link").attr("href", "주소")
		
		Document document = Jsoup.parse(buffer.toString());//String을 HTML로 해석
		Element targetId = document.selectFirst("#target");//id=target인 대상을 탐색
		Element targetLink = document.selectFirst("#link");//id=link인 대상을 탐색
		targetId.text(memberDto.getMemberNickname());//textContent변경
		
		//targetLink.attr("href", "http://localhost:8080");//attribute 변경
		//(+추가) 현재 접속중인 홈페이지의 주소에 기반해서 링크의 이동 경로를 설정
		String url = ServletUriComponentsBuilder
				.fromCurrentContextPath()//http://localhost:8080
				.path("/")//홈페이지
				//.path("/board/list")//게시판 
				.build().toUriString();
		targetLink.attr("href", url);//attribute 변경
		
		helper.setText(document.toString(), true);//HTML로 해석된 내용을 본문으로 설정
		
		sender.send(message);
	}

	//비밀번호 재설정 이메일 발송
	public void sendResetPassword(MemberDto memberDto) throws MessagingException, IOException {
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		
		//정보 설정
		helper.setTo(memberDto.getMemberEmail());//수신인 설정
		helper.setSubject("[KH정보교육원] 비밀번호를 재설정하세요");
		
		ClassPathResource resource = new ClassPathResource("templates/reset.html");
		File target = resource.getFile();
		
		StringBuffer buffer = new StringBuffer();
		BufferedReader reader = new BufferedReader(new FileReader(target));
		while(true) {
			String line = reader.readLine();
			if(line == null) break;
			buffer.append(line);
		}
		reader.close();
		
		Document document = Jsoup.parse(buffer.toString());//String을 HTML로 해석
		Element targetId = document.selectFirst("#target");//id=target인 대상을 탐색
		Element targetLink = document.selectFirst("#link");//id=link인 대상을 탐색
		
		targetId.text(memberDto.getMemberNickname());//닉네임 설정
		
		Random r = new Random();
		DecimalFormat df = new DecimalFormat("000000");
		int number = r.nextInt(1000000);
		String certNumber = df.format(number);//최종 인증번호(6자리)
		
		String url = ServletUriComponentsBuilder
				.fromCurrentContextPath()
				.path("/member/changeMemberPw")
				.queryParam("memberId", memberDto.getMemberId())//회원 ID
				.queryParam("certNumber", certNumber)//인증번호
				.build().toUriString();
		targetLink.attr("href", url);//비밀번호 재설정 페이지 주소 안내
		
		helper.setText(document.toString(), true);//이메일 본문 설정
		
		sender.send(message);
		
		//인증 테이블에 등록
		certDao.insert(CertDto.builder()
					.certEmail(memberDto.getMemberEmail())
					.certNumber(certNumber)
				.build());
	}
	
}
