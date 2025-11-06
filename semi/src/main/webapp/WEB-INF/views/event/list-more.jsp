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
<!-- more button(before) js -->
<script type="text/javascript">
	$(function() {
		var params = new URLSearchParams(location.search);
		var clubNo = params.get("clubNo");
		var size = 3;
		var increase = 2;

		//최초 목록 호출
		loadListBefore();
		//더보기 버튼 이벤트(before-list)
		$(".btn-more-before").on("click", function() {
			size += increase;
			loadListBefore();

		});

		//진행 중 정모 목록 불러오는 함수
		function loadListBefore() {
			$.ajax({
				url : contextPath+"/rest/more/beforeEvent",
				method : "POST",
				data : {
					page : 1,
					size : size,
					clubNo : clubNo,
				},
				success : function(response) {//response == Map(list와 noticeCount가 들어있음)
					//list가 비어있을 경우 아무것도 하지 않음
					var list = response.list;
					console.log(response.hasMore);
					if (list.length == 0) {
						return;
					}
					//기본값 삭제
					$(".before-list-wrapper").empty();
					$(".wrapper").show();
					for (var i = 0; i < list.length; i++) {
						var eventList = list[i];
						var origin = $("#before-list-template").text();
						var html = $.parseHTML(origin);
						$(html).find(".event-link").prop("href",contextPath+
								"detail?eventNo=" + eventList.eventNo);
						$(html).find(".event-image").prop("src",contextPath+
								"/event/image?eventNo=" + eventList.eventNo);
						$(html).find(".event-title-text").text(
								eventList.eventTitle);
						$(html).find(".event-attend").text(
								"(" + eventList.eventAttend + "/"
										+ eventList.eventMaxPeople + ")")
						
										
 						var eventDate = moment(eventList.eventDate).format("y년 M월 D일 H:mm");
						$(html).find(".event-time").text(eventDate);

						$(html).find(".club-name").text(eventList.clubName);
						$(html).find(".member-nickname").text(
								eventList.memberNickname);

						$(html).find(".event-address").text(
								eventList.eventAddress);

						$(".before-list-wrapper").append(html);

					}//반복문 종료

					//button 실행 조건
					$(".btn-more-before").show();

					if (response.hasMore == false) {
						$(".btn-more-before").hide();
						$(".no-more").show();
					} else {
						$(".no-more").hide();
						$(".btn-more-before").show();
					}
				}//성공 시 함수 종료
			});//ajax 종료

		}//목록 함수 종료

	});
</script>

<!-- more-button(after) js -->
<script type="text/javascript">
	$(function() {
		var params = new URLSearchParams(location.search);
		var clubNo = params.get("clubNo");
		var size = 3;
		var increase = 2;

		//최초 목록 호출
		loadListAfter();

		//더보기 버튼 이벤트(after-list)
		$(".btn-more-after").on("click", function() {
			size += increase;
			console.log("size=" + size);
			loadListAfter();
		});

		function loadListAfter() {
			$.ajax({
				url : contextPath+"/rest/more/afterEvent",
				method : "POST",
				data : {
					page : 1,
					size : size,
					clubNo : clubNo,
				},
				success : function(response) {//response == Map(list와 noticeCount가 들어있음)
					//list가 비어있을 경우 아무것도 하지 않음
					var list = response.list;
					console.log($(".btn-more-after").length);
					console.log(list);
					if (list.length == 0) {
						return;
					}
					//기본값 삭제
					$(".after-list-wrapper").empty();
					$(".wrapper").show();
					for (var i = 0; i < list.length; i++) {
						var eventList = list[i];

						var origin = $("#after-list-template").text();
						var html = $.parseHTML(origin);

						$(html).find(".event-link").prop("href",contextPath+
								"detail?eventNo=" + eventList.eventNo);
						$(html).find(".event-image").prop("src",contextPath+
								"/event/image?eventNo=" + eventList.eventNo);
						$(html).find(".event-title-text").text(
								eventList.eventTitle);
						$(html).find(".event-attend").text(
								"(" + eventList.eventAttend + "/"
										+ eventList.eventMaxPeople + ")");
 						var eventDate = moment(eventList.eventDate).format("y년 M월 D일 H:mm");
						$(html).find(".event-time").text(eventDate);

						$(html).find(".club-name").text(eventList.clubName);
						$(html).find(".member-nickname").text(
								eventList.memberNickname);

						$(html).find(".event-address").text(
								eventList.eventAddress);

						$(".after-list-wrapper").append(html);

					}//반복문 종료

					$(".btn-more-after").show();

					if (response.hasMore == false) {
						$(".btn-more-after").hide();
						$(".no-more").show();
					} else {
						$(".no-more").hide();
						$(".btn-more-after").show();
					}
				}//성공 시 함수 종료

			});//ajax 종료

		}//목록 함수 종료
	});//종료된 정모 목록 불러오는 함수
