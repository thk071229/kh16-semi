<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="edit" method="post">
<input type="hidden" name="memberId" value="${memberDto.memberId}">
<div class="container w-300">

	<div class="cell center">
		<h1 style="color: var(--subtle);">회원 정보 수정</h1>
	</div>
	<div class="cell">
		<label>닉네임</label>
		<input type="text" name="memberNickname" value="${memberDto.memberNickname}" required class="search-input w-100">
	</div>
	<div class="cell">
		<label>이메일</label>
		<input type="text" name="memberEmail" value="${memberDto.memberEmail}" inputmode="email" required class="search-input w-100">
	</div>
	<div class="cell">
		<label>생년월일</label>
		<input type="date" name="memberBirth" value="${memberDto.memberBirth}" class="search-input w-100">
	</div>
	<div class="cell">
		<label>회원 등급</label>
		<select name="memberLevel" class="search-input w-100">
			<option ${memberDto.memberLevel == '일반회원' ? 'selected' : '' }>일반회원</option>
			<!--<option ${memberDto.memberLevel == '' ? 'selected' : '' }></option> -->
		</select>
	</div>
	<div class="cell">
		<label>포인트</label>
		<input type="text" name="memberPoint" value="${memberDto.memberPoint}" inputmode="numeric" required class="search-input w-100">
	</div>
	<div class="cell">
		<button class="btn btn-primary w-100" type="submit">수정하기</button>
	</div>

</div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>