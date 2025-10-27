<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- header -->
<jsp:include page="/WEB-INF/views/template/main-header.jsp"></jsp:include>	
<div class = "container">
<hr>
<h1>메인 페이지</h1>
<h2>소모임 - 우리동네 취미 모임</h2>
<h4>소개글</h4>
<label>
<i class="fa-solid fa-location-dot"></i>
서울시 강남구(header에 있는 button-span value 불러오기) 근처 모임
</label>
<!-- 추후 table로 구현  -->
<h4>활동이 활발한 모임</h4>
<img src = "https://dummyimage.com/600x300/000/fff&text=club_1">
<h4><button type = "button">더보기</button></h4>
<h4>내 근처에서 시작되는 정모</h4>
<img src = "https://dummyimage.com/600x300/000/fff&text=club_2">
<h4><button type = "button">더보기</button></h4>
<h4>카테고리 별 모임</h4>
<img src = "https://dummyimage.com/600x300/000/fff&text=club_3">
<h4><button type = "button">더보기</button></h4>
<hr>
</div>
<!-- footer -->
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	