</script>

<!-- more-button(all) js -->
<script type="text/javascript">
	$(function() {
		var params = new URLSearchParams(location.search);
		var clubNo = params.get("clubNo");
		var size = 3;
		var increase = 2;

		//최초 목록 호출
		loadList();

		//더보기 버튼 이벤트(all-list)
		$(".btn-more-all").on("click", function() {
			size += increase;
			loadList();

		});

		//전체 목록 불러오는 함수
		function loadList() {

			$.ajax({
				url : contextPath+"/rest/more/event",
				method : "POST",
				data : {
					page : 1,
					size : size,
					clubNo : clubNo,
				},
				success : function(response) {//response == Map(list와 noticeCount가 들어있음)
					console.log(response);
					console.log(size)
					//list가 비어있을 경우 아무것도 하지 않음
					var list = response.list;

					if (list.length == 0) {
						return;
					}
					//기본값 삭제
					$(".all-list-wrapper").empty();

					for (var i = 0; i < list.length; i++) {
						var eventList = list[i];

						var origin = $("#all-list-template").text();
						var html = $.parseHTML(origin);

						$(html).find(".event-link").prop("href",
								"detail?eventNo=" + eventList.eventNo);
						$(html).find(".event-image").prop("src",
								"/event/image?eventNo=" + eventList.eventNo);
						$(html).find(".event-title-text").text(
								eventList.eventTitle);
						$(html).find(".event-attend").text(
								"(" + eventList.eventAttend + "/"
										+ eventList.eventMaxPeople + ")");
 						var eventDate = moment(eventList.eventDate).format("y년 M월 D일 H:mm");
						$(html).find(".fmt").val(eventDate);

						$(html).find(".club-name").text(eventList.clubName);
						$(html).find(".member-nickname").text(
								eventList.memberNickname);

						$(html).find(".event-address").text(
								eventList.eventAddress);

						$(".all-list-wrapper").append(html);

					}//반복문 종료

					$(".btn-more-all").show();

					if (response.hasMore == false) {
						$(".btn-more-all").hide();
						$(".no-more").show();
					} else {
						$(".no-more").hide();
						$(".btn-more-all").show();
					}
				}//성공 시 함수 종료
			});
			//ajax 종료
		}
	});
