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
.container::after {
    content: "";
    display: block;
    clear: both;
}


.event-box{
	display: flex;               /* 내부 레이아웃 유지 */
	flex-wrap : wrap;
	flex-direction: row;         /* 기본 행 배치 */
	float: left;                 /* 카드 좌측 정렬, 줄 바꿈 허용 */
	width : 48%;
	height : 150px;
	box-sizing: border-box;      /* padding, border 포함 폭 계산 */
}
</style>

<!-- 프로필 변경 코드 -->
<script type="text/javascript">
	$(function(){
		//이미지의 최초 주소를 불러와서 저장한다
		var origin = $(".image-profile").attr("src");
		
		//$(".profile-change-btn").on("click", function(){
		$("#profile-input").on("input", function(){
			//선택된 파일을 구해와서
			//var list = document.querySelector(".profile-input").files;//JS
			var list = $("#profile-input").prop("files");//jQuery
			if(list.length == 0) return;
			
			//비동기 통신으로 전송
			//- ajax도 form처럼 아무말 안하면 urlencoded 방식으로 전송(key=value)
			//- 파일은 multipart 방식으로 보내야 하기 때문에 기본 설정을 제거
			//- processData, contentType을 제거하고 FormData를 생성해서 전달
			var form = new FormData();//<form> 역할
			//form.append("이름", 값);
			form.append("attach", list[0]);
			
			$.ajax({
				processData : false,//multipart로 보내기 위해 미리 정의된 전처리 제거
				contentType : false,//multipart로 보내기 위해 미리 정의된 MIME 타입을 제거
				url:contextPath+"/rest/member/profile",
				method:"post",
				data: form,
				success:function(response){
					//origin에 시간을 붙여서 src를 재설정
					//(중요) 브라우저의 캐싱을 우회하기 위하여 시간을 파라미터로 첨부
					//var newOrigin = origin + "&t=" + new Date().getTime();
					//$(".image-profile").attr("src", newOrigin);
					var newOrigin = "/member/profile?memberId=${memberDto.memberId}&t=" + new Date().getTime();
    				$(".image-profile").attr("src", newOrigin);
   					origin = newOrigin; // origin도 갱신
				}
			});
		});
		
		//삭제 버튼을 누르면 물어본 뒤 확인을 눌렀을 경우 삭제 진행
		$(".profile-delete-btn").on("click", function(){
			var choice = window.confirm("정말 삭제하시겠습니까?\n삭제 후 복구할 수 없습니다");
			if(choice == false) return;
			
			$.ajax({
				url:"/rest/member/delete",
				method:"post",
				success:function(){
					var newOrigin = origin + "&t=" + new Date().getTime();
					$(".image-profile").attr("src", newOrigin);
				}
			});
		});
	});
</script>

<div class="container">
  <div class="cell center">
    <h2 style="color: var(--subtle);">${memberDto.memberId}님의 정보</h2>
  </div>

  <div class="profile-section">
    <!-- 프로필 -->
    <div class="profile-card">
      <div class="profile-wrapper">
        <img src="${pageContext.request.contextPath}/member/profile?memberId=${memberDto.memberId}" alt="프로필 이미지"  class="image-profile">
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
        <tr>
        <th>소모임 생성권</th>
        <c:choose>
        	<c:when test="${memberDto.memberAuthority=='y'}">
		        <td>o</td>
        	</c:when>
        	<c:otherwise>
        		<td>x</td>
        	</c:otherwise>
        </c:choose>
        </tr>
        <tr><th>이메일</th><td>${memberDto.memberEmail}</td></tr>
        <tr><th>성별</th><td>${memberDto.memberGender}</td></tr>
        <tr><th>생년월일</th><td><fmt:formatDate value="${memberDto.memberBirth}" pattern="yyyy-MM-dd"/></td></tr>
        <tr><th>포인트</th><td><jsp:include page="/WEB-INF/views/template/pointIcon.jsp"></jsp:include> ${memberDto.memberPoint} 포인트</td></tr>
        <tr><th>가입일</th><td><fmt:formatDate value="${memberDto.memberJoin}" pattern="y년 M월 d일 H시 m분 s초"/></td></tr>
      </table>
    </div>
  </div>

  <div class="action-buttons mt-50">
    <a href="password" class="btn btn-common">비밀번호 변경</a>
    <a href="edit" class="btn btn-common">내 정보 수정</a>
    <a href="drop" class="btn btn-ghost">회원 탈퇴</a>
  </div>

  <!-- 선호 지역 -->
  <div class="section-title mt-50">활동 지역</div>
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
  <div class="action-buttons mt-30">
    <a href="editRegion" class="btn btn-common">선호지역 수정</a>
  </div>

  <!-- 선호 카테고리 -->
  <div class="section-title mt-50">선호하는 카테고리</div>
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
  <div class="action-buttons mt-30">
    <a href="editCategory" class="btn btn-common">카테고리 수정</a>
  </div>

  <!-- 가입한 소모임 -->
  <div class="section-title">${memberDto.memberNickname}님의 소모임</div>
   <div class="cell center mt-30">
  	<a href="memberClub" class="btn btn-primary">가입한 소모임</a>
  	<a href="memberLikeClub" class="btn btn-primary ms-10">찜한 소모임</a>
  </div>
  

  <div class="action-buttons mt-50">
  	<a href="memberEvent" class="btn btn-primary">참여한 정모</a>
  	<a href="memberBoard" class="btn btn-primary">작성한 게시글</a>
  	<a href="memberLike" class="btn btn-primary">좋아요 한 게시글</a>
  </div>
  
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
