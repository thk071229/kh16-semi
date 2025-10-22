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
    .event-link{
    	text-decoration:none;
    	color:black;
    }
    </style>

<!-- ------------------------------------ -->
<div class="container w-800">

	<div class="cell">
		<a class="btn btn-primary" href="add?clubNo=${clubNo}">신규 등록</a>
	</div>
	
	<div class="cell mt-40">
		<div class="flex-box">
			<!-- 진행중 정모 목록 -->
				<div class="cell w-50" style="padding:5px;">
					<div class="cell center">
						<h1>진행중</h1>
					</div>
						<c:forEach var="beforeList" items="${beforeDto}" varStatus="status">
						<div class="cell event-box">
							<a class="event-link"href="detail?eventNo=${beforeList.eventNo}">
								<div class="mb-10 event-title">
										<label>${beforeList.eventTitle}</label>
								</div>
								<div class="ms-20"><i class="fa-solid fa-calendar"></i>
									<label>
										<fmt:formatDate value="${beforeList.eventDate}" pattern="y년 M월 d일 H:mm" ></fmt:formatDate>
									</label>
								</div>
								<div class="ms-20"><i class="fa-solid fa-person"></i>
									<label>${beforeList.eventWriter}</label>
								</div>
								<div class="ms-20"><i class="fa-solid fa-house"></i>
									<label>${beforeList.clubName}</label>
								</div>
								<div class="ms-20"><i class="fa-solid fa-house"></i>
									<label>${beforeList.eventAddress}</label>
								</div>
								<div class="ms-20"><i class="fa-solid fa-person"></i>
									<label>참여자 / ${beforeList.eventMaxPeople}</label>
								</div>
							</a>
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
								<a class="event-link" href="detail?eventNo=${afterList.eventNo}">
										<div class="mb-10 event-title">
											<label>${afterList.eventTitle}</label>
										</div>
										<div class="ms-20"><i class="fa-solid fa-calendar"></i>
											<label>
												<fmt:formatDate value="${afterList.eventDate}" pattern="y년 M월 d일 H:mm" ></fmt:formatDate>
											</label>
										</div>
										<div class="ms-20"><i class="fa-solid fa-person"></i>
											<label>${afterList.eventWriter}</label>
										</div>
										<div class="ms-20"><i class="fa-solid fa-house"></i>
											<label>${afterList.clubName}</label>
										</div>
										<div class="ms-20"><i class="fa-solid fa-house"></i>
											<label>${afterList.eventAddress}</label>
										</div>
										<div class="ms-20"><i class="fa-solid fa-person"></i>
											<label>참여자 / ${afterList.eventMaxPeople}</label>
										</div>
									</a>
								</div>
						</div>
						</c:forEach>
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
							<a class="event-link"href="detail?eventNo=${eventList.eventNo}">
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
								<label>${eventList.clubName}</label>
							</div>
							<div class="ms-20"><i class="fa-solid fa-house"></i>
								<label>${eventList.eventAddress}</label>
							</div>
							<div class="ms-20"><i class="fa-solid fa-person"></i>
								<label>참여자 / ${eventList.eventMaxPeople}</label>
							</div>
							</a>
							</div>
						</c:forEach>
	</div>
		
	</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
