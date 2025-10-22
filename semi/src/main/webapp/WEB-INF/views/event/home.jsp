<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	
<style>
    .event-box{
    	background-color:#ecfbf8;
    	border : 1px solid #d8f8f1;
    	border-radius : 1em;
    	padding : 0.5em;
    }
    .event-box:hover{
    	background-color:#d8f8f1;
    	border : 3px solid #d8f8f1;
    }
    .event-title{
    	font-size:24px;
    	font-weight:500;
    	color:#005d5c;
    }
    .event-link{
    	text-decoration:none;
    	color:black;
    }
</style>

<!-- --------------------------------------------- -->
<div class="container">
    <div class="cell">
	    <h1>정모 목록</h1>
	</div>
	<c:forEach var="eventList" items="${eventDto}" varStatus="status">
						<div class="cell event-box w-50">
						<a class="event-link" href="detail?eventNo=${eventList.eventNo}">
							<div class="mb-10 event-title">
									<label>${eventList.eventTitle}</label>
							</div>
							<div class="ms-20"><i class="fa-solid fa-calendar"></i>
								<label>
									<fmt:formatDate value="${eventList.eventDate}" pattern="y년 M월 d일 H:mm" ></fmt:formatDate>
								</label>
							</div>
							<div class="ms-20"><i class="fa-solid fa-person"></i>
								<label>${eventList.eventWriter}</label>
							</div>
							<div class="ms-20"><i class="fa-solid fa-house"></i>
								<label>${eventList.eventClub}</label>
							</div>
							<div class="ms-20"><i class="fa-solid fa-house"></i>
								<label>${eventList.eventAddress}</label>
							</div>
							</a>
							</div>
						</c:forEach>
	</div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
  