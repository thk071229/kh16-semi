<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<form action="edit" method="post">
	<div>
		
		<div>
			<h1 style="color: var(--subtle);">회원 정보 수정</h1>
		</div>
		<!-- 닉네임 -->
		<div>
			<input type="text" name="memberNickname" value="${memberDto.memberNickname}" required>
		</div>
		<!-- 이메일 -->
		<div>
			<input type="text" inputmode="text" name="memberEmail" value="${memberDto.memberEmail}" required>
		</div>
		<!-- 성별 -->
		<div>
			<input type="text" name="memberGender" value="${memberDto.memberGender}">
		</div>
		<!-- 생년월일 -->
		<div>
			<input type="date" name="memberBirth" value="${memberDto.memberBirth}"> 
		</div>
		<div>
			<span>
				비밀번호를 입력해주세요
			</span>
			<br>
			<input type="password" name="memberPw" placeholder="password" required>
		</div>
		<div>
			<button type="submit">
				정보 변경
			</button>
		</div>
		
		<c:if test="${param.error != null}">
			<div class="cell center">
				<h3 style="color: #e17055;">비밀번호가 일치하지 않습니다</h3>
			</div>
		</c:if>
		
	</div>
</form>
