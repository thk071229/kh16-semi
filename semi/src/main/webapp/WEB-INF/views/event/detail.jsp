<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	    
    
    
<!-- --------------------------------------------- -->
<div class="container">

    <div class="cell">
    	<h1>
    		정모상세 : ${boardDto.boardTitle}
    		<c:if test="${boardDto.boardEtime != null}">
			(수정됨)
			</c:if>
		</h1>
    </div>
    
    <div class="cell">
     	<hr>
    </div>
    
    <div class="cell">
		제목 : ${eventDto.eventTitle}
    </div>
    <div class="cell">
   		작성자 : ${eventDto.eventWriter}
    </div>
    <div class="cell">
   		시간 : ${eventDto.eventDate}
    </div>
     <div class="cell">
   		내용 : ${eventDto.eventContent}
    </div>
    <div class="cell">
   		x좌표 : ${eventDto.eventRegionX}
    </div>
    <div class="cell">
   		y좌표 : ${eventDto.eventRegionY}
    </div>
    <div class="cell">
   		작성시간 : ${eventDto.eventWtime}
    </div>
    
    <div class="cell">
     	<hr>
    </div>
    
    <div class="cell">
    	<a href="list?clubNo=${eventDto.eventClub}">목록</a>
    	<a href="add?clubNo=${eventDto.eventClub}">등록</a>
    	<a href="edit?eventNo=${eventDto.eventNo}">수정</a>
    	<a href="delete?eventNo=${eventDto.eventNo}">삭제</a>
    </div>
    
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	