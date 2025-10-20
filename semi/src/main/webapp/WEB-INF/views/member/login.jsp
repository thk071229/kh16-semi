<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="login" method="post" autocomplete="off">
<div>

	<div>
		<h1>로그인</h1>
	</div>
	<div>
		<input type="text" name="memberId" placeholder="ID" required>
	</div>
	<div>
		<input type="password" name="memberPw" placeholder="Password" required>
	</div>
	<div>
		<button type="submit">로그인</button>
	</div>
	
	<!-- 아이디 비밀번호 찾기 페이지 -->
	<div>
		<a href="#">아이디를 잊으셨나요?</a>
	</div>
	<div>
		<a href="#">비밀번호 찾기</a>
	</div>
	
	<!--  로그인 실패 오류 메시지 -->
	<%-- <c:if test="${param.error != null}">
		<div>
			<h2>입력하신 정보가 일치하지 않습니다</h2>
		</div>
	</c:if> --%>
</div>
</form>    