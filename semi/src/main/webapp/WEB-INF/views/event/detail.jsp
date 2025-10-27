<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	    
 <!-- -------------------------------------- -->
<!-- JQuery cdn -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- kakaomap cdn  -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8e8665a62573621467f321f74eb7cae4&libraries=services"></script>

<!-- --------------------------------------------- -->
<style>
	.kakao-map {
		width: 100%;
		height: 300px;
	}
	.table-wrapper {
	  background: var(--surface);
	  border-radius: var(--radius);
	  box-shadow: var(--shadow);
	  padding: 16px;
	  margin-top: 15px;
	}
	.table-wrapper table {
	  width: 100%;
	  border-collapse: collapse;
	}
	.table-wrapper th, .table-wrapper td {
	  border: 1px solid #dcdcdc;
	  padding: 10px;
	  text-align: center;
	}


</style>
<!-- -------------------------------------- -->	
<script type="text/javascript">
	$(function(){
		var container = document.querySelector('.kakao-map');
		var regionX = $(".regionX").val();
		var regionY = $(".regionY").val();
		var location = new kakao.maps.LatLng(regionY, regionX);
		
		var option = {
			center : location,
			level : 2  
		};
		var map = new kakao.maps.Map(container, option);
		var marker = new kakao.maps.Marker({
			position : location,
			clickable:true
		});
		marker.setMap(map);
	});
</script>
<!-- 정모 참여(eventAttendee) 관련 작업 -->	
<!-- 정모 참여 확인 -->
<script type="text/javascript">
	$(function(){
		// 파라미터 읽는 코드
		var params = new URLSearchParams(location.search);
		var eventNo = params.get("eventNo");
		$.ajax({
			url:"/rest/event/check?eventNo="+eventNo,
			method:"get",
			success : function(response) {
				if (response.attend) {
					$("#event-attendee").removeClass("fa-square fa-square-check").addClass("fa-square-check");
					$("#event-attendee-count").text(response.count);
					console.log(response);
				} else {
					$("#event-attendee").removeClass("fa-square fa-square-check").addClass("fa-square");
					$("#event-attendee-count").text(response.count);
					console.log(response);
					}
				}
			})
		});
</script>
<c:if test="${sessionScope.loginId != null}">
	<!-- 참여 관련 처리 -->
	<script type="text/javascript">
		$(function() {
			
			// 오늘 날짜 기준으로 event-date가 과거면 비동기통신 작동안함
			var eventDate = new Date($(".eventDate").val());
			var today = new Date();
			if(eventDate < today){
				$("#event-attendee").prop("disabled",true);
				return;
			} 
			
			//버튼을 누르면 서버의 /rest/event/action으로 신호를 전송
			$("#event-attendee").on("click",function() {
					// 현재 참여체크
				    var isAttend = $(this).hasClass("fa-square-check");
					// 최대인원 체크
					var currentCount = parseInt($("#event-attendee-count").text());
					var maxPeople = parseInt("${eventDto.eventMaxPeople}");

					// 최대인원 체크
						if(!isAttend && currentCount >= maxPeople){
							alert("이미 최대 인원에 도달했습니다.");
						return; // 클릭 무시
					}
				
						var params = new URLSearchParams(location.search);
						var eventNo = params.get("eventNo");
						$.ajax({
							url : "/rest/event/action?eventNo="+ eventNo,
							method : "get",
							success : function(response) {
								if (response.attend) {
									$("#event-attendee").removeClass("fa-square fa-square-check").addClass("fa-square-check");
									$("#event-attendee-count").text(response.count);
								} else {//좋아요가 해제되었다면
									$("#event-attendee").removeClass("fa-square fa-square-check").addClass("fa-square");
									$("#event-attendee-count").text(response.count);
									}
								}
						});
				});
		});
	</script>
</c:if>

<!-- -------------------------------------- -->	
<div class="container w-800">

