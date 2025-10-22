<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- -------------------------------------- -->
<!-- lightpick CDN-->
    <link href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
<!-- kakaomap cdn  -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8e8665a62573621467f321f74eb7cae4&libraries=services"></script>
<!-- summernote 에디터 적용(cdn 및 js 파일, css 파일) -->
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
	<link rel  ="stylesheet" type="text/css" href="/summernote/custom-summernote.css">
	<script src = "/summernote/custom-summernote.js"></script>   
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
					level: 3 // 지도배율 (1~15)
					};
				var map = new kakao.maps.Map(container, options);
				
				//마커 이미지 설정
				var imageSrc = "https://cdn-icons-png.flaticon.com/512/535/535239.png";
				var imageSize = new kakao.maps.Size(64, 69);
				var imageOption = { offset: new kakao.maps.Point(27, 69) }
				var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
				// 지오코더 서비스 생성(주소검색)
				var geocoder = new kakao.maps.services.Geocoder();
				
			// [1] 주소 검색시, 마커 설정 + 좌표 저장
			$(".address-search-btn").on("click", function () {
				//[1-0] 추가) 마커 초기화
				for(var i=0; i< history.length; i++){ // 이력의 모든 마커를 지도에서 제거
					history[i].setMap(null);
				}
				history=[]; //이력 제거
				
				//[1-1] 주소가 없으면 차단
				var address = $(".address-input").val();
				if (address.trim().length == 0) return;

				//[1-2]주소가 있다면, 카카오에서 제공하는 장소검색 도구의 도움을 받아 처리
				geocoder.addressSearch(address, function (result, status) {
					if (status == kakao.maps.services.Status.OK) {
						$("[name=eventRegionX]").val(result[0].x); // 경도
						$("[name=eventRegionY]").val(result[0].y); // 위도

						console.log(result[0]);
							
						var location = new kakao.maps.LatLng(result[0].y, result[0].x); // 위치 정보 생성
						map.panTo(location);

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
			/// [2] 클릭한 곳에 마커 설정 + 좌표 저장
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
				//[2-0] 추가) 마커 초기화
				for(var i=0; i< history.length; i++){ // 이력의 모든 마커를 지도에서 제거
					history[i].setMap(null);
				}
				history=[]; //이력 제거
				
				// [2-1] 위치정보 저장
				var latlng = mouseEvent.latLng;
				$("[name=eventRegionX]").val(latlng.getLng()); // 경도
				$("[name=eventRegionY]").val(latlng.getLat()); // 위도
				var location = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng()); // 위치 정보 생성
				
				// 정보 출력
				geocoder.coord2Address(latlng.getLng(),latlng.getLat(), function (result, status) {
					if (status == kakao.maps.services.Status.OK) {
						console.log(result[0].address)
						console.log(result[0].address.address_name);
						$(".address-input").val(result[0].address.region_1depth_name+" "+result[0].address.region_2depth_name+" "+result[0].address.region_3depth_name);		
					}
				});
				// [2-2] 마커 생성
				var marker = new kakao.maps.Marker({
					position: location,
					clickable: true,
					image: markerImage, //마커 이미지 설정
				});
				marker.setMap(map);
				history.push(marker);
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
<div class="container w-800">
	<div class="cell w-100 center">
		<h1>정모 추가</h1>
	</div>
	
	<form action="add" method="post" autocomplete="off">
	<input type="hidden" name="eventClub" value="${clubNo}" required>

			<div class="cell">

				<div class="flex-box">
					<div class="cell">
						<div class="cell w-100">
							<label>정모이름</label><br>
							<input type="text" class="field" name="eventTitle" required>
						</div>
						<div class="cell w-100">
							<label>정원(최대인원)</label><br>
							<input type="number" class="field" name="eventMaxPeople" required>
						</div>
						<div class="cell w-100">
							<label>정모일시</label><br>
							<input type="text" class="field" name="eventDate" required>
						</div>
						<!-- 주소 검색을 통해 위도 경도값 저장 -->
						<div class="cell w-100">
							<label>정모위치</label>
							<div class="flex-box">
								<input type="text" name="eventAddress" class="field w-100 address-input" placeholder="주소(시군구/읍면동) 입력 " required>
								<button type="button" class="btn btn-positive ms-10 address-search-btn">
									<i class="fa-solid fa-magnifying-glass"></i>
								</button>
							</div>
						</div>
						
					</div>
						<div class="flex-fill ms-20">
							<div class="cell">
								<label style="color:gray;">검색 후, 상세주소를 지도에 클릭해주세요</label>
								<div class="kakao-map w-100"></div>
							</div>
							<div class="cell flex-box w-100">
								<input type="hidden" name="eventRegionX" readonly>
								<input type="hidden" name="eventRegionY" readonly>
							</div>
						</div>	
				</div>
				
				<div class="cell">
					<label>내용</label>
					<textarea class="summernote-editor" name="eventContent" required></textarea>
				</div>
				<div class="cell center">
					<button class="btn w-100 center" type="submit">
						등록
					</button>
				</div>		
		</div>
		</form>
</div>

	


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
