<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	$(function() {
		var params = new URLSearchParams(location.search);
		var clubNo = params.get("clubNo");
		$(".btn-join").on("click", function() {
			window.location.href = "/club/home?clubNo=" + clubNo;
		});
	});
</script>
<style>
	.btn-join{
		height:50px;
		width:300px;
		font-size:20px;
	}
</style>
<div class="container">
	<div class="cell center">
		<h1 class="warn">${title}</h1>
	</div>
	<div class="cell center">
		<img src="/images/error/403.jpg" width="300">
	</div>
	
	<div class="cell center mt-30 mb-30">
		<button type="button" class="btn btn-primary btn-join">
		<span>모임에 가입해보세요!</span>
		</button>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
