<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form autocomplete="off" action="add" method="post">
<div class="container">
	
	<div class="cell">
		<h1>카테고리 추가</h1>
	</div>
	<div class="cell">
		<label>카테고리 명 : </label>
		<input type="text" name="categoryName" required>
	</div>
	<div class="cell">
		<button type="submit">추가하기</button>
	</div>
</div>
</form>