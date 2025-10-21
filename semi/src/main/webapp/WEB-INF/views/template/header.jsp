<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 디자인 파일 불러오기 --%>
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<%-- font-awesome css --%>
<link rel ="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
<a href = "/">
<img src = "https://dummyimage.com/95x30/000/fff&text=Main+logo">
</a>
<form action = "#" method = "post" autocomplete="off">
<button>
	<span>강남구</span>
</button>
<input type = "text" name = "category_name" placeholder = "찾고 싶은 모임을 검색해보세요! (ex 러닝, 독서)">
<button type = "submit">
	<i class="fa-solid fa-magnifying-glass"></i>
</button>
</form>
<h1>헤더</h1>
<!-- 상단 메뉴 -->
<jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>	

<!-- 사이드 메뉴 (클릭하면 나오도록) 추후 구현 -->
<%-- <jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>	 --%>