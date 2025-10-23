package com.kh.semi.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.ClubMemberDao;
import com.kh.semi.dto.ClubDto;
import com.kh.semi.dto.ClubMemberDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.error.UnauthorizationException;

@Service
public class ClubService {

	@Autowired
	private ClubDao clubDao;
	@Autowired
	private ClubMemberDao clubMemberDao;
	@Autowired
	private RegionService regionService;
	@Autowired
	private AttachmentService attachmentService;
	
	@Transactional
	public void createClub(ClubDto clubDto, String regionName, MultipartFile attach) throws IllegalStateException, IOException{
		  int regionNo = regionService.createRegion(regionName);
		  clubDto.setClubRegion(regionNo);
		  
		  // 3. (신규) 파일 저장 로직
		  if(attach != null && !attach.isEmpty()) { // 파일이 있다면
		      int attachmentNo = attachmentService.save(attach); // 파일 저장
		      clubDto.setClubProfile(attachmentNo); // DTO에 번호 세팅
		 }
		  // 시퀀스 생성
		  int clubNo = clubDao.sequence();
		  clubDto.setClubNo(clubNo);
		  clubDao.insert(clubDto);
		  //club_member 테이블 모임장 추가
		  ClubMemberDto clubMemberDto = new ClubMemberDto();
		  clubMemberDto.setClubNo(clubDto.getClubNo());
		  clubMemberDto.setClubMember(clubDto.getClubLeader());//클럽 생성자 아이디
		  clubMemberDto.setClubMemberRole("모임장");
		  clubMemberDao.insert(clubMemberDto);
		}
	
	//모임장 변경 시 club_member와 club 컬럼 변경 메소드
	@Transactional
	public void changeClubLeader(int clubNo, String newLeader, String loginId){
		  // 1. 권한 확인
		  ClubDto findDto = clubDao.selectOne(clubNo);
		  String currentLeader = findDto.getClubLeader();
		  if(currentLeader.equals(loginId) == false) throw new UnauthorizationException("모임장만 위임 가능합니다");
		  
		  //2. club_leader 변경(club 테이블)
		  boolean success1 = clubDao.changeClubLeader(clubNo, newLeader);
		  if(!success1) throw new TargetNotFoundException("변경 실패");
		  
		  //3. 기존 모임장을 일반회원으로 변경(club_member)
		  ClubMemberDto currentClubDto = new ClubMemberDto();
		  currentClubDto.setClubNo(clubNo);
		  currentClubDto.setClubMember(currentLeader);//현재 클럽장
		  currentClubDto.setClubMemberRole("일반회원");
		  
		  boolean success2 = clubMemberDao.updateRole(currentClubDto);
		  if(!success2) throw new TargetNotFoundException("변경 실패");
		  
		  //4. 신규 모임장을 승급
		  ClubMemberDto newLeaderDto = new ClubMemberDto();
		  newLeaderDto.setClubNo(clubNo);
		  newLeaderDto.setClubMember(newLeader);
		  newLeaderDto.setClubMemberRole("모임장");
		  
		  boolean success3 = clubMemberDao.updateRole(newLeaderDto);
		  if(!success3) throw new TargetNotFoundException("변경 실패");
}
	@Transactional
	public void updateClub(ClubDto clubDto, MultipartFile attach) throws IllegalStateException, IOException {//api확인 후 수정 메소드도 추가해야 할듯
		if(attach != null && attach.isEmpty() == false) {//새 파일을 첨부한 경우 
			// 1. 기존 파일 삭제
			ClubDto origin = clubDao.selectOne(clubDto.getClubNo());
			if(origin.getClubProfile() != null) {
				attachmentService.delete(origin.getClubProfile());
			}
			// 2. 새 파일 저장
			int attachmentNo = attachmentService.save(attach);
			clubDto.setClubProfile(attachmentNo);
		}
		else {//새 파일을 첨부하지 않은 경우
			ClubDto origin = clubDao.selectOne(clubDto.getClubNo());
			clubDto.setClubProfile(origin.getClubProfile());
		}
		clubDao.update(clubDto);
	}
}
