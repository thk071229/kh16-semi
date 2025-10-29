package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.ClubDto;
import com.kh.semi.mapper.ClubCountMapper;
import com.kh.semi.mapper.ClubListMapper;
import com.kh.semi.mapper.ClubMapper;
import com.kh.semi.mapper.MemberClubListMapper;
import com.kh.semi.vo.ClubCountVO;
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
	@Autowired
	private ClubCountMapper clubCountMapper;

	//등록
	public int sequence() {
		String sql = "select club_seq.nextval from dual ";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public void insert(ClubDto clubDto) {
		String sql = "insert into club(club_no, club_leader, club_name, club_introduce, "
				+ "club_open, club_region, club_category, club_profile,club_like) values(?,?,?,?,?,?,?,?,?)";
		Object[] params = {clubDto.getClubNo(), clubDto.getClubLeader(), clubDto.getClubName(), 
				clubDto.getClubIntroduce(), clubDto.getClubOpen(),clubDto.getClubRegion(), 
				clubDto.getClubCategory(), clubDto.getClubProfile(), clubDto.getClubLike()};
		jdbcTemplate.update(sql, params);
	}
	//삭제
	public boolean delete(int clubNo) {
		String sql = "delete club where club_no = ?";
		Object[] params = {clubNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	// 소모임 수정
	public boolean update(ClubDto clubDto) {//
		String sql = "update club set club_name = ?, club_introduce = ?, club_open = ?, club_category = ?, club_profile = ? where club_no = ?";
		Object[] params = {clubDto.getClubName(), clubDto.getClubIntroduce(), clubDto.getClubOpen(),  
				clubDto.getClubCategory(), clubDto.getClubProfile(), clubDto.getClubNo()};
		return jdbcTemplate.update(sql, params) > 0;
	}
	// 소모임 좋아요 갯수 수정
	public boolean updateClubLike(int clubNo) {
		String sql = "update club "
				+ "set club_like = "
				+ "(select count(*) "
				+ "from club_like where club_no =?) "
				+ "where club_no = ?";
		Object[] params = {clubNo, clubNo};
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
	public boolean updateProfileImage(int clubNo, int attachmentNo) {
		String sql = "update club set club_profile = ? where club_no = ?";
		Object[] params = {attachmentNo, clubNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	
	public List<ClubListVO> selectClubListOrderByLikesWithPaging(PageVO pageVO){
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from("
					+ "select * from club_list "
					+ "order by club_like desc, club_no asc"
					+ ") TMP"
					+ ") where rn between ? and ?";
		Object[] params = {pageVO.getBegin(), pageVO.getEnd()};
		return jdbcTemplate.query(sql, clubListMapper, params);
	}
	//상위 N(N=limit)개 추천 소모임 목록
	public List<ClubListVO> selectClubListOrderByLikes(int limit){
		String sql = "select * from ("
				+ "select rownum rn,  TMP.* from("
					+ "select * from club_list "
					+ "order by club_like desc, club_no asc"
					+ ") TMP "
					+ ") where rn <= ?";
		Object[] params = {limit};
		return jdbcTemplate.query(sql, clubListMapper, params);
	}
	//추천 소모임의 수를 카운트
	public int countByClubLike(PageVO pageVO) {//club_like가 1이상인 소모임 갯수 카운트
		String sql = "select count(*) from club_list where club_like >=1";
		return jdbcTemplate.queryForObject(sql, int.class);
	 }
	
	//좋아요 한 게시글 목록 페이징
	public List<ClubListVO> selectListLikeWithPaging(PageVO pageVO, String memberId){
		if(memberId == null) return List.of();//선택사항(적으면 코드는 길어지지만 메소드가 안전해짐)
		String sql = "SELECT * FROM ("
		            + "SELECT rownum rn, TMP.* FROM ("
		            	+ "SELECT L.* "
		            	+ "FROM club_list L "
		            	+ "INNER JOIN club_like B ON L.club_no = B.club_no "
		            	+ "WHERE B.member_id = ? "
		            	+ "ORDER BY L.club_no DESC"
		            + ") TMP "
		            + ") WHERE rn BETWEEN ? AND ?";
		Object[] params = {memberId, pageVO.getBegin(), pageVO.getEnd()};
		return jdbcTemplate.query(sql, clubListMapper, params);
	}
	
	//category 별 클럽 목록
	public List<ClubCountVO> selectListByCategoryWithPaging(PageVO pageVO, int categoryNo) {
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from club_count where club_category = ? "
				+ "order by club_no desc"
				+ ")TMP "
				+ ")where rn between ? and ?";
		Object[] params = {categoryNo, pageVO.getBegin(), pageVO.getEnd()};
		return jdbcTemplate.query(sql, clubCountMapper, params);
	}
	
	public int clubCategoryCount(int categoryNo) {
		String sql = "select count(*) from club_count where club_category =?";
		Object[] params = {categoryNo};
		return jdbcTemplate.queryForObject(sql, int.class, params);
	}
	
	//search 결과 클럽 목록
	public List<ClubCountVO> selectListByResultWithPaging(PageVO pageVO, String keyword) {
		String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from club_count "
					+ "where "
						+ "instr(club_name, ?)>0 "
						+ "or instr(region_name, ?)>0 "
						+ "or instr(category_name, ?)>0 "
						+ "order by club_no desc"
					+ ")TMP "
				+ ")where rn between ? and ?";
		Object[] params = {
				keyword, keyword, keyword,
				pageVO.getBegin(), pageVO.getEnd()
			};
		return jdbcTemplate.query(sql, clubCountMapper, params);
	}
	public int searchResultCount(String keyword) {
		String sql = "select count(*) from club_count "
						+ "where "
							+ "instr(club_name, ?)>0 "
							+ "or instr(region_name, ?)>0 "
							+ "or instr(category_name, ?)>0 "
						+ "order by club_no desc";
		Object[] params = {keyword, keyword, keyword};
		return jdbcTemplate.queryForObject(sql, int.class, params);
	}
	
}