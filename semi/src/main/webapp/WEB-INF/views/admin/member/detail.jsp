<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

.profile-info {
  flex: 1;
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 20px;
}
.profile-info table {
  width: 100%;
  border-collapse: collapse;
}
.profile-info th, .profile-info td {
  border: 1px solid #dcdcdc;
  padding: 8px;
  text-align: center;
}
.profile-info th {
  background: var(--muted);
  color: var(--ink);
  font-weight: 600;
}

.table-wrapper {
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 16px;
  margin-top: 15px;
}
.table-wrapper table {
  width: 100%;
  border-collapse: collapse;
}
.table-wrapper th, .table-wrapper td {
  border: 1px solid #dcdcdc;
  padding: 10px;
  text-align: center;
}
.table-wrapper th {
  background: var(--muted);
  color: var(--ink);
}
.table-wrapper tr:hover {
  background: rgba(127,200,169,0.1);
}
</style>

<div class="container">

	<div class="cell center">
		<h1 style="color: var(--subtle);">${memberDto.memberId}님의 정보</h1>
	</div>
	<div class="cell center mt-50">
		<img src="/member/profile?memberId=${memberDto.memberId}" width="200" height="200">
	</div>
	<div class="profile-info mt-50">
		<table>
			<tr>
				<th>닉네임</th>
				<td>${memberDto.memberNickname}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${memberDto.memberEmail}</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${memberDto.memberBirth}</td>
			</tr>
			<tr>
				<th>등급</th>
				<td>${memberDto.memberLevel}</td>
			</tr>
			<tr>
				<th>포인트</th>
				<td>${memberDto.memberPoint}포인트</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td>
					<fmt:formatDate value="${memberDto.memberJoin}" pattern="y년 M월 d일 H시 m분 s초"/>
				</td>
			</tr>
		</table>
	</div>
	<!-- 가입한 소모임 목록 -->
	<div class="cell center mt-50">
		<h2 style="color: var(--subtle);">${memberDto.memberId}님의 가입 모임</h2>
	</div>
	<div class="profile-info">
		<table>
			<tr>
				<th>소모임 이름</th>
				<th>활동 지역</th>
				<th>카테고리</th>
			</tr>
			<c:forEach var="memberClubListVO" items="${clubList}">
				<tr>
					<td>
						${memberClubListVO.clubName}
						<%-- 
						<a href="/club/detail?clubNo=${memberClubListVO.clubNo}">
							${memberClubListVO.clubName}
						</a>
						--%>
					</td>
					<td>${memberClubListVO.regionName}</td>
					<td>${memberClubListVO.categoryName}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="cell center mt-50">
		<h2><a class="member-link" href="list">검색화면으로 돌아가기</a></h2>
	</div>
	<div class="cell center">
		<h2><a class="member-link" href="edit?memberId=${memberDto.memberId}">회원 정보 변경하기</a></h2>
	</div>
	<div class="cell center">
		<h2><a class="link" href="drop?memberId=${memberDto.memberId}">회원 강제 탈퇴하기</a></h2>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>