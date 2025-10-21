<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    
    <style>
    .event-box:{
    	background-color:#0984e3;
    	border : 1px solid black;
    	border-radius : 1em;
    	padding : 0.5em;
    }
    </style>


<div class="container w-800">

	<div class="cell mt-40">
		<div class="flex-box">
			<!-- 진행중 정모 목록 -->
				<div class="cell w-50" style="padding:5px;">
					<div class="cell">
						<h1>진행중</h1>
					</div>
						<c:forEach var="beforeList" items="${beforeDto}" varStatus="status">
						<div class="cell event-box">
							<div>
								<a href="detail?eventNo=${beforeList.eventNo}">
									${beforeList.eventTitle}</a>
							</div>
							<div>${beforeList.eventDate}</div>
							<div>${beforeList.eventWriter}</div>
							<div>${beforeList.eventClub}</div>
							</div>
						</c:forEach>
					
				</div>

			<!-- 종료된 정모 목록 -->
				<div class="cell w-50" style="padding:5px;">
					<div class="cell">
						<h1>종료</h1>
					</div>
					
						<c:forEach var="afterList" items="${afterDto}" varStatus="status">
							<div class="cell event-box">
							<div>
								<a href="detail?eventNo=${afterList.eventNo}">
									${afterList.eventTitle}</a>
							</div>
							<div>${afterList.eventDate}</div>
							<div>${afterList.eventWriter}</div>
							<div>${afterList.eventClub}</div>
						</div>
						</c:forEach>
				</div>

		</div>
	</div>

	<hr>


	<div class="cell">
		<h1>전체 정모 목록</h1>
	</div>

	<!-- 기본 전체 목록 -->

	<c:forEach var="eventList" items="${eventDto}" varStatus="status">
		<div class="cell event-box">
			<div class="cell">
				<a href="detail?eventNo=${eventList.eventNo}">
					${eventList.eventTitle} </a>
			</div>
			<div class="cell">${eventList.eventDate}</div>
			<div class="cell">${eventList.eventWriter}</div>
			<div class="cell">${eventList.eventClub}</div>
			<hr>
		</div>
	</c:forEach>



	<hr>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
