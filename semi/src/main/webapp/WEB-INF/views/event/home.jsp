<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	
<style>
	.container::after {
	    content: "";
	    display: block;
	    clear: both;
	}
    .event-box{
    	background-color:#ecfbf8;
    	border : 1px solid #d8f8f1;
    	border-radius : 1em;
    	padding : 0.5em;
		align-items: center;
		
		display: flex;               /* 내부 레이아웃 유지 */
		flex-wrap : wrap;
		flex-direction: row;         /* 기본 행 배치 */
		float: left;                 /* 카드 좌측 정렬, 줄 바꿈 허용 */
		width : 48%;
		height : 150px;
		box-sizing: border-box;      /* padding, border 포함 폭 계산 */
	}

    .event-box:hover{
    	filter: brightness(95%);
    	outline : 2px solid #d8f8f1;
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
<div class="container w-1000">
    <div class="cell center">
	    <h1>정모 목록</h1>
	</div>
	<c:forEach var="eventList" items="${eventDto}" varStatus="status">
		<a class="event-link" href="detail?eventNo=${eventList.eventNo}">
			<div class="flex-box cell event-box ms-10">
				<div >
					<c:choose>
						<c:when test="${eventList.attachmentNo != null}">
							<img src="/attachment/download?attachmentNo=${eventList.attachmentNo}" width="100">
						</c:when>
						<c:otherwise>
							<img src="/images/error/no-image.png" width="100">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="flex-fill ms-20">
					<div class="mb-10 event-title">
						<label>${eventList.eventTitle}</label>
						<label style="font-size:16px;">(${eventList.eventAttend}/${eventList.eventMaxPeople})</label>
					</div>
					<div class="ms-20"><i class="fa-solid fa-calendar"></i>
						<label>
							<fmt:formatDate value="${eventList.eventDate}" pattern="M월 d일 H:mm" ></fmt:formatDate>
						</label>
					</div>
					<div class="ms-20"><i class="fa-solid fa-house"></i>
						<label>${eventList.clubName}</label>
					</div>
					<div class="ms-20"><i class="fa-solid fa-person"></i>
						<label>${eventList.memberNickname}</label>
					</div>
					<div class="ms-20"><i class="fa-solid fa-location-dot"></i>
						<label>${eventList.eventAddress}</label>
					</div>
				</div>		
			</div>
		</a>
	</c:forEach>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
  