<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	$(function(){
		  $(".authority-check").on("click", function(e){
		     	var authority = $(this).data("authority")
		    	
		     	if(authority == 'y'){
		     		e.preventDefault();
		     		window.alert("이미 생성권을 보유 중입니다");
		     	}
		     	else{
		     		window.alert("구매가 완료되었습니다!");
		     	}
		     });
	});
</script>

<div class="container w-800">
	<div class="cell center">
		<h1> 소모임 생성권 구매 </h1>
		<h5> 500 P 혹은 상품권 구매시 소모임을 생성하실 수 있습니다 </h5>
	</div>
	<div class="cell center">
		<form action="pointUse" method="post">
		<button type="submit" class="btn btn-accent authority-check" data-authority="${memberDto.memberAuthority}">포인트 교환</button>
		</form>
	</div>
	
	<div class="cell center">
		<form action="purchase" method="post">
		<button type="submit" class="btn btn-accent authority-check" data-authority="${memberDto.memberAuthority}">상품권 구매</button>
		</form>
	</div>


</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
