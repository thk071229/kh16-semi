<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- header -->
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>	

<style>
/* category-list.jsp 전용 스타일 */

.page-header {
  text-align: center;
  margin: 30px 0 40px;
  color: var(--ink);
}

/* 신규 추가 버튼 */
.add-btn {
  display: inline-block;
  background: var(--primary);
  color: #fff;
  font-weight: 600;
  padding: 10px 16px;
  border-radius: 8px;
  text-decoration: none;
  box-shadow: 0 6px 12px rgba(127,200,169,0.15);
  transition: background 0.2s ease, transform 0.2s ease;
}
.add-btn:hover {
  background: var(--primary-600);
  transform: translateY(-2px);
}

/* 테이블 */
.table-wrapper {
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 20px;
  margin-top: 25px;
  overflow-x: auto;
}

.table {
  width: 100%;
  border-collapse: collapse;
  font-size: 15px;
}

.table th, .table td {
  border: 1px solid #dcdcdc;
  padding: 10px 12px;
  text-align: center;
}

.table th {
  background: var(--muted);
  color: var(--ink);
  font-weight: 700;
}

.table tr:hover {
  background: rgba(127,200,169,0.08);
}
</style>

<div class="container">
	
	<div class="cell">
		<h1 class="page-header">관리자 페이지</h1>
	</div>
	
	<div class="table-wrapper">
		<table class="table">
			<thead>
				<tr>
					<th>항목</th>
					<th>기능</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>회원</td>
					<td><a href="${pageContext.request.contextPath}/admin/member/list" class="member-link">회원 검색</a></td>
				</tr>
				<tr>
					<td>모임</td>
					<td><a href="${pageContext.request.contextPath}/admin/club/list" class="member-link">소모임 목록</a></td>
				</tr>
				<tr>
					<td>카테고리</td>
					<td><a href="${pageContext.request.contextPath}/admin/category/list" class="member-link">카테고리 목록</a></td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- 차트 영역 -->
	<jsp:include page="/WEB-INF/views/admin/stat/chart.jsp"></jsp:include>	
		
</div>
<!-- footer -->
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	