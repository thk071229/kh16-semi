<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.profile-wrapper {
		width:200px;
		height:200px;
		position: relative;
		border-radius: 50%;
		overflow: hidden;
	}
	.profile-wrapper > img {
		width:100%;
		height:100%;
	}
	.profile-wrapper > label {
		position:absolute;
		top:0; 		left:0; 		right:0; 		bottom:0;
		background-color: rgba(0, 0, 0, 0.3);
		color:white;
		display: none;
		cursor:pointer;
	}
	.profile-wrapper:hover > label {
		display:flex;
	}
</style>

<div class="container">

	<div class="title">
		${memberDto.memberId}님의 정보
	</div>
	
	<!-- 프로필 이미지 -->
	<div class="profile-wrapper">
		<img class="image-profile" src="/member/profile?memberId=${memberDto.memberId}" width="200" height="200">
		<label for="profile-input" class="flex-box flex-center">변경</label>
		<input type="file" id="profile-input" style="display:none">
	</div>
	<label class="profile-delete-btn red">
		<i class="fa-solid fa-xmark"></i>
		<span>삭제</span>
	</label>
	
	<div class="cell">
		<table class="table table-border w-100">
			<tr>
				<th>닉네임</th>
				<td>${memberDto.memberNickname}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${memberDto.memberEmail}</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>${memberDto.memberGender}</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>
					<fmt:formatDate value="${memberDto.memberBirth}" pattern="yyyy-MM-dd"/>
				</td>
			</tr>
			<tr>
				<th>포인트</th>
				<td>${memberDto.memberPoint}포인트</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td>
					<fmt:formatDate value="${memberDto.memberJoin}" pattern="y년 M월 d일 H시 m분 s초"/>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 선호 지역 목록 -->
	<div class="title">
		선호하는 지역
	</div>
	<div class="cell">
		<table class="table table-border w-100">
			<thead>
				<tr>
					<th>관심지 종류</th>
					<th>주소</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="memberRegionListVO" items="${regionList}">
				<tr>
					<td>
					${memberRegionListVO.regionType}
					</td>
					<td>
					${memberRegionListVO.regionName}
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div>
		<a href="editRegion" class="btn btn-common">선호지역 수정</a>
	</div>
	
	<!-- 선호 카테고리 목록 -->
	<div class="title">
		선호하는 카테고리
	</div>
	<div class="table table-border w-100">
		<table border="1" width="500">
			<tr>
				<th>카테고리 이름</th>
			</tr>
			<c:forEach var="memberCategoryVO" items="${categoryList}">
				<tr>
					<td>
					${memberCategoryVO.categoryName}
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div>
		<a href="editCategory" class="btn btn-common">카테고리 수정</a>
	</div>
	
	<!-- 가입한 소모임 목록  -->
	<div class="title">
		<h2>${memberDto.memberId}님의 가입 모임</h2>
	</div>
	<div class="cell">
		<table class="table table-border w-100">
			<tr>
				<th>소모임 이름</th>
				<th>활동 지역</th>
				<th>카테고리</th>
			</tr>
			<c:forEach var="memberClubListVO" items="${clubList}">
				<tr>
					<td>
						${memberClubListVO.clubName}
						<%-- 
						<a href="/club/detail?clubNo=${memberClubListVO.clubNo}">
							${memberClubListVO.clubName}
						</a>
						--%>
					</td>
					<td>${memberClubListVO.regionName}</td>
					<td>${memberClubListVO.categoryName}</td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<div class="cell">
		<a href="password" class="btn btn-common">비밀번호 변경</a>
	</div>
	<div class="cell">
		<a href="edit" class="btn btn-common">내 정보 수정</a>
	</div>
	<div>
		<a href="drop">회원 탈퇴</a>
	</div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>