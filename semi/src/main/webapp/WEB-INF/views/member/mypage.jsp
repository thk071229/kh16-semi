<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>

	<div>
		<h1>${memberDto.memberId}님의 정보</h1>
	</div>
	<div>
		<img src="/member/profile?memberId=${memberDto.memberId}" width="200" height="200">
		<label>변경</label>
		<input type="file">
	</div>
	<div>
		<table border="1" width="500">
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
	<div>
		<h2>선호하는 지역</h2>
		<table border="1" width="500">
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
		<a href="editRegion">선호지역 수정</a>
	</div>
	
	<!-- 선호 카테고리 목록 -->
	<div>
		<h2>선호하는 카테고리</h2>
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
		<a href="editCategory">카테고리 수정</a>
	</div>
	
	<!-- 가입한 소모임 목록  -->
	<div>
		<h2>${memberDto.memberId}님의 가입 모임</h2>
	</div>
	<div>
		<table border="1" width="500">
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

	<div>
		<a href="password">비밀번호 변경</a>
	</div>
	<div>
		<a href="edit">내 정보 수정</a>
	</div>
	<div>
		<a href="drop">회원 탈퇴</a>
	</div>

</div>