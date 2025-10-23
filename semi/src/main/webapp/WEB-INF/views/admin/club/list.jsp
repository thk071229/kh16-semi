<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	
	<div>
		<h1>소모임 목록</h1>
	</div>
	
	<!-- 🔍 검색 폼 -->
	<form action="list" method="get">
		<div>
			<select name="column">
				<option value="club_no" ${param.column == "club_no" ? "selected" : ""}>모임 pk</option>
				<option value="club_name" ${param.column == "club_name" ? "selected" : ""}>모임 이름</option>
				<option value="category_name" ${param.column == "category_name" ? "selected" : ""}>카테고리</option>
				<option value="region_name" ${param.column == "region_name" ? "selected" : ""}>활동 지역</option>
			</select>
			<input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력" required>
			<button type="submit">검색</button>
		</div>
	</form>
	
	<!-- 🔽 목록 또는 검색 결과 -->
	<c:choose>
		<c:when test="${empty clubList}">
			<div>
				<h3>표시할 결과가 없습니다.</h3>
			</div>
		</c:when>
		<c:otherwise>
			<div>
				<table class="table table-hover table-border" width="100%">
					<thead>
						<tr>
							<th>번호</th>
							<th>모임 이름</th>
							<th>카테고리</th>
							<th>지역</th>
						</tr>
					</thead>
					<tbody align="center">
						<c:forEach var="clubListVO" items="${clubList}" varStatus="status">
							<tr bgcolor="${status.count % 2 == 0 ? '#f8f9fa' : ''}">
								<td>${clubListVO.clubNo}</td>
								<td>${clubListVO.clubName}</td>
								<td>${clubListVO.categoryName}</td>
								<td>${clubListVO.regionName}</td>
								<th>
									<a href="drop?clubNo=${clubListVO.clubNo}">모임삭제</a>
								</th>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<c:if test="${pageVO.search}">
					        <tr>
					            <td colspan="6">
					                검색결과 : ${pageVO.begin} - ${pageVO.end} / ${pageVO.dataCount}개
					            </td>
					        </tr>
					        <tr>
					            <td colspan="6">
					                페이지 : ${pageVO.page} / ${pageVO.totalPage}
					            </td>
					        </tr>
					    </c:if>
					
					    <c:if test="${!pageVO.search}">
					        <tr>
					            <td colspan="6">
					                전체 목록 : 총 ${pageVO.dataCount}개
					            </td>
					        </tr>
					        <tr>
					            <td colspan="6">
					                페이지 : ${pageVO.page} / ${pageVO.totalPage}
					            </td>
					        </tr>
					    </c:if>
					</tfoot>
				</table>
			</div>

			<!-- 페이지 네비게이터 -->
			<div>
				<jsp:include page="/WEB-INF/views/template/pagination-num.jsp"></jsp:include>
			</div>
		</c:otherwise>
	</c:choose>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>