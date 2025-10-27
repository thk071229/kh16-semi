<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="firstLogin" method="post" autocomplete="off">
<div class="container w-300">

	<div class="cell center">
     	<h2 style="color: var(--subtle);">로그인</h2>
	</div>
	
	<div class="cell center">
		<input type="text" name="memberId" placeholder="ID" class="search-input w-100" required>
	</div >
	<div class="cell center">
		<input type="password" name="memberPw" placeholder="Password" class="search-input w-100" required>
	</div>
	<div class="cell center mb-50">
		<button class="btn btn-primary w-100" type="submit">로그인</button>
	</div>
	
	<!--  로그인 실패 오류 메시지 -->
	<c:if test="${param.error != null}">
		<div class="cell center">
			<h3 style="color:#e17055;">입력하신 정보가 일치하지 않습니다</h3>
		</div>
	</c:if>
	
	<!-- 아이디 비밀번호 찾기 페이지 -->
	<div class="cell center mt-50">
		<a href="findMemberId" class="link">아이디를 잊으셨나요?</a>
	</div>
	<div class="cell center">
		<a href="findMemberPw" class="link">비밀번호 찾기</a>
	</div>
	
	
</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>