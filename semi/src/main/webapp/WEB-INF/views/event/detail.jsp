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
<!-- -------------------------------------- -->	
<div class="container w-800">

<!-- -hidden 으로 정보 전달--- -->	
<input type="hidden" value="${eventDto.eventRegionX}" class="regionX" readonly>
<input type="hidden" value="${eventDto.eventRegionY}" class="regionY" readonly>


    <div class="cell">
    	<h1>
    		정모상세 : ${eventDto.eventTitle}
    		<c:if test="${eventDto.eventEtime != null}">
				<span style="font-size:18;">(수정 :
					<fmt:formatDate value="${eventDto.eventEtime}" pattern="M/d H:mm" ></fmt:formatDate>
				 )</span>
			</c:if>
			</h1>
			<div class="cell">
    	<label>작성일</label>
    	<fmt:formatDate value="${eventDto.eventWtime}" pattern="M월 d일 H:mm" ></fmt:formatDate>
    </div>
		
    </div>
    
    <div class="cell">
     	<hr>
    </div>

    <div class="cell">
    	<i class="fa-solid fa-calendar"></i>
    	<fmt:formatDate value="${eventDto.eventDate}" pattern="y년 M월 d일 H:mm" ></fmt:formatDate>
    </div>
     <div class="cell">
   		내용 : ${eventDto.eventContent}
    </div>
	<div class="cell">
		<label>상세 위치</label>
		<div class="kakao-map w-100"></div>
	</div>
    
    <div class="cell">
     	<hr>
    </div>
    
    <div class="cell">
    	<a class="btn btn-ghost" href="list?clubNo=${eventDto.eventClub}">목록</a>
    	<a class="btn btn-primary" href="add?clubNo=${eventDto.eventClub}">등록</a>
    	<a class="btn btn-accent" href="edit?eventNo=${eventDto.eventNo}">수정</a>
    	<a class="btn btn-accent" href="delete?eventNo=${eventDto.eventNo}">삭제</a>
    </div>
    
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	