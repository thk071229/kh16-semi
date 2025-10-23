package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.MemberDto;
import com.kh.semi.mapper.MemberMapper;
import com.kh.semi.vo.PageVO;

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
						+ "values(?,?, ?, ?, ?, ?, ?, ?, systimestamp)";
		Object[] params = {
				memberDto.getMemberId(), memberDto.getMemberPw(), memberDto.getMemberNickname(), 
				memberDto.getMemberEmail(), memberDto.getMemberGender(), memberDto.getMemberBirth(),
				memberDto.getMemberPoint(), memberDto.getMemberLevel()
				};
		jdbcTemplate.update(sql, params);
	}
	
	//조회(read)
	//아이디로 회원 조회
	public MemberDto selectOne(String memberId) {
		String sql = "select * from member where member_id=?";
		Object[] params = {memberId};
		List<MemberDto> list = jdbcTemplate.query(sql,memberMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	//닉네임으로 회원 조회
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
	//회원 검색(관리자)
	public int count(PageVO pageVO) {
		if(pageVO.isList()) {
			return 0;//목록은 데이터가 없다! (회원 검색의 특징)
			//String sql = "select count(*) from member";
			//return jdbcTemplate.queryForObject(sql, int.class);
		}
		else {
			String sql ="select count(*) from member "
					+ "where instr(#1, ?) > 0 and member_level != '관리자'";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] params = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, params);
		}
	}
	
	public List<MemberDto> selectListWithPaging(PageVO pageVO) {
		if(pageVO.isList()) {//목록이라면
			return null;//보안상의 이유로 목록은 제공 x
		}
		else {//검색이라면
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select * from member "
									+ "where instr(#1, ?) > 0 and member_level != '관리자' "
									+ "order by #1 asc, member_id asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] params = {
					pageVO.getKeyword(), pageVO.getBegin(), pageVO.getEnd()
			};//동적할당
			return jdbcTemplate.query(sql, memberMapper, params);
		}
	}
	//public List<MemberDto> selectList(String column, String keyword) {
	//	String sql = "select * from member "
	//						+ "where instr(#1, ?)>0 and member_level != '관리자' "
	//						+ "order by #1 asc, member_id asc";
	//	sql.replace("#1", column);
	//	Object[] params = {keyword};
	//	return jdbcTemplate.query(sql, memberMapper, params);
	//}

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
	//비밀번호 변경(회원 전용)
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
	public boolean delete(String memberId) {
		String sql = "delete from member "
						+ "where member_id=?";
		Object[] params = {
				memberId
		};
		return jdbcTemplate.update(sql, params)>0;
	}
	
	//회원 프로필 기능
	public void connect(String memberId, int attachmentNo) {
		String sql = "insert into member_profile(member_id, attachment_no) values(?, ?)";
		Object[] params = {memberId, attachmentNo};
		jdbcTemplate.update(sql, params);
	}
	public int findAttachment(String memberId) {
		String sql = "select attachment_no from member_profile where member_id = ? ";
		Object[] params = {memberId};
		return jdbcTemplate.queryForObject(sql, int.class, params);
	}
}
