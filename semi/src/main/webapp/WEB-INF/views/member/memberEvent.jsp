<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
/* mypage 전용 스타일만 정의 (common.css 중복 제거) */
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

<div class="container">
	
	<div class="section-title"> 참여 정모 목록</div>
  	<div class="table-wrapper">
	<table>
	      <thead>
	        <tr><th>일자</th><th>소모임</th><th>정모 이름</th><th>정모 지역</th><th>참여/정원</th></tr>
	      </thead>
	      <tbody>
	        <c:forEach var="event" items="${eventAttendeeList}">
	          <tr>
				<td>
					<fmt:formatDate value="${event.eventDate}" pattern="M월 d일 H:mm" ></fmt:formatDate>
				</td>
	            <td>
	            	<a href="${pageContext.request.contextPath}/club/home?clubNo=${event.eventClub}" class="member-link">${event.clubName}</a>
	            </td>
				<td>
					<a href="${pageContext.request.contextPath}/event/detail?eventNo=${event.eventNo}" class="member-link">${event.eventTitle}</a>
				</td>
	            <td>${event.eventAddress}</td>
	            <td>${event.eventAttend}/${event.eventMaxPeople}</td>
	          </tr>
	        </c:forEach>
	      </tbody>
	    </table>
  </div>
  <!-- 본인이 등록한 정모 -->
  <div class="section-title">등록한 정모 목록</div>
  <div class="table-wrapper">
  <table>
        <thead>
          <tr><th>일자</th><th>소모임</th><th>정모 이름</th><th>정모 지역</th><th>참여/정원</th></tr>
        </thead>
        <tbody>
          <c:forEach var="event" items="${eventList}">
            <tr>
  			<td>
  				<fmt:formatDate value="${event.eventDate}" pattern="M월 d일 H:mm" ></fmt:formatDate>
  			</td>
              <td>
              	<a href="${pageContext.request.contextPath}/club/home?clubNo=${event.eventClub}" class="member-link">${event.clubName}</a>
              </td>
  			<td>
  				<a href="${pageContext.request.contextPath}/event/detail?eventNo=${event.eventNo}" class="member-link">${event.eventTitle}</a>
  			</td>
              <td>${event.eventAddress}</td>
              <td>${event.eventAttend}/${event.eventMaxPeople}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
	</div>
	
	<div class="cell center mt-50">
  		<a href="mypage" class="btn btn-primary">마이페이지</a>
  	</div>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>