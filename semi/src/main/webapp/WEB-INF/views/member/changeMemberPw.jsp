<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
$(function(){
	// 비밀번호 형식검사 상태
	var state = {
		memberPwValid: false,
		ok: function() {
			return this.memberPwValid;
		}
	};

	// 비밀번호 입력 시 형식 검사
	$("[name=memberPw]").on("blur keyup", function(){
		var regex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
		var valid = regex.test($(this).val());
		$(this).removeClass("success fail").addClass(valid ? "success" : "fail");
		state.memberPwValid = valid;
	});

	// 폼 전송 전 검사
	$("form").on("submit", function(){
		$("[name=memberPw]").trigger("blur");
		if(!state.ok()){
			alert("비밀번호 형식이 올바르지 않습니다.\n(대/소문자, 숫자, 특수문자를 포함한 8~16자)");
			return false;
		}
	});
});
</script>

<form action="changeMemberPw" method="post" autocomplete="off">
	<input type="hidden" name="memberId" value="${memberId}">
	<input type="hidden" name="certNumber" value="${certNumber}">
	
	<div class="container w-300">

		<div class="cell center">
			<h1 style="color: var(--subtle);">비밀번호 재설정</h1>
		</div>

		<div class="cell">
			<label>비밀번호 <i class="fa-solid fa-asterisk warn"></i></label>
			<input type="password" name="memberPw" class="search-input w-100" placeholder="새 비밀번호 입력">
			<div class="success-feedback">비밀번호가 올바른 형식입니다</div>
			<div class="fail-feedback">대/소문자, 숫자, 특수문자를 포함한 8~16자로 입력하세요</div>
		</div>

		<div class="cell mt-30">
			<button type="submit" class="btn btn-primary w-100">
				<i class="fa-solid fa-lock"></i>
				<span>변경하기</span>
			</button>
		</div>

	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
