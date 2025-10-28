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
	
	<div class="section-title">${memberDto.memberId}님의 작성 게시물 목록</div>
  	<div class="table-wrapper">
  		<table>
  			<thead>
  				<tr>
  					<th>제목</th>
  					<th>소모임 이름</th>
  					<th>작성시각</th>
  					<th>댓글 수</th>
  					<th>좋아요</th>
  				</tr>
  			</thead>
  			<tbody>
  			<c:forEach var="boardListVO" items="${boardList}" varStatus="status">
  				<tr>
  					<td>
	  					 <a href="/board/detail?boardNo=${boardListVO.boardNo}" class="member-link">
	                    ${boardListVO.boardTitle}
	                  	</a>
                  	</td>
                  	<td>
                  		${boardListVO.clubName}
                  	</td>
                  	<td>
                  		${boardListVO.boardWriteTime}
                  	</td>
                  	<td>
                  		${boardListVO.boardComment}
                  	</td>
                  	<td>
                  		${boardListVO.boardLike}
                  	</td>
  				</tr>
  			</c:forEach>	
  			</tbody>
  		</table>
  	</div>
  	<jsp:include page="/WEB-INF/views/template/pagination-num.jsp"></jsp:include>
	<div class="cell center mt-30">
  		<a href="mypage" class="btn btn-primary">마이페이지</a>
  	</div>
	
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>