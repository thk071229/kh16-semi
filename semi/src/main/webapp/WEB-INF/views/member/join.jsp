<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">

<form action="join" method="post" enctype="multipart/form-data" autocomplete="off">
	
	<div>
	
		<div>
			<h1>회원가입 정보 입력</h1>
		</div>
		<!-- 아이디 -->
		<div>
			<label>아이디<i class="fa-solid fa-asterisk"></i></label>
			<br>
			<input type="text" name="memberId" required> 
		</div>
		<!-- 비밀번호 -->
		<div>
			<label>비밀번호<i class="fa-solid fa-asterisk"></i></label>
			<br>
			<input type="password" name="memberPw" required> 
		</div>
		<!-- 비밀번호 확인 -->
		<div>
			<label>비밀번호 확인<i class="fa-solid fa-asterisk"></i></label>
			<br>
			<input type="password" id="password-check" required> 
		</div>
		<!-- 닉네임 -->
		<div>
			<label>닉네임<i class="fa-solid fa-asterisk"></i></label>
			<br>
			<input type="text" name="memberNickname" required> 
		</div>
		<!-- 이메일 -->
		<div>
			<label>이메일</label>
			<br>
			<input type="text" inputmode="email" name="memberEmail" required> 
		</div>
		<!-- 성별 -->
		<div>
			<label>성별</label>
			<br>
			<select name="memberGender">
				<option value="남">남</option>
				<option value="여">여</option>
			</select> 
		</div>
		<!-- 생년월일 -->
		<div>
			<label>생년월일</label>
			<br>
			<input type="date" name="memberBirth">
		</div>
		<!-- 프로필 이미지 -->
		<div>
			<label>프로필 사진</label>
			<br>
			<input type="file" name="attach" accept="image/*">
		</div>
		<!-- 회원가입 -->
		<div>
			<button type="submit">회원가입</button>
		</div>
		
	</div>
	
</form>