package com.kh.semi.aop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration //설정 파일로 등록
public class InterceptorConfiguration implements WebMvcConfigurer{
	@Autowired
	private MemberLoginInterceptor memberLoginInterceptor;
	
	@Autowired
	private MemberJoinInterceptor memberJoinInterceptor;
	
	@Autowired
	private BoardReadInterceptor boardReadInterceptor;
	
	@Autowired
	private BoardOwnerInterceptor boardOwnerInterceptor;
	
	@Autowired
	private EventOwnerInterceptor eventOwnerInterceptor;
	
	@Autowired
	private ClubJoinCheckInterceptor clubJoinCheckInterceptor;
	
	@Autowired
	private AdminInterceptor adminInterceptor;
	
	@Autowired
	private ClubAdminInterceptor clubAdminInterceptor;

	
	@Override
	//인터셉터 등록 메소드
	public void addInterceptors(InterceptorRegistry registry) {
		//비회원 접근 차단 인터셉터(현재 board 관련 주소만 막아둠)
		registry.addInterceptor(memberLoginInterceptor)
					.addPathPatterns(
							"/board/**", 
							// 로그인해야 접속 가능
							"/event/detail/**","/event/add/**","/event/edit/**","/member/**",
							//좋아요 못누르도록 차단
							"/rest/image/**", "/rest/board/action", "/rest/reply/**",
							"/club/add","club/edit","/club/delete",
							"/clubMember/**",
							"rest/club/action", "rest/club/check")
					.excludePathPatterns("/board/list*",
										"/rest/reply/list", "/rest/reply/check", 
										"/member/join", "/member/login", "/member/goodbye", 
										"/member/findMemberId", "/member/findMemberIdFinish",
										"/member/findMemberPw", "/member/findMemberPwFinish",
										"/member/firstLogin", "/member/changeMemberPw", "/member/changeMemberPwFinish",
										"/member/agree")
					.order(1);
		//회원의 회원가입 페이지 접근 차단 인터셉터
		registry.addInterceptor(memberJoinInterceptor)
					.addPathPatterns("/member/join*", "/member/agree")
					.excludePathPatterns("/member/joinFinish")
					.order(2);
		
		//관리자 검사용 인터셉터
		registry.addInterceptor(adminInterceptor)
					.addPathPatterns("/admin/**")
					.order(3);
		
		//게시글 수정 및 삭제 접근 차단 인터셉터
		registry.addInterceptor(boardOwnerInterceptor)
					.addPathPatterns("/board/edit", "/board/delete");
					//.order(순서)
		
		//정모내역(글) 수정 및 삭제 접근 차단 인터셉터
		registry.addInterceptor(eventOwnerInterceptor)
					.addPathPatterns("/event/edit", "/event/delete");
		
		//조회 수 중복방지 인터셉터
		registry.addInterceptor(boardReadInterceptor)
					.addPathPatterns("/board/detail");
					//.order(순서)
					//추후에 맨 마지막 순서로 변경
		
		// 가입한 소모임 정모만 등록 가능
		registry.addInterceptor(clubJoinCheckInterceptor)
				.addPathPatterns("/event/add","/board/write");
		
		//관리자의 소모임 생성 기능 차단
		registry.addInterceptor(clubAdminInterceptor)
		.addPathPatterns("/club/add", "/club/edit", "/member/pointUse")
		.excludePathPatterns("/club/delete");
	}
}
