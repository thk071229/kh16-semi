package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.CategoryDto;
import com.kh.semi.mapper.CategoryMapper;
import com.kh.semi.vo.PageVO;

@Repository
public class CategoryDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private CategoryMapper categoryMapper;
	
	//관리자 기능을 위한 기능
	//등록
	public int sequence() {
		String sql = "select category_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public void insert(CategoryDto categoryDto) {
		String sql = "insert into category "
							+ "(category_no, category_name) "
							+ "values(?, ?)";
		Object[] params = {
				categoryDto.getCategoryNo(), categoryDto.getCategoryName()
		};
		jdbcTemplate.update(sql, params);
	}
	
	//조회
	// 회원가입, 소모임개설 시 category 설정을 위한 조회 메소드(전체 조회)
	public List<CategoryDto> selectList() {
		String sql = "select * from category "
						+ "order by category_no asc";
		return jdbcTemplate.query(sql, categoryMapper);
	}
	
	// 카테고리 조회 & 검색(페이지 형태)
	public List<CategoryDto> selectListWithPaging(PageVO pageVO){
		//목록이라면
		if(pageVO.isList()) { 
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from("
								+ "select * from category order by category_no asc"
							+ ") TMP where rn between ? and ?";
			Object[] params = {
					pageVO.getBegin(), pageVO.getEnd()
			};
			
			return jdbcTemplate.query(sql, categoryMapper, params);
		}
		//검색이라면
		else {
			String sql = "select * from ("
								+ "select rownum rm, TMP.* from("
									+ "select * from category "
									+ "where instr(#1, ?)>0 "
									+ "order by category_no asc"
								+ ") TMP) where rm between ? and ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] params = {
					pageVO.getKeyword(), 
					pageVO.getBegin(), 
					pageVO.getEnd()
			};
			
			return jdbcTemplate.query(sql, categoryMapper, params);
		}
	}
	
	//수정
	public boolean update(CategoryDto categoryDto) {
		String sql = "update category set category_name=? "
						+ "where category_no=?";
		Object[] params = {
				categoryDto.getCategoryName(), categoryDto.getCategoryNo()
		};
		return jdbcTemplate.update(sql, params)>0;
	}
	
	//삭제
	public boolean delete(int categoryNo) {
		String sql = "delete from category where category_no=?";
		Object[] params = {categoryNo};
		return jdbcTemplate.update(sql, params)>0;
	}
	
}
