package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kh.semi.dto.MemberCategoryDto;
import com.kh.semi.mapper.MemberCategoryListMapper;
import com.kh.semi.mapper.MemberCategoryMapper;
import com.kh.semi.vo.MemberCategoryListVO;


@Repository
public class MemberCategoryDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private MemberCategoryMapper memberCategoryMapper;
	@Autowired
	private MemberCategoryListMapper memberCategoryListMapper;
	
	//등록
	public void insert(MemberCategoryDto memberCategoryDto) {
		String sql = "insert into member_category ("
							+ "member_id, category_no"
						+ ") VALUES (?, ?)";
		Object[] params = {
				memberCategoryDto.getMemberId(), memberCategoryDto.getCategoryNo()
		};
		jdbcTemplate.update(sql, params);
	}
	
	//조회
	//테이블 전체 조회
	public List<MemberCategoryDto> selectList(){
		String sql = "select * from member_category order by member_id asc";
		return jdbcTemplate.query(sql, memberCategoryMapper);
	}
	//회원에게 보여줄 때 사용할 조회 메소드
	public List<MemberCategoryListVO> selectVOList(String memberId){
		String sql = "select * from member_category_list "
							+ "where member_id=? "
						+ "order by category_no asc";
		Object[] params = {memberId};
		
		return jdbcTemplate.query(sql, memberCategoryListMapper, params);
	}
	
	//pk 로 조회
	public MemberCategoryDto selectOne(String memberId, int categoryNo) {
		String sql = "select * from member_category "
						+ "where member_id=? and category_no=?";
		Object[] params = { memberId, categoryNo };
		List<MemberCategoryDto> list = jdbcTemplate.query(sql, memberCategoryMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//id로 선호하는 카테고리 목록 조회
	public List<Integer> selectCategoryById(String memberId) {
		String sql = "select category_no from member_category "
						+ "where member_id=?";
		Object[] params = {memberId};
		return jdbcTemplate.queryForList(sql, Integer.class, params);
	}
	
	//선호하는 카테고리로 선택한 사람이 몇 명 있는지 조회
	public int countByCategory(int categoryNo) {
		String sql = "select count(*) from member_category "
						+ "where category_no=?";
		Object[] params = { categoryNo };
		return jdbcTemplate.queryForObject(sql, int.class, params);
	}
	
	//수정
	@Transactional
	public boolean update(MemberCategoryDto memberCategoryDto, int oldCategoryNo) {
	    // 기존 category_no 삭제 후 새로 등록
	    String deleteSql = "delete from member_category "
	    							+ "where member_id=? and category_no=?";
	    Object[] deleteParams = {
	    		memberCategoryDto.getMemberId(), oldCategoryNo
	    };
	    jdbcTemplate.update(deleteSql, deleteParams);

	    String insertSql = "insert into member_category ("
	    							+ "member_id, category_no"
	    							+ ") values (?, ?)";
	    Object[] insertParams = {
	    		memberCategoryDto.getMemberId(), memberCategoryDto.getCategoryNo()
	    };
	    return jdbcTemplate.update(insertSql, insertParams) > 0;
	}
	
	//삭제
	public boolean delete(String memberId, int categoryNo) {
		String sql = "delete from member_category "
						+ "where member_id=? and category_no=?";
		Object[] params = {
				memberId, categoryNo
		};
		return jdbcTemplate.update(sql, params) > 0;
	}
	public boolean delete(MemberCategoryDto memberCategoryDto) {
		String sql = "delete from member_category "
						+ "where member_id=? and category_no=?";
		Object[] params = {
			memberCategoryDto.getMemberId(), memberCategoryDto.getCategoryNo()
		};
		return jdbcTemplate.update(sql, params) > 0;
	}
}
