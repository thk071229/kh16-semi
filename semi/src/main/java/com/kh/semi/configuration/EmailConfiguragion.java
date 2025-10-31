package com.kh.semi.configuration;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class EmailConfiguragion {

	//스프링에서는 서버가 시작되면 @Bean을 자동으로 등록하도록 설계되어 있다
		@Bean
		public JavaMailSenderImpl sender() {
			//메일 발송 도구 생성
			JavaMailSenderImpl sender = new JavaMailSenderImpl();
			
			//서비스 제공자 정보 설정
			sender.setHost("smtp.gmail.com");//이용할 업체의 호스트 정보
			sender.setPort(587);//이용할 업체의 포트 번호
			sender.setUsername("sirusiru1209@gmail.com");//이용할 업체의 사용자 계정이름 (자격이 있는 계정)
			sender.setPassword("kioqhzfpjtgzbmoo");//이용할 업체의 사용자 비밀번호 (G메일은 앱 비밀번호)
			
			Properties props = new Properties();//추가 정보를 담을 저장소(String, String 형태의 Map)
			props.setProperty("mail.smtp.auth", "true");//이메일 발송에 인증을 사용(무조건 true)
			props.setProperty("mail.smtp.debug", "true");//이메일 발송과정을 자세하게 출력(오류 해결용)
			props.setProperty("mail.smtp.starttls.enable", "true");//STARTTLS 사용 (보안용 통신방식)
			props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");//TLS 방식의 버전 선택
			props.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");//신뢰할 수 있는 인증서 발급자 지정
			sender.setJavaMailProperties(props);
			
			return sender;
		}
}
