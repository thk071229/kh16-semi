package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.ClubMemberDto;
import com.kh.semi.mapper.ClubMemberListMapper;
import com.kh.semi.mapper.ClubMemberMapper;
import com.kh.semi.vo.ClubMemberListVO;
import com.kh.semi.vo.PageVO;

@Repository
public class ClubMemberDao {

    private final ClubMemberListMapper clubMemberListMapper;

	@Autowired
	private ClubMemberMapper clubMemberMapper;
	@Autowired
	private JdbcTemplate jdbcTemplate;

    ClubMemberDao(ClubMemberListMapper clubMemberListMapper) {
        this.clubMemberListMapper = clubMemberListMapper;
    }
	
	public void insert(ClubMemberDto clubMemberDto) {
		String sql = "insert into club_member(club_no, club_member, club_member_role) "
				+ "values(?,?,?)";
		Object[] params = {clubMemberDto.getClubNo(), clubMemberDto.getClubMember(), clubMemberDto.getClubMemberRole()};
		jdbcTemplate.update(sql, params);
	}
	// 클럽 회원 등급 변경
	public boolean updateRole(ClubMemberDto clubMemberDto){
	  String sql = "update club_member set club_member_role = ? where club_no = ? and club_member = ?";
	  Object[] params = {clubMemberDto.getClubMemberRole(), clubMemberDto.getClubNo(), clubMemberDto.getClubMember()};
	  return jdbcTemplate.update(sql, params) > 0;
	}
	// 조회
	public ClubMemberDto selectOne(int clubNo) {
		String sql = "select * from club_member where club_no = ?";
		Object[] params = {clubNo};
		List<ClubMemberDto> list = jdbcTemplate.query(sql, clubMemberMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	// 특정 모임(clubNo)에 특정 회원(memberId)이 있는지 확인
	public ClubMemberDto selectByClubMember(int clubNo, String memberId) {
	    String sql = "select * from club_member where club_no = ? AND club_member = ?";
	    Object[] params = {clubNo, memberId}; 
	    
	    List<ClubMemberDto> list = jdbcTemplate.query(sql, clubMemberMapper, params);
	    return list.isEmpty() ? null : list.get(0);
	}
	//소모임에 가입되어 있는 전체 회원 목록 조회 메소드
	public List<ClubMemberListVO> selectListWithNickname(int clubNo){
		String sql = "select * from club_member_list where club_no = ? order by club_member_role asc";
		Object[] params = {clubNo};
		return jdbcTemplate.query(sql, clubMemberListMapper, params);
	}
	
	//페이징을 이용한 전체 회원 목록 조회 메소드
	public List<ClubMemberListVO> selectMemberListWithPaging(PageVO pageVO, int clubNo){
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from club_member_list where club_no = ? "
				+ "order by club_member_role asc"
				+ ")TMP "
				+ ")where rn between ? and ?";
		Object[] params = {clubNo, pageVO.getBegin(), pageVO.getEnd()};
		return jdbcTemplate.query(sql, clubMemberListMapper, params);
	}
	//전체 회원 수
	
	// 모임 탈퇴 메소드
	public boolean delete(int clubNo, String memberId) {
		String sql ="delete from club_member where club_no = ? and club_member = ?";
		Object[] params = {clubNo, memberId};
		return jdbcTemplate.update(sql, params) > 0;
	}
}
