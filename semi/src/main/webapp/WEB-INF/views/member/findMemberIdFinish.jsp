<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<div class="cell center">
		<h1 style="color: var(--subtle);">아이디가 존재합니다</h1>
	</div>
	<div class="cell center">
		<div style="font-size:24px;color:var(--subtle)">
			입력하신 이메일로 아이디가 전송되었습니다
		</div>
	</div>
	<div class="cell center mt-50">
		<a href="findMemberPw" class="link">비밀번호 찾기</a>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>