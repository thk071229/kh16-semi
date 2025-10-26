<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	

<script type="text/javascript">
	$(function(){
		var today = new Date();
		
		// 버튼에 오늘~7일까지 날짜값 채우기
		$(".date").each(function(index){
			var newDate = new Date(today);
			newDate.setDate(today.getDate()+index);
			$(this).val(formatDate(newDate));
			// 기존 글자에 덧붙이기
			var dayonly = newDate.getDate();
			$(this).text($(this).text()+"("+dayonly+")");
		});		

		//날짜 선택 시 이벤트 필터링
		$(".date").on("click",function(){
			var selectedDate = $(this).val();
			
			$(".event-box").each(function(){
			        var timestamp = $(this).find(".event-date").val();
			        var eventDate = new Date(parseInt(timestamp));
			        var eventDateConvert = formatDate(eventDate);
					// 해당하는 날짜면 보여주고, 아니면 숨기기
			        if(eventDateConvert === selectedDate){
			            $(this).closest(".event-link").show();
			       	 } else {
			            $(this).closest(".event-link").hide();
			       	 }
			    });

		});
		
		// 전체 정모 보여주기
		$(".date-all").on("click",function(){
			$(".event-link").show();
		});
		
	});
	
	function formatDate(date) {
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var day = date.getDate();
		if(month < 10) month = '0' + month;
		if(day < 10) day = '0' + day;
		return year + '-' + month + '-' + day;
	}
</script>
<style>
	.container::after {
	    content: "";
	    display: block;
	    clear: both;
	}

	
	.event-box{
		display: flex;               /* 내부 레이아웃 유지 */
		flex-wrap : wrap;
		flex-direction: row;         /* 기본 행 배치 */
		float: left;                 /* 카드 좌측 정렬, 줄 바꿈 허용 */
		width : 48%;
		box-sizing: border-box;      /* padding, border 포함 폭 계산 */
	}

</style>

<!-- --------------------------------------------- -->
<div class="container w-1000">
    <div class="cell center">
	    <h1>정모 목록</h1>
	</div>
	<!-- 위클리페이지-->
	<div class="flex-box">
		<div class="btn btn-primary date">오늘</div> <!-- 오늘 -->
		<div class="btn btn-primary ms-10 date">내일</div>
		<div class="btn btn-primary ms-10 date">모레</div>
		<div class="btn btn-primary ms-10 date">4일 후</div>
		<div class="btn btn-primary ms-10 date">5일 후</div>
		<div class="btn btn-primary ms-10 date">6일 후</div>
		<div class="btn btn-primary ms-10 date">7일 후</div> <!-- 7일째 -->
		<div class="btn btn-ghost ms-10 date-all">전체보기</div>
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
							<input type="hidden" class="event-date" value="${eventList.eventDate.time}">
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
	
	<!-- 페이지 내비게이터 영역 -->
	<div class="cell center mt-20 mb-20">
		<jsp:include page="/WEB-INF/views/template/pagination-num.jsp"></jsp:include>	
	</div>
	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
  