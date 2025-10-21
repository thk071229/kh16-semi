<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
  <!-- jquery cdn -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
    </style>

<!-- ------------------------------------ -->
<div class="container w-800">

	<div class="cell mt-40">
		<div class="flex-box">
			<!-- 진행중 정모 목록 -->
				<div class="cell w-50" style="padding:5px;">
					<div class="cell center">
						<h1>진행중</h1>
					</div>
						<c:forEach var="beforeList" items="${beforeDto}" varStatus="status">
						<div class="cell event-box">
							<div>
								<a class="event-title"href="detail?eventNo=${beforeList.eventNo}">
									<label>${beforeList.eventTitle}</label>
								</a>
							</div>
							<div><i class="fa-solid fa-calendar"></i>
								<label>
									<fmt:formatDate value="${beforeList.eventDate}" pattern="y년 M월 d일 H:mm" ></fmt:formatDate>
								</label>
							</div>
							<div><i class="fa-solid fa-person"></i>
								<label>${beforeList.eventWriter}</label>
							</div>
							<div><i class="fa-solid fa-house"></i>
								<label>${beforeList.eventClub}</label>
							</div>
							</div>
						</c:forEach>
					
				</div>

			<!-- 종료된 정모 목록 -->
				<div class="cell w-50" style="padding:5px;">
					<div class="cell center">
						<h1>종료</h1>
					</div>
					
						<c:forEach var="afterList" items="${afterDto}" varStatus="status">
						<div class="cell event-box">
							<div>
								<a class="event-title" href="detail?eventNo=${afterList.eventNo}">
									<label>${afterList.eventTitle}</label>
								</a>
							</div>
							<div><i class="fa-solid fa-calendar"></i>
								<label>
									<fmt:formatDate value="${afterList.eventDate}" pattern="y년 M월 d일 H:mm" ></fmt:formatDate>
								</label>
							</div>
							<div><i class="fa-solid fa-person"></i>
								<label>${afterList.eventWriter}</label>
							</div>
							<div><i class="fa-solid fa-house"></i>
								<label>${afterList.eventClub}</label>
							</div>
							</div>
						</c:forEach>
				</div>

		</div>
	</div>

	<hr>

	<!-- 기본 전체 목록 -->
	<div>
	<div class="cell center">
		<h1>전체 정모 목록</h1>
	</div>
	<c:forEach var="eventList" items="${eventDto}" varStatus="status">
						<div class="cell event-box">
							<div>
								<a class="event-title" href="detail?eventNo=${eventList.eventNo}">
									<label>${eventList.eventTitle}</label>
								</a>
							</div>
							<div><i class="fa-solid fa-calendar"></i>
								<label>
									<fmt:formatDate value="${eventList.eventDate}" pattern="y년 M월 d일 H:mm" ></fmt:formatDate>
								</label>
							</div>
							<div><i class="fa-solid fa-person"></i>
								<label>${eventList.eventWriter}</label>
							</div>
							<div><i class="fa-solid fa-house"></i>
								<label>${eventList.eventClub}</label>
							</div>
							</div>
						</c:forEach>
	</div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
