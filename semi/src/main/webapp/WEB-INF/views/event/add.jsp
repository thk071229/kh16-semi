<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
<!-- jquery cdn -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- kakaomap cdn  :: 기존 코드에서 &libraries=services 추가-->
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8e8665a62573621467f321f74eb7cae4&libraries=services"></script>
<script type="text/javascript">
		$(function () {
			// 생성한 마커의 정보를 저장할 공간 (마커가 여러개인 경우)
			var history = [];



			//지도 생성 코드
			var container = document.querySelector('.kakao-map');
			var options = {
				center: new kakao.maps.LatLng(37.499020, 127.032972), // 지도중심 (위도 : Lat, 경도 : Lng)
				level: 2 // 지도배율 (1~15)
			};
			var map = new kakao.maps.Map(container, options);

			$(".address-search-btn").on("click", function () {
				//++ 추가) 마커 초기화
				for(var i=0; i< history.length; i++){ // 이력의 모든 마커를 지도에서 제거
					history[i].setMap(null);
				}
				history=[]; //이력 제거

				//[1] 주소가 없으면 차단
				var address = $(".address-input").val();
				if (address.trim().length == 0) return;

				//[2] 주소가 있다면, 카카오에서 제공하는 장소검색 도구의 도움을 받아 처리
				var geocoder = new kakao.maps.services.Geocoder();

				//geocoder.addressSearch(주소, 검색 후 실행코드); // 예약 = callback함수
				geocoder.addressSearch(address, function (result, status) {
					//console.log(arguments); // 함수에 들어오는 모든 인자 목록을 조회
					// - result = 0, 1, 2 값이 들어오는데, 0을 실제 데이터 배열
					// - status = 1에 해당하는 검색결과 ( "OK" or "ZERO_RESULT") 둘 중 하나의 값을 가짐

					// if(staus == "OK"){
					if (status == kakao.maps.services.Status.OK) {
						console.log(result[0]);
						console.log("경도 : " + result[0].x); // 첫번째 값의 x좌표 : 경도
						console.log("위도 : " + result[0].y); // 첫번째 값의 y좌표 : 위도
						
						$("[name=eventRegionX]").val(result[0].x);
						$("[name=eventRegionY]").val(result[0].y);

						var location = new kakao.maps.LatLng(result[0].y, result[0].x); // 위치 정보 생성
						//map.setCenter(lovation);
						map.panTo(location);


						//마커 이미지 설정
						var imageSrc = "https://cdn-icons-png.flaticon.com/512/535/535239.png";
						var imageSize = new kakao.maps.Size(64, 69);
						var imageOption = { offset: new kakao.maps.Point(27, 69) }
						var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

						//마커 생성
						var marker = new kakao.maps.Marker({
							position: location,
							clickable: true,
							image: markerImage, //마커 이미지 설정
						});
						marker.setMap(map);

						history.push(marker);

						//인포윈도우 추가
						// 템플릿을 불러와서 설정
						var origin = $("#info-template").text();
						var div = $("<div>").html(origin);
						div.find(".content").text(address);
						var infoText = div.html(); //가짜 div 내부의 내용을 불러와서 infoText에 저장

						var info = new kakao.maps.InfoWindow({
							position: location,
							content: infoText,
							removable: true,// x버튼을 표시
						});

						kakao.maps.event.addListener(marker, "click", function () {
							info.open(map, marker); // 클릭하면 마커 표시
						})
					}
				});
			});
		})
	</script>
<!-- ------------------------구분선---------------------->
<!-- 인포윈도우에 표시할 HTML 코드를 템플릿으로 구현 -->
	<script type="text/template" id="info-template">
        <div style="padding:10px;">
            <div class="content">설명</div>
        </div>
    </script>
<!-- ------------------------구분선---------------------->
<div class="container">
	<div class="cell">
		<h1>정모 추가</h1>
	</div>
	
	<form action="/add" method="post" autocomplete="off">
	<input type="password" name="eventClub" value="${club_no}" readonly>

		<div class="cell">
			<input type="text" class="field" name="eventTitle">
		</div>
		<div class="cell">
			<input type="text" class="field" name="eventContent">
		</div>
		<div class="cell">
			<input type="date" class="field" name="eventDate">
		</div>
		
		<!-- 주소 검색을 통해 위도 경도값 저장 -->
		<div class="cell">
			<div class="flex-box">
				<input type="text" class="field w-100 address-input" placeholder="주소 또는 키워드 입력">
				<button class="btn btn-positive ms-10 address-search-btn">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</div>
		</div>
<!-- 		<div class="cell"> -->
<!-- 			<div class="kakao-map w-100"></div> -->
<!-- 		</div> -->
		<div class="cell">
			<input type="text" class="field" name="eventRegionX" readonly>
			<input type="text" class="field" name="eventRegionY" readonly>
		</div>
		
		<div class="cell">
			<button class="btn" type="button">등록</button>
		</div>

	</form>

	<div class="cell">
		<!-- 
	    <a href="list?eventClub=${eventDto.eventClub}">소모임 홈</a>
    	 -->
		<a href="list?clubNo=${eventDto.eventClub}">정모 목록</a>
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
