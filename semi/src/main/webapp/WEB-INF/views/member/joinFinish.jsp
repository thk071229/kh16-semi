<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!-- CDN-------------------------------------- -->
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- kakaomap cdn  -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8e8665a62573621467f321f74eb7cae4&libraries=services"></script>
<!-- -------------------------------------- -->
<style>
	.kakao-map {
		width: 100%;
		height: 200px;
	}
</style>
<!-- -------------------------------------- -->	
<script type="text/javascript">
	$(function(){
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
				$("[name=regionName]").val(result[0].address_name);
				$("[name=regionDepth1]").val(result[0].address.region_1depth_name);
				$("[name=regionDepth2]").val(result[0].address.region_2depth_name);
					
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

		});
</script>
			



<form action="joinFinish" method="post">
<input type="hidden" name="memberId" value="${memberId}">
<div class="container">

	<div class="cell center">
		<h1>회원가입 완료</h1>
		<span>찾아주셔서 감사합니다</span>
		
	</div>
	<div class="cell center">
		<hr>
		<h2>관심 지역과 카테고리 선택</h2>
	</div>
	<div class="flex-box">
	<!-- 관심카테고리 -->
	<div class="cell w-50 ">
		<div>
			<label>관심 카테고리</label>
		</div>
		<div class="mt-20">
    	<select class="field" name="categoryNo">
        	<c:forEach items="${categoryList}" var="categoryDto" >
            	<option value="${categoryDto.categoryNo}">${categoryDto.categoryName}</option>
        	</c:forEach>
    	</select>
    	</div>
	</div>
	<!-- 관심지역 -->
	<div class="cell">
		<label>관심 지역</label><br>
							<div class="cell flex-box flex-fill">
								<select class="field ms-10" name="regionType">
									<option value="">선택</option>
									<option>집</option>
									<option>직장</option>
									<option>관심지역</option>
								</select> 
								<div class="cell">
									<input type="text" name="regionName" class="ms-10 field address-input" placeholder="주소(시군구/읍면동) 입력 " required>
								</div>
								<div class="cell">
									<button type="button" class="btn btn-positive ms-10 address-search-btn">
										<i class="fa-solid fa-magnifying-glass"></i>
									</button>
								</div>
								<input class="ms-10 w-100" type="hidden" name="regionDepth1" readonly>
								<input class="ms-10 w-100" type="hidden" name="regionDepth2" readonly>
							</div>
							<div class="cell">
								<div class="kakao-map w-100"></div>
							</div>
	</div>
	</div>
	<div class="cell">
		<button class="btn btn-primary w-100" type="submit">저장</button>
		<a href="/" class="btn btn-post w-100 center">다음에 설정</a>
	</div>
</div>
</form>

