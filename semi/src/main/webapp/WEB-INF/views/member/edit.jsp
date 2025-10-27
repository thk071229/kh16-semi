<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- lightpick cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script> 

<script type="text/javascript">
    // 기존 DTO 값을 자바스크립트 변수로 저장 (null 또는 빈 문자열 처리 고려)
    const ORIGINAL_NICKNAME = "${memberDto.memberNickname}";
    const ORIGINAL_EMAIL = "${memberDto.memberEmail}";
</script>

<script src="/js/edit.js"></script>

<script type="text/javascript">
	$(function(){
        //생년월일 설정
        var picker4 = new Lightpick({
            field: document.querySelector(".picker-4"),
            format: "YYYY-MM-DD",
            firstDay: 7,
            maxDate: moment().subtract(1,'day'),
        });
	});
</script>


<form action="edit" method="post" class="check-form">
	<div class="container w-300">
		
		<div class="cell center">
			<h1 style="color: var(--subtle);">회원 정보 수정</h1>
		</div>
		<!-- 닉네임 -->
		<div class="cell center">
		 	<label>닉네임 <i class="fa-solid fa-asterisk warn"></i></label>
			<input type="text" name="memberNickname" class="search-input w-100" value="${memberDto.memberNickname}" required>
			<div class="success-feedback">멋진 닉네임입니다!</div>
            <div class="fail-feedback">한글 또는 숫자 2~10글자로 작성하세요</div>
            <div class="fail2-feedback">닉네임이 이미 사용중입니다</div>
		</div>
		<!-- 이메일 -->
		<div class="cell center">
			<label>이메일 <i class="fa-solid fa-asterisk warn"></i></label>
                <div class="flex-box" style="width:300px; margin: 0 auto; flex-wrap: wrap; align-items: center; justify-content: center; gap: 10px;">
                    
                    <input type="text" inputmode="email" name="memberEmail" class="search-input" 
                    value="${memberDto.memberEmail}"
                    style="flex-grow: 1; max-width: 250px;" required>
                    
                    <button type="button" class="btn btn-common btn-cert-send" style="margin:0;">
                        <i class="fa-solid fa-paper-plane"></i>
                        <span>인증번호 보내기</span>
                    </button>
                    
                    <div class="success-feedback w-100 mt-10">이메일 인증이 완료되었습니다</div>
                    <div class="fail-feedback w-100 mt-10">올바른 이메일 형식이 아닙니다</div>
                    <div class="fail2-feedback w-100 mt-10">이메일 인증이 완료되지 않았습니다</div>
                </div>
		<!-- 성별 -->
		<div class="cell center">
            	<label>성별</label>
				<select name="memberGender" class="search-input w-100">
					<option value="남">남</option>
					<option value="여">여</option>
				</select> 
       </div>
		<!-- 생년월일 -->
		<div class="cell center">
                <label>생년월일</label>
                <input type="text" name="memberBirth" class="search-input w-100 picker-4">
                <div class="fail-feedback">올바른 날짜 형식이 아닙니다</div>
                <div class="fail2-feedback">미래의 날짜는 설정할 수 없습니다</div>
            </div>
		<div class="cell center">
			<span>
				비밀번호를 입력해주세요
			</span>
			<br>
			<input type="password" name="memberPw" class="search-input w-100" placeholder="password" required>
		</div>
		<div>
			<button type="submit" class="btn btn-accent">
				정보 변경
			</button>
		</div>
		
		<c:if test="${param.error != null}">
			<div class="cell center">
				<h3 style="color: #e17055;">비밀번호가 일치하지 않습니다</h3>
			</div>
		</c:if>
		
	</div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>