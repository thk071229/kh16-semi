<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	

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
		<input type="date" name="eventDate" >
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

    <div class="cell">
	    <!-- 
	    <a href="list?eventClub=${eventDto.eventClub}">소모임 홈</a>
    	 -->
    	<a href="list?clubNo=${eventDto.eventClub}">정모 목록</a>
    </div>
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
    