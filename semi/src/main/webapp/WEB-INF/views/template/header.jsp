<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 모든 jsp에서 사용 가능한 css파일과 cdn 파일을 header에 등록 --%>
<%-- 디자인 파일 추가 --%>
<link rel ="stylesheet" type="text/css" href="/css/common.css">
<%-- font-awesome css --%>
<link rel ="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
<%-- jQuery cdn --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%-- momentjs cdn --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>

<div class="container w-100">
<div class="cell flex-box">
<!-- 로고 이미지 -->
<div class="cell">
<a href = "/">
<img src = "https://dummyimage.com/100x50/000/fff&text=Main+logo">
</a>
</div>
<!-- 검색 -->
<div class="cell right flex-fill">
<form action = "#" method = "post" autocomplete="off">
<button>
	<span>강남구</span>
</button>
<input type = "text" name = "category_name" placeholder = "찾고 싶은 모임을 검색해보세요! (ex 러닝, 독서)">
<button type = "submit">
	<i class="fa-solid fa-magnifying-glass"></i>
</button>
</form>
</div>
</div>
<!-- 상단 메뉴 -->
<jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>	
</div>

<!-- 사이드 메뉴 (클릭하면 나오도록) 추후 구현 -->
<%-- <jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>	 --%>