<!-- -hidden 으로 정보 전달--- -->	
<input type="hidden" value="${eventDto.eventRegionX}" class="regionX" readonly>
<input type="hidden" value="${eventDto.eventRegionY}" class="regionY" readonly>
<input type="hidden" value="${eventDto.eventDate}" class="eventDate">
	<div>
		<a class="btn btn-ghost w-25 center" href="list?clubNo=${eventDto.eventClub}"> ◀ 목록</a>
 	</div>
 			<div class="cell center"> 
		    	<h1>
		    		${eventDto.eventTitle}
		    		<c:if test="${eventDto.eventEtime != null}">
						<span style="font-size:18;">(수정됨)</span>
					</c:if>
				</h1>
			</div>
 			<div class="float-box">
				<div class="cell float-left">
					<i class="fa-solid fa-person"></i>
					<label>${eventListVO.memberNickname}</label><br>
			    	<i class="fa-solid fa-calendar"></i>
			    	<fmt:formatDate value="${eventDto.eventDate}" pattern="y년 M월 d일 H:mm" ></fmt:formatDate>
					<label> ( 작성일</label>
			    	<fmt:formatDate value="${eventDto.eventWtime}" pattern="M월 d일 H:mm" ></fmt:formatDate>
					<label> )</label>
			    </div>
			    <div class="float-right">
				    <div class="cell" style="font-size:18px">
				    	인원 : <span id="event-attendee-count">?</span> / ${eventDto.eventMaxPeople}
					</div>
				</div>
				<div class="cell float-right" >
					<i id="event-attendee" class="fa-regular fa-square fa-2x "></i>
				</div>
			</div>	

			
			<div class="table-wrapper">
				<hr>
				<table>
			      <tbody>
			          <tr>
						<td style="width:80px;">참여인원</td>
			            <td class="flex-box">
							<c:forEach var="eventAttendee" items="${eventAttendeeListVO}" varStatus="status">
								<c:choose>
									<c:when test = "${not empty eventAttendee.memberId}">
										<a href = "/member/detail?memberId=${eventAttendee.memberId}" style="text-decoration: none; color:black; font-weight:600">
											<div class="member-card flex-box" style="align-items: center; background-color: var(--surface); border-radius: 20px; padding: 5px 15px 5px 5px; box-shadow: var(--shadow); border: 1px solid #eee;">
				        					<%-- 프로필 사진 (회원 ID 사용) --%>
					        					<div style="width: 40px; height: 40px; border-radius: 50%; overflow: hidden; margin-right: 10px;">
													<img src="/member/profile?memberId=${eventAttendee.memberId}"  style="width: 100%; height: 100%; object-fit: cover;"
										     		onerror="this.onerror=null; this.src='/images/error/no-image.png';"> <%-- 이미지 로드 실패 시 기본 이미지 --%>
												</div>
												<label>${eventAttendee.attendMemberNickname}</label>
											</div>
										</a>
										</c:when>
									<c:otherwise>
        								<p>참여한 회원이 없습니다.</p>
    								</c:otherwise>
								</c:choose>
							</c:forEach>
			            </td>
			          </tr>
					  <tr>
					  	<td>
							<div> 내용 </div>
					  	</td>
					    <td>
							${eventDto.eventContent}
					    </td>
					  </tr>
			      </tbody>
			    </table>
				<hr>
			</div>

	<div class="cell">
		<div class="kakao-map w-100"></div>
	</div>
    
    <div class="cell">
     	<hr>
    </div>
    
	
	<c:if test="${sessionScope.loginId != null}">
	    <div class="cell center">
	    	<a class="btn btn-primary w-25" href="add?clubNo=${eventDto.eventClub}">등록</a>
			<c:if test="${sessionScope.loginId == eventDto.eventWriter || sessionScope.loginId eq eventListVO.clubLeader}">
	 	   		<a class="btn btn-accent w-25" href="edit?eventNo=${eventDto.eventNo}">수정</a>
	    		<a class="btn btn-accent w-25" href="delete?eventNo=${eventDto.eventNo}">삭제</a>
			</c:if>
	    </div>
	</c:if>
    
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	