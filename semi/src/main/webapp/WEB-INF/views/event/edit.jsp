<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	
    
    <h1>이벤트 수정</h1>
    <form action="/edit" method="post" autocomplete="off">
	
	<div>
		<input type="text" name="eventTitle" value="${eventDto.eventTitle}">
	</div>
	<div>
		<input type="date" name="eventDate" value="${eventDto.eventDate}">
	</div>
	<div>
		<input type="text" name="eventContent" value="${eventDto.eventContent}" )>
	</div>
	<div>
		<input type="text" name="eventRegionX"value="${eventDto.eventRegionX}">
	</div>
	<div>
		<input type="text" name="eventRegionY"value="${eventDto.eventRegionY}">
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