<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
/* mypage 전용 스타일만 정의 (common.css 중복 제거) */

/* 프로필 섹션 */
.profile-section {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 40px;
  margin-top: 30px;
}

.profile-card {
  flex: 0 0 240px;
  text-align: center;
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 20px;
}

.profile-wrapper {
  width: 180px;
  height: 180px;
  border-radius: 50%;
  overflow: hidden;
  margin: 0 auto 10px auto;
  position: relative;
}
.profile-wrapper > img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.profile-wrapper > label {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background-color: rgba(0, 0, 0, 0.4);
  color: white;
  display: none;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  cursor: pointer;
}
.profile-wrapper:hover > label {
  display: flex;
}

.profile-info {
  flex: 1;
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 20px;
}
.profile-info table {
  width: 100%;
  border-collapse: collapse;
}
.profile-info th, .profile-info td {
  border: 1px solid #dcdcdc;
  padding: 8px;
  text-align: center;
}
.profile-info th {
  background: var(--muted);
  color: var(--ink);
  font-weight: 600;
}

.section-title {
  margin-top: 50px;
  font-size: 20px;
  font-weight: 700;
  color: var(--ink);
  text-align: center;
}

.table-wrapper {
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 16px;
  margin-top: 15px;
}
.table-wrapper table {
  width: 100%;
  border-collapse: collapse;
}
.table-wrapper th, .table-wrapper td {
  border: 1px solid #dcdcdc;
  padding: 10px;
  text-align: center;
}
.table-wrapper th {
  background: var(--muted);
  color: var(--ink);
}
.table-wrapper tr:hover {
  background: rgba(127,200,169,0.1);
}

.action-buttons {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin: 20px 0;
}

@media (max-width: 768px) {
  .profile-section {
    flex-direction: column;
    align-items: center;
  }
  .profile-card, .profile-info {
    width: 100%;
  }
}

</style>

<div class="container">
  <div class="cell center">
    <h2 style="color: var(--subtle);">${memberDto.memberId}님의 정보</h2>
  </div>

  <div class="profile-section">
    <!-- 프로필 -->
    <div class="profile-card">
      <div class="profile-wrapper">
        <img src="/member/profile?memberId=${memberDto.memberId}" alt="프로필 이미지">
        <label for="profile-input">변경</label>
        <input type="file" id="profile-input" style="display:none">
      </div>
      <label class="profile-delete-btn red mt-10" style="cursor:pointer;">
        <i class="fa-solid fa-xmark"></i> 삭제
      </label>
    </div>

    <!-- 프로필 정보 -->
    <div class="profile-info">
      <table>
        <tr><th>닉네임</th><td>${memberDto.memberNickname}</td></tr>
        <tr><th>이메일</th><td>${memberDto.memberEmail}</td></tr>
        <tr><th>성별</th><td>${memberDto.memberGender}</td></tr>
        <tr><th>생년월일</th><td><fmt:formatDate value="${memberDto.memberBirth}" pattern="yyyy-MM-dd"/></td></tr>
        <tr><th>포인트</th><td>${memberDto.memberPoint} 포인트</td></tr>
        <tr><th>가입일</th><td><fmt:formatDate value="${memberDto.memberJoin}" pattern="y년 M월 d일 H시 m분 s초"/></td></tr>
      </table>
    </div>
  </div>

  <!-- 선호 지역 -->
  <div class="section-title">선호하는 지역</div>
  <div class="table-wrapper">
    <table>
      <thead>
        <tr><th style="width:30%">관심지 종류</th><th>주소</th></tr>
      </thead>
      <tbody>
        <c:forEach var="r" items="${regionList}">
          <tr><td>${r.regionType}</td><td>${r.regionName}</td></tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
  <div class="action-buttons">
    <a href="editRegion" class="btn btn-common">선호지역 수정</a>
  </div>

  <!-- 선호 카테고리 -->
  <div class="section-title">선호하는 카테고리</div>
  <div class="table-wrapper">
    <table>
      <thead><tr><th>카테고리 이름</th></tr></thead>
      <tbody>
        <c:forEach var="c" items="${categoryList}">
          <tr><td>${c.categoryName}</td></tr>
        </c:forEach>
      </tbody>
    </table>
  </div>
  <div class="action-buttons">
    <a href="editCategory" class="btn btn-common">카테고리 수정</a>
  </div>

  <!-- 가입한 소모임 -->
  <div class="section-title">${memberDto.memberId}님의 가입 모임</div>
  <div class="table-wrapper">
    <table>
      <thead>
        <tr><th>소모임 이름</th><th>활동 지역</th><th>카테고리</th></tr>
      </thead>
      <tbody>
        <c:forEach var="club" items="${clubList}">
          <tr>
            <td>
            	<a href="/club/home?clubNo=${club.clubNo}" class="member-link">${club.clubName}</a>
            </td>
            <td>${club.regionName}</td>
            <td>${club.categoryName}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

  <div class="action-buttons">
    <a href="password" class="btn btn-common">비밀번호 변경</a>
    <a href="edit" class="btn btn-common">내 정보 수정</a>
    <a href="drop" class="btn btn-ghost">회원 탈퇴</a>
  </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
