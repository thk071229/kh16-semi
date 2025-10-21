<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	    
    
    
<!-- --------------------------------------------- -->
<div class="container w-800">

    <div class="cell">
    	<h1>
    		정모상세 : ${eventDto.eventTitle}
    		<c:if test="${eventDto.eventEtime != null}">
			(수정됨)
			</c:if>
			</h1>
			<div class="cell">
    	<label>작성일</label>
    	<fmt:formatDate value="${eventDto.eventWtime}" pattern="M월 d일 H:mm" ></fmt:formatDate>
    </div>
		
    </div>
    
    <div class="cell">
     	<hr>
    </div>

    <div class="cell">
    	<i class="fa-solid fa-calendar"></i>
    	<fmt:formatDate value="${eventDto.eventDate}" pattern="y년 M월 d일 H:mm" ></fmt:formatDate>
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