<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>정모 추가</h1>
<form action="/add" method="post" autocomplete="off">
	
	<input type="password" name="eventClub" value="${club_no}" readonly>
	
	<div>
		<input type="text" name="eventTitle">
	</div>
	<div>
		<input type="text" name="eventContent">
	</div>
	<div>
		<input type="text" name="eventRegionX">
	</div>
	<div>
		<input type="text" name="eventRegionY">
	</div>
	<div>
		<button type="button">등록</button>
	</div>
</form>