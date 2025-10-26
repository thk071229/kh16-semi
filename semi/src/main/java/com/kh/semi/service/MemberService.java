package com.kh.semi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.kh.semi.configuration.EmailConfiguragion;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.MemberRegionDao;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.dto.MemberRegionDto;
import com.kh.semi.error.TargetNotFoundException;

@Service
public class MemberService {

    private final EmailConfiguragion emailConfiguragion;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private AttachmentService attachmentService;
	@Autowired
	private RegionService regionService;
	@Autowired
	private MemberRegionDao memberRegionDao;


    MemberService(EmailConfiguragion emailConfiguragion) {
        this.emailConfiguragion = emailConfiguragion;
    }
	
	
	//회원 탈퇴 서비스
	@Transactional
	public boolean drop(String memberId, String memberPw) {
		//DB에 존재하는 회원정보 조회
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) throw new TargetNotFoundException("존재하지 않는 회원");
		
		//비밀번호 비교
		boolean isValid = memberDto.getMemberPw().equals(memberPw);
		if(isValid == false) return false;
		
		//회원 프로필 사진 삭제
		try {
			int attachmentNo = memberDao.findAttachment(memberId);
			attachmentService.delete(attachmentNo);
		}
		catch(Exception e) {/* 프로필이 없을 경우 예외 발생 */};
		
		//회원 정보 삭제
		memberDao.delete(memberId);
		
		return true;
	}
	//(추가) 회원가입 시 지역 설정
	@Transactional
	public void addMemberRegion(String memberId, String regionName, String regionType) {
		// regionNo 가져오기
		int regionNo = regionService.createRegion(regionName);
		
		// member_region에 저장
		MemberRegionDto memberRegionDto = new MemberRegionDto();
		memberRegionDto.setMemberId(memberId);
		memberRegionDto.setRegionNo(regionNo);
		memberRegionDto.setRegionType(regionType);
		//memberRegionDao에 insert
		memberRegionDao.insert(memberRegionDto);
	}
	
}
