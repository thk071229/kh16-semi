<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(function() {
    // "찾기" 버튼 클릭 시 로딩 상태 적용
    $("form").on("submit", function(e) {
        var $btn = $(this).find("button[type=submit]");
        var $icon = $btn.find("i");
        var $text = $btn.find("span");

        // 이미 전송 중이면 다시 클릭 방지
        if ($btn.data("sending")) {
            e.preventDefault();
            return false;
        }

        $btn.data("sending", true);
        $btn.prop("disabled", true);
        $icon.removeClass("fa-magnifying-glass").addClass("fa-spinner fa-spin");
        $text.text("전송 중...");

        // 폼이 실제 서버로 전송되면 페이지가 리로드되므로, 여기서 별도 복구 필요 없음
        // 단, 예외적으로 JS로 막히는 경우 대비해 타임아웃으로 복구 처리
        setTimeout(function() {
            $btn.prop("disabled", false);
            $icon.removeClass("fa-spinner fa-spin").addClass("fa-magnifying-glass");
            $text.text("찾기");
            $btn.data("sending", false);
        }, 10000); // 10초 후 자동 복구 (예외상황 대비)
    });
});
</script>

<form action="findMemberPw" method="post" autocomplete="off">
<div class="container w-300">

	<div class="cell center">
		<h1 style="color: var(--subtle);">비밀번호 찾기</h1>
	</div>

	<div class="cell">
		<label>아이디  <i class="fa-solid fa-asterisk warn"></i></label>
		<input type="text" name="memberId" class="search-input w-100" required>
	</div>

	<div class="cell">
		<label>닉네임  <i class="fa-solid fa-asterisk warn"></i></label>
		<input type="text" name="memberNickname" class="search-input w-100" required>
	</div>

	<div class="cell">
		<label>이메일 <i class="fa-solid fa-asterisk warn"></i></label>
		<input type="email" name="memberEmail" class="search-input w-100" required>
	</div>

	<div class="cell mt-30">
		<button type="submit" class="btn btn-primary w-100">
			<i class="fa-solid fa-magnifying-glass"></i>
			<span>찾기</span>
		</button>
	</div>

</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