</script>
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
		var imageOption = {
			offset : new kakao.maps.Point(27, 69)
		}
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
				imageOption);

		// 사용할 정보 불러오기
		var clubNo = $(".clubNo").val();
		var address = $(".clubRegionName").val();
		var geocoder = new kakao.maps.services.Geocoder();

		$.ajax({
			url : contextPath+"/rest/event/locations",
			method : "get",
			data : {
				clubNo : clubNo
			},
			success : function(list) {
				// 저장된 값이 없을때, clubRegionName 검색해서 중심 설정
				if (list.length == 0) {
					geocoder.addressSearch(address, function(result, status) {
						if (status == kakao.maps.services.Status.OK
								&& result.length > 0) {
							var center = new kakao.maps.LatLng(result[0].y,
									result[0].x);
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
<!-- before-list template -->
<script type="text/template" id="before-list-template">
		<div class="before-list">
					<a class="event-link">
						<div class="cell event-box event-ing flex-box">
							<div>
								<img width="100" class="event-image">
							</div>
							
							<div class="flex-fill ms-20">
								<div class="mb-10 event-title">
									<label class="event-title-text">정모 이름</label>
									<label style="font-size: 16px;" class="event-attend">(참여자/정원)</label>
								</div>
								<div class="ms-20">
									<i class="fa-solid fa-calendar"></i>
									<label class="event-time">
										정모 시간
									</label>
								</div>
								<div class="ms-20">
									<i class="fa-solid fa-house"></i>
									<label class="club-name">모임 이름</label>
								</div>
								<div class="ms-20">
									<i class="fa-solid fa-person"></i>
									<label class="member-nickname">회원 닉네임</label>
								</div>
								<div class="ms-20">
									<i class="fa-solid fa-location-dot"></i>
									<label class="event-address">정모 주소</label>
								</div>
							</div>
						</div>
					</a>
				</div>
</script>
<!-- after-list template -->
<script type="text/template" id="after-list-template">
					<div class="after-list">
					<a class="event-link">
						<div class="cell event-box event-end flex-box">
							<div>
								<img width="100" class="event-image">
							</div>
						
							<div class="flex-fill ms-20">
								<div class="mb-10 event-title">
									<label class="event-title-text">정모 이름</label>
									<label style="font-size: 16px;" class="event-attend">(참여자/정원)</label>
								</div>
								<div class="ms-20">
									<i class="fa-solid fa-calendar"></i>
									<label class="event-time">
										정모 시간
									</label>
								</div>
								<div class="ms-20">
									<i class="fa-solid fa-house"></i>
									<label class="club-name">모임 이름</label>
								</div>
								<div class="ms-20">
									<i class="fa-solid fa-person"></i>
									<label class="member-nickname">회원 닉네임</label>
								</div>
								<div class="ms-20">
									<i class="fa-solid fa-location-dot"></i>
									<label class="event-address">정모 주소</label>
								</div>
							</div>
						</div>
					</a>
				</div>
</script>
<!-- all-list template -->
<script type="text/template" id="all-list-template">
			<%-- 추가될 영역 --%>
			<div class="event-all-list">
			<a class="event-link">
				<div class="cell event-box flex-box">
					<div>
						<img width="100" class="event-image">
					</div>
					<div class="flex-fill ms-20">
						<div class="mb-10 event-title">
							<label class="event-title-text">정모 이름</label>
							<label class="event-attend" style="font-size: 16px;">
							(참여자 수/정원)
							</label>
						</div>
						<div class="ms-20">
							<i class="fa-solid fa-calendar"></i>
							<label class="event-time">
							 	정모 시간
							</label>
						</div>
						<div class="ms-20">
							<i class="fa-solid fa-house"></i> 
							<label class="club-name">모임 이름</label>
						</div>
						<div class="ms-20">
							<i class="fa-solid fa-person"></i> 
							<label class="member-nickname">회원 닉네임</label>
						</div>

						<div class="ms-20">
							<i class="fa-solid fa-location-dot"></i> 
							<label class="event-address">정모 주소</label>
						</div>
					</div>
				</div>
			</a>
			</div>

</script>
<!-- -------------------------------------- -->
<style>
.kakao-map {
	width: 100%;
	height: 300px;
}

.btn-more-all {
	display: none;
}

.btn-more-before {
	display: none;
}

.btn-more-after {
	display: none;
}
</style>
<!-- ------------------------------------ -->
<div class="container w-800">

	<input type="hidden" class="clubNo" value="${clubNo}"> <input
		type="hidden" class="clubRegionName" value="${clubRegionName}">


	<div class="cell left">
		<a class="btn btn-ghost" href="${pageContext.request.contextPath}/club/home?clubNo=${clubNo}">메인</a> <a
			class="btn btn-ghost" href="${pageContext.request.contextPath}/board/list?clubNo=${clubNo}">게시판</a>
		<c:if test="${sessionScope.loginId != null}">
			<a class="btn btn-primary" href="${pageContext.request.contextPath}/event/add?clubNo=${clubNo}">신규
				등록</a>
		</c:if>
	</div>
		<div class="cell">
			<label style="color: gray;">우리 소모임의 정모 History</label>
			<div class="kakao-map w-100"></div>
		</div>
	<div class="cell mt-10">
		<div class="flex-box">
			<!-- 진행중 정모 목록 -->
			<div class="cell w-50 wrapper" style="display: none; padding: 5px;">
				<div class="cell center">
					<h1>진행중</h1>
				</div>
				<!-- ajax로 변경되는 영역 -->
				<div class="before-list-wrapper">진행 중인 정모 일정이 없습니다</div>
				<div class="button-wrapper center">
					<button type="button" class="btn btn-common btn-more-before w-100">진행
						중인 정모 일정 더보기</button>
					<div class="center no-more" style="display: none;">
						<h3>더이상 일정이 없습니다</h3>
					</div>
				</div>
			</div>

			<!-- 종료된 정모 목록 -->
			<div class="cell w-50 wrapper" style="display: none; padding: 5px;">
				<div class="cell center">
					<h1>종료</h1>
				</div>
				<!-- ajax로 변경되는 영역 -->
				<div class="after-list-wrapper">
					<div class="button-wrapper center">
						<button type="button" class="btn btn-common btn-more-after w-100">
							종료된 정모 일정 더보기</button>
						<div class="center no-more" style="display: none;">
							<h3>더이상 일정이 없습니다</h3>
						</div>
					</div>
				</div>

			</div>
		</div>

		<!-- 기본 전체 목록 -->
		<div class="cell center">
			<h1>전체 정모 목록</h1>
		</div>

		<!-- template으로 바뀌는 영역 -->
		<div class="all-list-wrapper">
			<h2 class="center">아직 등록된 정모가 없습니다</h2>
		</div>

		<div class="button-wrapper center">
			<button type="button" class="btn btn-common btn-more-all w-100">
				정모 일정 더보기</button>
			<div class="center no-more" style="display: none;">
				<h3>더이상 일정이 없습니다</h3>
			</div>
		</div>
	</div>
</div>
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>