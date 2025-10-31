package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.mapper.ClubCountMapper;
import com.kh.semi.mapper.MemberActiveMapper;
import com.kh.semi.vo.ClubCountVO;
import com.kh.semi.vo.EventListVO;
import com.kh.semi.vo.MemberActiveVO;
import com.kh.semi.vo.PageVO;

@Repository
public class CountDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ClubCountMapper clubCountMapper;

	@Autowired
	private MemberActiveMapper memberActiveMapper;
	
//	// 홈화면 조회 : 정모 많이한 클럽
//	public List<ClubCountVO> selectListWithEventCount(){
//		String sql = "select * from club_count where event_count > 0 "
//				+"order by event_count desc";
//		return jdbcTemplate.query(sql, clubCountMapper);
//	}
//	// 홈화면 조회 : 게시글 많이 쓴 클럽
//	public List<ClubCountVO> selectListWithBoardCount(){
//		String sql = "select * from club_count where board_count > 0 "
//				+"order by board_count desc";
//		return jdbcTemplate.query(sql, clubCountMapper);
//	}
//	
//	// 홈화면 조회 : 좋아요 많이 받은 클럽
//	public List<ClubCountVO> selectListWithLikeCount(){
//		String sql = "select * from club_count where club_like > 0 "
//						+"order by club_like desc";
//		return jdbcTemplate.query(sql, clubCountMapper);
//	}
	
	//pagination 적용 :: 홈화면 조회 : 좋아요 많이 받은 클럽
	public List<ClubCountVO> selectLikeListWithPaging(PageVO pageVO){
		System.out.println("checkRegion() 결과 = [" + pageVO.checkRegion() + "]");
		if(pageVO.checkRegion().equals("empty")) { // null null을 받았을때 → 목록 + 페이징
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from club_count where club_like > 0 "
					+ "order by club_like desc"
					+ ")TMP "
					+ ")where rn between ? and ?";
			Object[] params = {pageVO.getBegin(), pageVO.getEnd()};
			return jdbcTemplate.query(sql, clubCountMapper, params);
		} else if(pageVO.checkRegion().equals("Depth1")) { // regionDepth1만 설정되어있을때
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from club_count "
					+ "where club_like > 0 and region_depth1 = ? "
					+ "order by club_like desc"
					+ ")TMP "
					+ ")where rn between ? and ?";
			Object[] params = { pageVO.getRegionDepth1(),
										pageVO.getBegin(), pageVO.getEnd() };
			return jdbcTemplate.query(sql, clubCountMapper, params);
		}
		else { // regionDepth1, regionDepth2 둘 다 설정되어있을때
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from club_count "
					+ "where club_like > 0 and region_depth1 = ? and region_depth2 = ? "
					+ "order by club_like desc"
					+ ")TMP "
					+ ")where rn between ? and ?";
			Object[] params = { pageVO.getRegionDepth1(), pageVO.getRegionDepth2(),
										pageVO.getBegin(), pageVO.getEnd() };
			return jdbcTemplate.query(sql, clubCountMapper, params);
		}
	}
	
	//pagination 적용 :: 홈화면 조회 : 정모 많이한 클럽
	public List<ClubCountVO> selectEventListWithPaging(PageVO pageVO){
		if(pageVO.checkRegion().equals("empty")) { // null null을 받았을때 → 목록 + 페이징
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from club_count where event_count > 0 "
					+ "order by event_count desc"
					+ ")TMP "
					+ ")where rn between ? and ?";
			Object[] params = {pageVO.getBegin(), pageVO.getEnd()};
			return jdbcTemplate.query(sql, clubCountMapper, params);
		} else if(pageVO.checkRegion().equals("Depth1")) { // regionDepth1만 설정되어있을때
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from club_count "
					+ "where event_count > 0 and region_depth1 = ? "
					+ "order by event_count desc"
					+ ")TMP "
					+ ")where rn between ? and ?";
			Object[] params = { pageVO.getRegionDepth1(),
										pageVO.getBegin(), pageVO.getEnd() };
			return jdbcTemplate.query(sql, clubCountMapper, params);
		}
		else { // regionDepth1, regionDepth2 둘 다 설정되어있을때
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from club_count "
					+ "where event_count > 0 and region_depth1 = ? and region_depth2 = ? "
					+ "order by event_count desc"
					+ ")TMP "
					+ ")where rn between ? and ?";
			Object[] params = { pageVO.getRegionDepth1(), pageVO.getRegionDepth2(),
										pageVO.getBegin(), pageVO.getEnd() };
			return jdbcTemplate.query(sql, clubCountMapper, params);
		}
	}
	
	//pagination 적용 :: 홈화면 조회 : 게시글 많이 쓴 클럽
	public List<ClubCountVO> selectBoardListWithPaging(PageVO pageVO){
		if(pageVO.checkRegion().equals("empty")) { // null null을 받았을때 → 목록 + 페이징
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from club_count where board_count > 0 "
					+ "order by board_count desc"
					+ ")TMP "
					+ ")where rn between ? and ?";
			Object[] params = {pageVO.getBegin(), pageVO.getEnd()};
			return jdbcTemplate.query(sql, clubCountMapper, params);
		} else if(pageVO.checkRegion().equals("Depth1")) { // regionDepth1만 설정되어있을때
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from club_count "
					+ "where board_count > 0 and region_depth1 = ? "
					+ "order by board_count desc"
					+ ")TMP "
					+ ")where rn between ? and ?";
			Object[] params = { pageVO.getRegionDepth1(),
										pageVO.getBegin(), pageVO.getEnd() };
			return jdbcTemplate.query(sql, clubCountMapper, params);
		}
		else { // regionDepth1, regionDepth2 둘 다 설정되어있을때
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from club_count "
					+ "where board_count > 0 and region_depth1 = ? and region_depth2 = ? "
					+ "order by board_count desc"
					+ ")TMP "
					+ ")where rn between ? and ?";
			Object[] params = { pageVO.getRegionDepth1(), pageVO.getRegionDepth2(),
										pageVO.getBegin(), pageVO.getEnd() };
			return jdbcTemplate.query(sql, clubCountMapper, params);
		}
	}
	
	
	//dataCount 설정 위한 count
	public int eventListCount(PageVO pageVO) {
		String sql = "select count(*) from club_count where event_count > 0";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public int boardListCount(PageVO pageVO) {
		String sql = "select count(*) from club_count where board_count > 0";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public int clubLikeListCount(PageVO pageVO) {
		String sql = "select count(*) from club_count where club_like > 0";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	// 포인트 관련-------------
	// 포인트 확인
	public boolean updateMemberPoint(MemberActiveVO memberActiveVO) {
		String sql = "update member "
				+ "set member_point=? "
				+ "where member_id=? ";
		Object[] params = {memberActiveVO.memberPoint(), memberActiveVO.getMemberId()};
		return jdbcTemplate.update(sql, params)>0;
	}
	// 회원 활동 조회 <- update할 VO를 memberID로 찾기
	public MemberActiveVO selectOneWithActive(String memberId) {
		String sql = "select * from member_active_count where member_id=?";
		Object[] params = {memberId};
		return jdbcTemplate.queryForObject(sql, memberActiveMapper, params);
		
	}
}