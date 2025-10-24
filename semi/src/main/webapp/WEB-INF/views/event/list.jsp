<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jquery cdn -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- kakaomap cdn  -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8e8665a62573621467f321f74eb7cae4&libraries=services"></script>

<!-- -------------------------------------- -->
<script type="text/javascript">
	$(function() {

		// 초기 지도 설정 (clubRegion이 설정되어 있지 않은 경우 서울시청)
		var container = document.querySelector(".kakao-map");
		var map = new kakao.maps.Map(container, {
			center : new kakao.maps.LatLng(37.566, 126.978),
			level : 4
		});

		//마커 이미지 설정
		var imageSrc = "https://cdn-icons-png.flaticon.com/512/535/535239.png";
		var imageSize = new kakao.maps.Size(64, 69);
		var imageOption = { offset: new kakao.maps.Point(27, 69) }
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
		
		// 사용할 정보 불러오기
		var clubNo = $(".clubNo").val();
		var address = $(".clubRegionName").val();
		var geocoder = new kakao.maps.services.Geocoder();

		$.ajax({
			url : "/rest/event/locations",
			method : "get",
			data : { clubNo : clubNo },
			success : function(list) {
				// 저장된 값이 없을때, clubRegionName 검색해서 중심 설정
				if (list.length == 0) {
					geocoder.addressSearch(address, function(result, status) {
						if (status == kakao.maps.services.Status.OK && result.length > 0) {
							var center = new kakao.maps.LatLng(result[0].y,result[0].x);
							map.setCenter(center);
						}
					});
					return;
				}

				// 저장된 좌표값 불러오기
				var bounds = new kakao.maps.LatLngBounds();
				list.forEach(function(response) {
					var markerPosition = new kakao.maps.LatLng(
							response.eventRegionY, response.eventRegionX);
					var marker = new kakao.maps.Marker({
						position : markerPosition,
						map : map,
						image : markerImage
					});
					bounds.extend(markerPosition);
				});

				// 리스트 값이 있으면 지도 위치 변경
				if (list.length === 1) {
					map.setCenter(new kakao.maps.LatLng(list[0].eventRegionY,
							list[0].eventRegionX));
				} else {
					map.setBounds(bounds);
				}
			}
		});
	});
</script>
<!-- -------------------------------------- -->
<style>
.event-box {
	background-color: #ecfbf8;
	border: 1px solid #d8f8f1;
	border-radius: 1em;
	padding: 0.5em;
}

.event-box:hover {
	background-color: #d8f8f1;
	border: 3px solid #d8f8f1;
}

.event-title {
	font-size: 24px;
	font-weight: 500;
	color: #005d5c;
}

.event-link {
	text-decoration: none;
	color: black;
}

.kakao-map {
	width: 100%;
	height: 300px;
}
</style>

<!-- ------------------------------------ -->
<div class="container w-800">

	<input type="hidden" class="clubNo" value="${clubNo}"> <input
		type="hidden" class="clubRegionName" value="${clubRegionName}">


	<div class="cell left">
		<a class="btn btn-ghost" href="/club/home?clubNo=${clubNo}">메인</a> <a
			class="btn btn-ghost" href="/board/list?clubNo=${clubNo}">게시판</a> <a
			class="btn btn-primary" href="/event/add?clubNo=${clubNo}">신규 등록</a>
	</div>

	<div class="cell">
		<label style="color: gray;">우리 소모임의 정모 History</label>
		<div class="kakao-map w-100"></div>
	</div>


	<div class="cell mt-40">
		<div class="flex-box">
			<!-- 진행중 정모 목록 -->
			<div class="cell w-50" style="padding: 5px;">
				<div class="cell center">
					<h1>진행중</h1>
				</div>
				<c:forEach var="beforeList" items="${beforeDto}" varStatus="status">
					<div class="cell event-box">
						<a class="event-link" href="detail?eventNo=${beforeList.eventNo}">
							<div class="mb-10 event-title">
								<label>${beforeList.eventTitle}</label> <label
									style="font-size: 16px;">(참여인원/${beforeList.eventMaxPeople})</label>
							</div>
							<div class="ms-20">
								<i class="fa-solid fa-calendar"></i> <label> <fmt:formatDate
										value="${beforeList.eventDate}" pattern="y년 M월 d일 H:mm"></fmt:formatDate>
								</label>
							</div>
							<div class="ms-20">
								<i class="fa-solid fa-person"></i> <label>${beforeList.memberNickname}</label>
							</div>
							<div class="ms-20">
								<i class="fa-solid fa-house"></i> <label>${beforeList.clubName}</label>
							</div>
							<div class="ms-20">
								<i class="fa-solid fa-house"></i> <label>${beforeList.eventAddress}</label>
							</div>
						</a>
					</div>
				</c:forEach>

			</div>

			<!-- 종료된 정모 목록 -->
			<div class="cell w-50" style="padding: 5px;">
				<div class="cell center">
					<h1>종료</h1>
				</div>

				<c:forEach var="afterList" items="${afterDto}" varStatus="status">
					<div class="cell event-box">
						<a class="event-link" href="detail?eventNo=${afterList.eventNo}">
							<div class="mb-10 event-title">
								<label>${afterList.eventTitle}</label> <label
									style="font-size: 16px;">(참여인원/${afterList.eventMaxPeople})</label>
							</div>
							<div class="ms-20">
								<i class="fa-solid fa-calendar"></i> <label> <fmt:formatDate
										value="${afterList.eventDate}" pattern="y년 M월 d일 H:mm"></fmt:formatDate>
								</label>
							</div>
							<div class="ms-20">
								<i class="fa-solid fa-person"></i> <label>${afterList.memberNickname}</label>
							</div>
							<div class="ms-20">
								<i class="fa-solid fa-house"></i> <label>${afterList.clubName}</label>
							</div>
							<div class="ms-20">
								<i class="fa-solid fa-house"></i> <label>${afterList.eventAddress}</label>
							</div>
						</a>
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
				<a class="event-link" href="detail?eventNo=${eventList.eventNo}">
					<div class="mb-10 event-title">
						<label>${eventList.eventTitle}</label> <label
							style="font-size: 16px;">(참여인원/${beforeList.eventMaxPeople})</label>
					</div>
					<div class="ms-20">
						<i class="fa-solid fa-calendar"></i> <label> <fmt:formatDate
								value="${eventList.eventDate}" pattern="y년 M월 d일 H:mm"></fmt:formatDate>
						</label>
					</div>
					<div class="ms-20">
						<i class="fa-solid fa-person"></i> <label>${eventList.memberNickname}</label>
					</div>
					<div class="ms-20">
						<i class="fa-solid fa-house"></i> <label>${eventList.clubName}</label>
					</div>
					<div class="ms-20">
						<i class="fa-solid fa-house"></i> <label>${eventList.eventAddress}</label>
					</div>
				</a>
			</div>
		</c:forEach>
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
