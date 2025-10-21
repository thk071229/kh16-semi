<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- -------------------------------------- -->
<!-- moment CDN-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>

<!-- lightpick CDN-->
    <link href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>

<!-- JQuery cdn -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- kakaomap cdn  -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8e8665a62573621467f321f74eb7cae4&libraries=services"></script>
<!-- -------------------------------------- -->
<style>
	.kakao-map {
		width: 100%;
		height: 300px;
	}
</style>
<!-- -------------------------------------- -->	
	<script type="text/javascript">
		$(function () {
			
			// datepicker 관련
			var picker1 = new Lightpick({
				field:document.querySelector("[name=eventDate]"),
				singleDate:true,
				format:'YYYY-MM-DD HH:mm:ss',
				time : true
			});
			
			//-------------------------------------
			
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
				geocoder.addressSearch(address, function (result, status) {
					if (status == kakao.maps.services.Status.OK) {
						console.log(result[0]);
						console.log("경도 : " + result[0].x); // 첫번째 값의 x좌표 : 경도
						console.log("위도 : " + result[0].y); // 첫번째 값의 y좌표 : 위도
						$("[name=eventRegionX]").val(result[0].x);
						$("[name=eventRegionY]").val(result[0].y);

						var location = new kakao.maps.LatLng(result[0].y, result[0].x); // 위치 정보 생성
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
<div class="container w-600">
	<div class="cell w-100">
		<h1>정모 추가</h1>
	</div>
	
	<form action="add" method="post" autocomplete="off">
	<input type="hidden" name="eventClub" value="${clubNo}">
	
		<div class="cell">
			<label>정모이름</label>
			<input type="text" class="field w-100" name="eventTitle">
		</div>
		<div class="cell">
			<label>상세내용</label>
			<input type="text" class="field  w-100" name="eventContent">
		</div>
		<div class="cell">
			<label>정모일시</label>
			<input type="text" class="field w-100" name="eventDate">
		</div>
		
		<!-- 주소 검색을 통해 위도 경도값 저장 -->
		<div class="cell w-100">
			<label>정모위치</label>
			<div class="flex-box">
				<input type="text" class="field w-100 address-input" placeholder="주소(시군구/읍면동) 입력 ">
				<button type="button" class="btn btn-positive ms-10 address-search-btn">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</div>
		</div>
		<div class="cell">
			<div class="kakao-map w-100"></div>
		</div>
		<div class="cell flex-box w-100">
			<input type="text" class="field w-50 center" name="eventRegionX" placeholder="경도 좌표" readonly style="border:0 solid white;">
			<input type="text" class="field w-50 center" name="eventRegionY" placeholder="위도 좌표" readonly style="border:0 solid white;">
		</div>
		
		<div class="cell">
			<button class="btn" type="submit">등록</button>
		</div>

	</form>

	<div class="cell">
		<a href="list?clubNo=${eventDto.eventClub}">정모 목록</a>
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
