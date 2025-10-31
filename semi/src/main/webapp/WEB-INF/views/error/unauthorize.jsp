<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<div class="cell center">
		<h2 class="warn">${title}</h2>
	</div>
	<div class="cell center ">
		<h3><a href="/member/login" class="link">로그인</a></h3>
	</div>
	<div class="cell center">
		<img src="/images/error/401.jpg" width="300">
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

