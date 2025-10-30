package com.kh.semi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.semi.dao.BuyDao;
import com.kh.semi.dao.CountDao;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.MemberRegionDao;
import com.kh.semi.dto.BuyDto;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.dto.MemberRegionDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.error.UnauthorizationException;
import com.kh.semi.vo.MemberActiveVO;

@Service
public class MemberService {

    //private final EmailConfiguragion emailConfiguragion;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private AttachmentService attachmentService;
	@Autowired
	private RegionService regionService;
	@Autowired
	private MemberRegionDao memberRegionDao;
	@Autowired
	private CountDao countDao;
	@Autowired
	private BuyDao buyDao;

	/*
	 * MemberService(EmailConfiguragion emailConfiguragion) {
	 * this.emailConfiguragion = emailConfiguragion; }
	 */
	
	
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
	public void addMemberRegion(String memberId, String regionName, String regionDepth1, String regionDepth2, String regionType) {
		// regionNo 가져오기
		int regionNo = regionService.createRegion(regionName, regionDepth1, regionDepth2);		
		// member_region에 저장
		MemberRegionDto memberRegionDto = new MemberRegionDto();
		memberRegionDto.setMemberId(memberId);
		memberRegionDto.setRegionNo(regionNo);
		memberRegionDto.setRegionType(regionType);
		//memberRegionDao에 insert
		memberRegionDao.insert(memberRegionDto);
	}
	
	@Transactional
	public void editMemberRegion(String memberId, String regionName, String regionDepth1, String regionDepth2, String regionType) {
		List<MemberRegionDto> regionList = memberRegionDao.selectRegionById(memberId);

		// 등록된 지역이 없는 경우 → 새로 insert
		if (regionList.isEmpty()) {
			int regionNo = regionService.createRegion(regionName, regionDepth1, regionDepth2);
			MemberRegionDto newDto = new MemberRegionDto();
			newDto.setMemberId(memberId);
			newDto.setRegionNo(regionNo);
			newDto.setRegionType(regionType);
			memberRegionDao.insert(newDto); // insert 메서드가 있어야 함
			return;
		}
		
	    // 등록된 지역이 있는 경우 → update 로직 수행
		MemberRegionDto oldMemberRegionDto = regionList.get(0);
		
		// 기존 regioNo 찾기
		int oldRegionNo = oldMemberRegionDto.getRegionNo();
		
		// 새로운 regionNo 가져오기
		int regionNo = regionService.createRegion(regionName, regionDepth1, regionDepth2);
		
		MemberRegionDto memberRegionDto = new MemberRegionDto();
		memberRegionDto.setMemberId(memberId);
		memberRegionDto.setRegionNo(regionNo);
		memberRegionDto.setRegionType(regionType);
		memberRegionDao.update(memberRegionDto, oldRegionNo);
		
	}
	
	
	// 활동에 따라 포인트 갱신
	@Transactional
	public void refreshMemberPoint(String loginId) {
	MemberActiveVO memberActiveVO = countDao.selectOneWithActive(loginId);
	countDao.updateMemberPoint(memberActiveVO);
	}
	
	
	@Transactional
	public void updateMemberAuthorityWithBuy(String loginId) {
		//시퀀스 생성
		MemberDto memberDto = memberDao.selectOne(loginId);
		if(memberDto == null) throw new TargetNotFoundException("존재하지 않는 회원");
		if(memberDto.getMemberAuthority().equals("n")) {//authority가 n이면
			int buyNo = buyDao.sequence();
			BuyDto buyDto = new BuyDto();
			buyDto.setBuyNo(buyNo);
			buyDto.setMemberId(loginId);
			buyDao.insert(buyDto);
			memberDao.updateMemberAuthority(loginId);
		}
		else {
			throw new TargetNotFoundException("이미 모임 생성권한이 있습니다");
		}
	}
	
	
}
