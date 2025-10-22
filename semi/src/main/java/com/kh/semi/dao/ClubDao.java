package com.kh.semi.dao;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.ClubDto;
import com.kh.semi.mapper.ClubListMapper;
import com.kh.semi.mapper.ClubMapper;
import com.kh.semi.vo.ClubListVO;
import com.kh.semi.vo.PageVO;

@Repository
public class ClubDao {


	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ClubMapper clubMapper;
	@Autowired
	private ClubListMapper clubListMapper;

	//등록
	public int sequence() {
		String sql = "select club_seq.nextval from dual ";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public void insert(ClubDto clubDto) {
		String sql = "insert into club(club_no, club_leader, club_name, club_introduce, club_open, club_region, club_category) values(?,?,?,?,?,?,?)";
		Object[] params = {clubDto.getClubNo(), clubDto.getClubLeader(), clubDto.getClubName(), 
				clubDto.getClubIntroduce(), clubDto.getClubOpen(),clubDto.getClubRegion(), clubDto.getClubCategory()};
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
		String sql = "update club set club_name = ?, club_introduce = ?, club_open = ? where club_no = ?";
		Object[] params = {clubDto.getClubName(), clubDto.getClubIntroduce(), clubDto.getClubOpen(), clubDto.getClubNo()};
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
	//지역과 카테고리에 따른 목록 및 검색 조회
	public List<ClubListVO> selectList(PageVO pageVO){
		if(pageVO.isList()){//목록
			String sql = "select * from ("
							+ "select rownum rn, TMP.* from("
								+ "select * from club_list"
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
	
	
	
	
	
}
