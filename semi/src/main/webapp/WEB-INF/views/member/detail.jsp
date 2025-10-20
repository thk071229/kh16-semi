<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>

	<div>
		<h1>${memberDto.memberId}님의 정보</h1>
	</div>
	
	<div>
	<!-- 프로필 이미지 -->
	</div>
	
	<div>
		<table border="1" width="500">
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