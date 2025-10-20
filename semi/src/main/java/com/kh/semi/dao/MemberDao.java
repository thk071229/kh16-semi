package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.MemberDto;
import com.kh.semi.mapper.MemberMapper;

@Repository
public class MemberDao {
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//CRUD 메소드들
	
	//등록(create)
	public void insert(MemberDto memberDto) {
		String sql ="insert into member("
							+ "member_id, member_pw, member_nickname,"
							+ "member_email, member_gender, member_birth,"
							+ "member_point, member_level, member_join"
						+ ") "
						+ "values(?,?, ?, ?, ?, ?, ?, ?, systimestamp);";
		Object[] params = {
				memberDto.getMemberId(), memberDto.getMemberPw(), memberDto.getMemberNickname(), 
				memberDto.getMemberEmail(), memberDto.getMemberGender(), memberDto.getMemberBirth(),
				memberDto.getMemberPoint(), memberDto.getMemberLevel(), memberDto.getMemberJoin()
				};
		jdbcTemplate.update(sql, params);
	}
	
	//조회(read)
	//아이디로 회원 검색
	public MemberDto selectOne(String memberId) {
		String sql = "select * from member where member_id=?";
		Object[] params = {memberId};
		List<MemberDto> list = jdbcTemplate.query(sql,memberMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	//닉네임으로 회원 검색
	public MemberDto selectOneByNickname(String memberNickname) {
		String sql = "select * from member where member_nickname=?";
		Object[] params = {memberNickname};
		List<MemberDto> list = jdbcTemplate.query(sql, memberMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	//전체 회원 목록조회(관리자 제외/관리자 전용)
	public List<MemberDto> selectList() {
		String sql = "select * from member "
				+ "where member_level != '관리자' "
				+ "order by member_id asc";
		return jdbcTemplate.query(sql, memberMapper);
	}
	//회원 검색
	public List<MemberDto> selectList(String column, String keyword) {
		String sql = "select * from member "
							+ "where instr(#1, ?)>0 and member_level != '관리자' "
							+ "order by #1 asc, member_id asc";
		sql.replace("#1", column);
		Object[] params = {keyword};
		return jdbcTemplate.query(sql, memberMapper, params);
	}

	//수정(update)
	//회원 정보 수정(회원전용)
	public boolean updateMember(MemberDto memberDto) {
		String sql = "update member set "
							+ "member_nickname=?, member_email=?, "
							+ "member_gender=?, member_birth=? "
						+ "where member_id=?";
		Object[] params = {
				memberDto.getMemberNickname(), memberDto.getMemberEmail(),
				memberDto.getMemberGender(), memberDto.getMemberBirth(),
				memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, params)>0;
	}
	//회원 정보 수정 (관리자전용)
	public boolean updateMemberByAdmin(MemberDto memberDto) {
		String sql = "update member set "
							+ "member_nickname=?, member_email=?, "
							+ "member_gender=?, member_birth=?, "
							+ "member_point=?, member_level=? "
						+ "where member_id=?";
		Object[] params = {
				memberDto.getMemberNickname(), memberDto.getMemberEmail(),
				memberDto.getMemberGender(), memberDto.getMemberBirth(),
				memberDto.getMemberPoint(), memberDto.getMemberLevel(),
				memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, params)>0;
	}	
	//비밀번호 변경
	public boolean updateMemberPw(String memberId, String memberPw) {
		String sql = "update member set "
							+ "member_pw=? "
						+ "where member_id=?";
		Object[] params = {
				memberPw, memberId
		};
		return jdbcTemplate.update(sql, params)>0;
	}
	public boolean updateMemberPw(MemberDto memberDto) {
		return updateMemberPw(memberDto.getMemberId(), memberDto.getMemberPw());
	}
	
	//삭제(Delete)
	public boolean deleteMember(String memberId) {
		String sql = "delete from member "
						+ "where member_id=?";
		Object[] params = {
				memberId
		};
		return jdbcTemplate.update(sql, params)>0;
	}

}
