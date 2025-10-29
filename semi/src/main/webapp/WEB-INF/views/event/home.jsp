<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	

<!-- more-button js -->
<script type="text/javascript">
$(function(){
	var size = 4;//보여줄 size
	var increase = 2;
	var selectedDate = null;
	var today = new Date();
	//최초 목록 호출
	loadList();
	fillDate();
	
	//더보기 버튼 이벤트
	$(".btn-more").on("click", function(){
		size += increase;
		filterEvents();
		loadList();
	});
	
	// 버튼에 오늘~7일까지 날짜값 채우기
	function fillDate(){
	$(".date").each(function(index){
		var newDate = new Date(today);
		newDate.setDate(today.getDate()+index);
		$(this).val(formatDate(newDate));
		// 기존 글자에 덧붙이기
		var dayonly = newDate.getDate();
		$(this).text($(this).text()+"("+dayonly+")");
	});	
	}
	
	function formatDate(date) {
		var year = date.getFullYear();
		var month = date.getMonth() + 1;
		var day = date.getDate();
		if(month < 10) month = '0' + month;
		if(day < 10) day = '0' + day;
		return year + '-' + month + '-' + day;
	}
	
	 // 날짜 버튼 클릭
    $(document).on("click", ".date", function(){
        selectedDate = $(this).val();
        $(".event-list-wrapper").empty();
        size = 4; // 날짜 바뀌면 페이지 초기화
        loadList();
    });

    // 전체보기 버튼 클릭
    $(document).on("click", ".date-all", function(){
        selectedDate = null; // 전체보기는 필터 해제
        $(".event-list-wrapper").empty();
        size = 4;
        loadList();
    });
    
	//목록 콜백 함수
	function loadList() {
		
		$.ajax({
			url:"/rest/more/homeEvent",
			method:"POST",
			data:{
				page:1,
				size:size,
				selectedDate:selectedDate
			},
			success: function(response) {
				console.log(response);
				console.log(selectedDate);
				var list = response.list;
				
				if(list.length == 0){
					return;
				}
				
				if(!selectedDate){
				$(".event-list-wrapper").empty();
				}
				
				for(var i = 0; i < list.length ; i++){
					var eventList = list[i];
					
					var origin = $("#event-weekly-template").text();
					var html = $.parseHTML(origin);
					
					$(html).find(".event-link").prop("href", "detail?eventNo=" + eventList.eventNo);
					$(html).find(".event-image").prop("src", "/event/image?eventNo=" + eventList.eventNo)
					$(html).find(".event-title-text").text(eventList.eventTitle);
					$(html).find(".event-attend").text("(" + eventList.eventAttend + "/" + eventList.eventMaxPeople + ")");
					$(html).find(".event-date").val(eventList.eventDate);
					
					var date = moment(eventList.eventDate).format("M월 D일 H:mm");
					console.log(eventList.eventDate);
					$(html).find(".date").text(date);
					
					$(html).find(".club-name").text(eventList.clubName);
					$(html).find(".member-nickname").text(eventList.memberNickname);
					$(html).find(".event-address").text(eventList.eventAddress);
					
					$(".event-list-wrapper").append(html);
				}//반복문 종료
				
				//필터링 적용
				filterEvents();
				//버튼 상태 업데이트
				//최초 상태
				$(".btn-more").show();
				
				if(response.hasMore == false){
					$(".btn-more").hide();
					$(".no-more").show();
					}
				else{
					$(".no-more").hide();
					$(".btn-more").show();
					}
			}//성공 시 함수 종료
		});//ajax 종료
	}
	
	//날짜 필터링 함수
	function filterEvents(){
	    var count = 0;
	    $(".event-box").each(function(){
	        var timestamp = $(this).find(".event-date").val();
	        var eventDateConvert = moment(timestamp).format('YYYY-MM-DD');
	        if(!selectedDate || eventDateConvert === selectedDate){
	            if(count < size){
	                $(this).closest(".event-link").show();
	                count++;
	            } else {
	                $(this).closest(".event-link").hide();
	            }
	        } else {
	            $(this).closest(".event-link").hide();
	        }
	    });
	}

});
</script>

<style>
	
	.flex-container {
	    display: flex;
	    flex-wrap: wrap;
	    gap: 20px; /* 카드 간격 */
	}

	.event-link {
	    box-sizing: border-box;
	    text-decoration: none;
	    color: inherit;
	}

	.event-box {
	    display: flex;
	    flex-direction: row;
	    width: 460px;
	    background-color: #ecfbf8;
	    border: 1px solid #d8f8f1;
	    border-radius: 1em;
	    padding: 0.5em;
	}
	.button-wrapper{
	width:100%;
	}
	.event-list-wrapper{
	width:100%;
	}
	.weekly-box{
	 width:100%;
	}
	.date, .date-all {
	 width:100%;
	}
</style>
<script type="text/template" id = "event-weekly-template">
<div class="event-list">
		<a class="event-link">
			<div class="event-box ms-10">
				<div>
					<img width="100" class="event-image">
				</div>
				<div class="flex-fill ms-20">
					<div class="mb-10 event-title">
						<label class="event-title-text">정모 제목</label>
						<label style="font-size:16px;" class="event-attend">(참여자/정원)</label>
					</div>
					<div class="ms-20"><i class="fa-solid fa-calendar"></i>
						<label>
							<input type="hidden" class="event-date">
							<span class="date">정모 날짜</span>
						</label>
					</div>
					<div class="ms-20"><i class="fa-solid fa-house"></i>
						<label class="club-name">모임 이름</label>
					</div>
					<div class="ms-20"><i class="fa-solid fa-person"></i>
						<label class="member-nickname">회원 닉네임</label>
					</div>
					<div class="ms-20"><i class="fa-solid fa-location-dot"></i>
						<label class="event-address">정모 주소</label>
					</div>
				</div>	
			</div>
		</a>
		</div>
</script>

<!-- --------------------------------------------- -->
<div class="container center w-1000">
    <div class="cell center center">
	    <h1>정모 목록</h1>
	    <label style="color: gray;">종료된 모임은 표시되지 않습니다</label>
	</div>
	<!-- 위클리페이지-->
	<div class="flex-box mb-20 flex-center weekly-box">
		<div class="btn btn-primary ms-10 date">오늘</div> <!-- 오늘 -->
		<div class="btn btn-primary ms-10 date">내일</div>
		<div class="btn btn-primary ms-10 date">모레</div>
		<div class="btn btn-primary ms-10 date">4일 후</div>
		<div class="btn btn-primary ms-10 date">5일 후</div>
		<div class="btn btn-primary ms-10 date">6일 후</div>
		<div class="btn btn-primary ms-10 date">7일 후</div> <!-- 7일째 -->
		<div class="btn btn-ghost ms-10 date-all">전체보기</div>
	</div>
	
	<div class="flex-container mt-10">
	<div class="event-list-wrapper flex-container">
		<h2 class="center">아직 등록된 정모 일정이 없습니다</h2>
	</div>
	</div>
	<div class="button-wrapper mt-20 w-100">
		<button type="button" class="btn btn-common btn-more w-100">정모 일정 더보기</button>
		 <div class="center no-more" style="display:none;"><h3>더이상 일정이 없습니다</h3></div>
	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
  