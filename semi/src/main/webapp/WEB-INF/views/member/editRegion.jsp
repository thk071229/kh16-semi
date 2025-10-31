<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
$(window).on("load", function(){
	  var history = [];
	  var container = document.querySelector('.kakao-map');
	  var options = {
	    center: new kakao.maps.LatLng(37.499020, 127.032972),
	    level: 3
	  };
	  var map = new kakao.maps.Map(container, options);
	  var imageSrc = "https://cdn-icons-png.flaticon.com/512/535/535239.png";
	  var imageSize = new kakao.maps.Size(64, 69);
	  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
	  var geocoder = new kakao.maps.services.Geocoder();

	  $(".address-search-btn").on("click", function(){
	    var address = $(".address-input").val().trim();
	    if (!address) {
	      alert("주소를 입력하세요.");
	      return;
	    }

	    // 이전 마커 제거
	    history.forEach(m => m.setMap(null));
	    history = [];

	    geocoder.addressSearch(address, function(result, status){
	      console.log("status:", status, result);
	      if (status === kakao.maps.services.Status.OK) {
	        var addrInfo = result[0].road_address || result[0].address;
	        if (!addrInfo) return alert("주소 정보를 찾을 수 없습니다.");

	        $("[name=regionName]").val(addrInfo.address_name);
	        $("[name=regionDepth1]").val(addrInfo.region_1depth_name);
	        $("[name=regionDepth2]").val(addrInfo.region_2depth_name);

	        var loc = new kakao.maps.LatLng(result[0].y, result[0].x);
	        map.panTo(loc);

	        var marker = new kakao.maps.Marker({
	          position: loc,
	          image: markerImage,
	          clickable: true
	        });
	        marker.setMap(map);
	        history.push(marker);
	      } else {
	        alert("주소를 찾을 수 없습니다. (status: " + status + ")");
	      }
	    });
	  });
	});
</script>



<div class="container w-450">
<form action="editRegion" method="post">
	<div class="cell center">
		<h1 style="color: var(--subtle);">선호 지역 수정</h1>
	</div>
	<!--  추천모임 활성화 오류시 -->
	<c:if test="${param.error != null}">
		<div class="cell center">
			<h4 style="color:#e17055;">추천기능을 활성화하려면 선호지역을 설정해주세요</h4>
		</div>
	</c:if>
	<div class="cell">
		<label>관심 지역</label><br>
							<div class="cell flex-box flex-fill">
								<select class="search-input ms-10" name="regionType">
									<option value="">선택</option>
									<option>집</option>
									<option>직장</option>
									<option>관심지역</option>
								</select> 
								<div class="cell">
									<input type="text" name="regionName" class="ms-10 search-input address-input" placeholder="주소(시군구/읍면동) 입력 " required>
								</div>
								<div class="cell">
									<button type="button" class="btn btn-common ms-10 address-search-btn">
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
	<div class="cell">
    	<button  class="btn btn-primary w-100 mt-30" type="submit">수정</button>
	</div>
</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>