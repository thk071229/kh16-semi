<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">

<form action="join" method="post" autocomplete="off">
	
	<div>
		<div>
			<h1>회원가입 정보 입력</h1>
		</div>
		<div>
			<label>아이디<i class="fa-solid fa-asterisk"></i></label>
			<br>
			<input type="text" name="memberId" required> 
		</div>
		<div>
			<label>비밀번호<i class="fa-solid fa-asterisk"></i></label>
			<br>
			<input type="password" name="memberPw" required> 
		</div>
		<div>
			<label>비밀번호 확인<i class="fa-solid fa-asterisk"></i></label>
			<br>
			<input type="password" id="password-check" required> 
		</div>
		<div>
			<label>닉네임<i class="fa-solid fa-asterisk"></i></label>
			<br>
			<input type="text" name="memberNickname" required> 
		</div>
		<div>
			<label>이메일</label>
			<br>
			<input type="text" inputmode="email" name="memberEmail" required> 
		</div>
		<div>
			<label>성별</label>
			<br>
			<select name="memberGender">
				<option value="남">남</option>
				<option value="여">여</option>
			</select> 
		</div>
		<div>
			<label>생년월일</label>
			<br>
			<input type="date" name="memberBirth">
		</div>
		<div>
			<button type="submit">회원가입</button>
		</div>
	</div>
	
</form>