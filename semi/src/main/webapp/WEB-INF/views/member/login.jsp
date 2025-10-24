<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="login" method="post" autocomplete="off">
<div class=container>

	<div class="title center">
		로그인
	</div>
	
	<div class="cell w-100 center">
		<input type="text" name="memberId" placeholder="ID" class="input w-30" required>
	</div >
	<div class="cell w-100 center">
		<input type="password" name="memberPw" placeholder="Password" class="input w-30" required>
	</div>
	<div class="cell w-100 center mb-50">
		<button class="btn btn-primary w-30" type="submit">로그인</button>
	</div>
	
	<!-- 아이디 비밀번호 찾기 페이지 -->
	<div class="cell center">
		<a href="#" class="btn btn-common">아이디를 잊으셨나요?</a>
	</div>
	<div class="cell center">
		<a href="#" class="btn btn-common">비밀번호 찾기</a>
	</div>
	
	<!--  로그인 실패 오류 메시지 -->
	<c:if test="${param.error != null}">
		<div>
			<h2>입력하신 정보가 일치하지 않습니다</h2>
		</div>
	</c:if>
</div>
</form>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>