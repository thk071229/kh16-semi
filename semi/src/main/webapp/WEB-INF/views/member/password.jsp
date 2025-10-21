<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form action="password" method="post">
<div>
	
		<div>
			<h1>비밀번호 변경</h1>
		</div>
		<!-- 기존 비밀번호 입력 -->
		<div>
			<label>기존 비밀번호</label><br>
			<input type="password" name="currentPw" placeholder="기존 비밀번호" required>
		</div>
		<!-- 신규 비밀번호 입력 -->
		<div>
			<label>신규 비밀번호</label><br>
			<input type="password" name="changePw" placeholder="신규 비밀번호" required>
		</div>
		<div>
			<button>변경하기</button>
		</div>
		
<%-- 		<c:if test="${param.error != null}">
			<div>
				<h3>비밀번호가 일치하지 않습니다</h3>
			</div>
		</c:if> --%>
	
</div>
</form>