<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
    
<form action="joinFinish" method="post">
<input type="hidden" name="memberId" value="${memberId}">
<div class="container">

	<div class="cell">
		<h1>회원가입 완료</h1>
		<span>찾아주셔서 감사합니다</span>
	</div>
	<div class="cell">
		<h2>관심 지역과 카테고리 선택</h2>
	</div>
	<!-- 관심지역 -->
	<div class="cell">
		<label>관심 지역</label><br>
		<!-- api 구현 예정 -->
	</div>
	<div class="cell">
		<label>관심 카테고리:</label>
    	<select name="categoryNo">
        	<c:forEach items="${categoryList}" var="categoryDto" >
            	<option value="${categoryDto.categoryNo}">${categoryDto.categoryName}</option>
        	</c:forEach>
    	</select>
	</div>
	<div class="cell">
		<button type="submit">저장</button>
	</div>
</div>
</form>

