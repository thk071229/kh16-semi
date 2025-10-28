package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ClubLikeDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//좋아요 등록
	public void insert(String memberId, int clubNo) {
		String sql = "insert into club_like(member_id, club_no) values(?, ?)";
		Object[] params = {memberId, clubNo};
		jdbcTemplate.update(sql, params);
	}
	
	//검사
	public boolean check(String memberId, int clubNo) {
		//memberId가 없으면 검사x
		if(memberId == null) return false;
		//count 조회를 해서 좋아요 존재 유무 판단
		String sql = "select count(*) from club_like where member_id = ? and club_no = ?";
		Object[] params = {memberId,clubNo};
		int count = jdbcTemplate.queryForObject(sql, int.class, params);
		//count가 1 이상이면 좋아요 존재(true), 아니면 false
		return count > 0;
	}
	//좋아요(찜) 취소
	public boolean delete(String memberId, int clubNo) {
		String sql = "delete from club_like "
				+ "where member_id = ? and club_no = ?";
		Object[] params = {memberId, clubNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	//소모임이 받은 좋아요 개수
		public int countByClubNo(int clubNo) {
			String sql = "select count(*) from club_like "
					+ "where club_no = ?";
			Object[] params = {clubNo};
			return jdbcTemplate.queryForObject(sql, int.class, params);
		}
		public int countByMemberId(String memberId) {
			String sql = "select count(*) from club_like where member_id = ?";
			Object[] params = {memberId};
			return jdbcTemplate.queryForObject(sql, int.class, params);
		}
	//특정 멤버가 좋아요(찜) 한 소모임 조회
		public List<Integer> selectLikeListByMemberId(String memberId){
			String sql = "select club_no from club_like where member_id = ?";
			Object[] params = {memberId};
			return jdbcTemplate.queryForList(sql, Integer.class, params);
		}
		
	}
