package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.ClubDto;
import com.kh.semi.mapper.ClubListMapper;
import com.kh.semi.mapper.ClubMapper;
import com.kh.semi.mapper.MemberClubListMapper;
import com.kh.semi.vo.ClubListVO;
import com.kh.semi.vo.MemberClubListVO;
import com.kh.semi.vo.PageVO;

@Repository
public class ClubDao {


	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ClubMapper clubMapper;
	@Autowired
	private ClubListMapper clubListMapper;
	@Autowired
	private MemberClubListMapper memberClubListMapper;

	//등록
	public int sequence() {
		String sql = "select club_seq.nextval from dual ";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public void insert(ClubDto clubDto) {
		String sql = "insert into club(club_no, club_leader, club_name, club_introduce, club_open, club_region, club_category, club_profile) values(?,?,?,?,?,?,?,?)";
		Object[] params = {clubDto.getClubNo(), clubDto.getClubLeader(), clubDto.getClubName(), 
				clubDto.getClubIntroduce(), clubDto.getClubOpen(),clubDto.getClubRegion(), clubDto.getClubCategory(), clubDto.getClubProfile()};
		jdbcTemplate.update(sql, params);
	}
	//삭제
	public boolean delete(int clubNo) {
		String sql = "delete club where club_no = ?";
		Object[] params = {clubNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	//수정
	public boolean update(ClubDto clubDto) {//
		String sql = "update club set club_name = ?, club_introduce = ?, club_open = ?, club_category = ?, club_profile = ? where club_no = ?";
		Object[] params = {clubDto.getClubName(), clubDto.getClubIntroduce(), clubDto.getClubOpen(),  
				clubDto.getClubCategory(), clubDto.getClubProfile(), clubDto.getClubNo()};
		return jdbcTemplate.update(sql, params) > 0;
	}
	//모임장 위임을 위한 메소드
	public boolean changeClubLeader(int clubNo, String newLeader){
		String sql = "update club set club_leader = ? where club_no = ?";
		Object[] params = {newLeader, clubNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	
	public ClubDto selectOne(int clubNo) {
		String sql = "select * from club where club_no = ?";
		Object[] params = {clubNo};
		List<ClubDto> list = jdbcTemplate.query(sql, clubMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	
	public int count(PageVO pageVO) {
		if(pageVO.isList()) {
			String sql = "select count(*) from club";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
		else {
			String sql ="select count(*) from club "
					+ "where instr(#1, ?) > 0";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] params = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, params);
		}
	}
	
	//지역과 카테고리에 따른 목록 및 검색 조회
	public List<ClubListVO> selectListWithPaging(PageVO pageVO){
		if(pageVO.isList()){//목록
			String sql = "select * from ("
							+ "select rownum rn, TMP.* from("
								+ "select * from club_list "
								+ "order by club_no desc"
								+ ") TMP"
								+ ") where rn between ? and ?";
			Object[] params = {pageVO.getBegin(), pageVO.getEnd()};
			return jdbcTemplate.query(sql, clubListMapper, params);
		}
		else {//검색
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from("
						+ "select * from club_list "
						+ "where instr(#1, ?) > 0 "
						+ "order by club_no desc"
						+ ") TMP"
						+ ") where rn between ? and ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] params = {pageVO.getKeyword(), pageVO.getBegin(), pageVO.getEnd()};
			return jdbcTemplate.query(sql, clubListMapper, params);
		}
	}
	// clubList에서 객체를 뽑아내기 위한 메소드
	public ClubListVO selectOneFromClubList(int clubNo){
		String sql = "select * from club_list where club_no = ?";
		Object[] params = {clubNo};
		List<ClubListVO> list = jdbcTemplate.query(sql, clubListMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	// 회원의 아이디로 가입한 club의 목록을 조회하고 club의 정보를 보여주기 위한 메소드
	public List<MemberClubListVO> selectClubList(String memberId) {
		String sql = "select * from member_club_list where member_id=?";
		Object[] params = {memberId};
		return jdbcTemplate.query(sql, memberClubListMapper, params);
	}
	// 대표사진 수정 메소드
	public boolean updateProfileImgage(int clubNo, int attachmentNo) {
		String sql = "update club set club_profile = ? where club_no = ?";
		Object[] params = {attachmentNo, clubNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	
	
}
