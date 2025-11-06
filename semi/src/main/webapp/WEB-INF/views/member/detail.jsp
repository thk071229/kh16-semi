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
	
	<div class="cell center">
		<img src="${pageContext.request.contextPath}/member/profile?memberId=${memberDto.memberId}" width="200" height="200">
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
				<th>성별</th>
				<td>${memberDto.memberGender}</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>
					<fmt:formatDate value="${memberDto.memberBirth}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
		</table>
	</div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>