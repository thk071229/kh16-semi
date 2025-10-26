package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.kh.semi.dto.MemberRegionDto;
import com.kh.semi.mapper.MemberRegionListMapper;
import com.kh.semi.mapper.MemberRegionMapper;
import com.kh.semi.vo.MemberRegionListVO;

@Repository
public class MemberRegionDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private MemberRegionMapper memberRegionMapper;
	@Autowired
	private MemberRegionListMapper memberRegionListMapper;
	
	//등록
	// 시퀀스 생성
	public int sequence(){
	  String sql = "select region_seq.nextval from dual";
	  return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	public void insert(MemberRegionDto memberRegionDto) {
		String sql = "insert into member_region ("
						+ "member_id, region_no, region_type"
						+ ") values(?, ?, ?)";
		Object[] params = {
				memberRegionDto.getMemberId(), memberRegionDto.getRegionNo(), 
				memberRegionDto.getRegionType()
		};
		jdbcTemplate.update(sql, params);
	}
	
	//조회
	//전체 목록 조회
	public List<MemberRegionDto> selectList() {
		String sql = "select * from member_region";
		return jdbcTemplate.query(sql, memberRegionMapper);
	}
	//회원에게 보여줄 때 사용할 조회 메소드
	public List<MemberRegionListVO> selectVOList(String memberId){
		String sql = "select * from member_region_list "
							+ "where member_id=? "
						+ "order by region_no asc";
		Object[] params = {memberId};
		return jdbcTemplate.query(sql, memberRegionListMapper, params);
	}
	
	//id와 regionType으로 조회
	public MemberRegionDto selectRegion(String memberId, String regionType) {
		String sql = "select * from member_region "
						+ "where member_id=? and region_type=?";
		Object[] params = {
				memberId, regionType
		};
		List<MemberRegionDto>list =  jdbcTemplate.query(sql, memberRegionMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//pk로 조회
	public MemberRegionDto selectOne(String memberId, int regionNo) {
		String sql = "select * from member_region "
						+ "where member_id=? and region_no=?";
		Object[] params = {
				memberId, regionNo
		};
		List<MemberRegionDto>list = jdbcTemplate.query(sql, memberRegionMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//id로 선호하는 지역 목록 조회
	public List<Integer> selectRegionById(String memberId) {
		String sql = "select region_no from member_region "
						+ "where member_id=?";
		Object[] params = {memberId};
		return jdbcTemplate.queryForList(sql, Integer.class, params);
	}
	
	
	//수정
	@Transactional
	public boolean update(MemberRegionDto memberRegionDto, int oldRegionNo) {
	    // 기존 region_no 삭제 후 새로 등록
	    String deleteSql = "delete from member_region "
	    							+ "where member_id=? and region_no=?";
	    Object[] deleteParams = {
	    		memberRegionDto.getMemberId(), oldRegionNo
	    };
	    jdbcTemplate.update(deleteSql, deleteParams);

	    String insertSql = "insert into member_region ("
	    							+ "member_id, region_no, region_type"
	    							+ ") values (?, ?, ?)";
	    Object[] insertParams = {
	    		memberRegionDto.getMemberId(), 
	    		memberRegionDto.getRegionNo(),
	    		memberRegionDto.getRegionType()
	    };
	    return jdbcTemplate.update(insertSql, insertParams) > 0;
	}
	
	//삭제
		public boolean delete(String memberId, int regionNo) {
			String sql = "delete from member_region "
							+ "where member_id=? and region_no=?";
			Object[] params = {
					memberId, regionNo
			};
			return jdbcTemplate.update(sql, params) > 0;
		}
		public boolean delete(MemberRegionDto memberRegionDto) {
			String sql = "delete from member_region "
							+ "where member_id=? and region_no=?";
			Object[] params = {
				memberRegionDto.getMemberId(), memberRegionDto.getRegionNo()
			};
			return jdbcTemplate.update(sql, params) > 0;
		}
}
