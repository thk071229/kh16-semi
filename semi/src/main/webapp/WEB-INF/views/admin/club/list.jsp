<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
/* club-list.jsp 전용 스타일 */

.page-header {
  text-align: center;
  margin: 30px 0 40px;
  color: var(--ink);
}

/* 검색 박스 */
.search-box {
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 20px;
  max-width: 600px;
  margin: 0 auto 40px;
  display: flex;
  gap: 12px;
  justify-content: center;
  flex-wrap: wrap;
}

.search-box select,
.search-box input[type="text"] {
  padding: 8px 12px;
  border-radius: 8px;
  border: 1px solid #ccc;
  font-size: 15px;
}

.search-box button {
  padding: 8px 16px;
  border-radius: 8px;
  background: var(--primary);
  color: #fff;
  font-weight: 600;
  border: none;
  cursor: pointer;
  transition: background 0.2s ease;
}
.search-box button:hover {
  background: #69b894;
}

/* 테이블 */
.table-wrapper {
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 20px;
  overflow-x: auto;
}

.member-link {
  color: var(--primary);
  font-weight: 700;
  text-decoration: none;
  transition: color 0.2s ease;
}
.member-link:hover {
  color: #69b894;
  text-decoration: underline;
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

/* 삭제 버튼 */
.delete-link {
  display: inline-block;
  padding: 6px 10px;
  border-radius: 6px;
  background: #ff6b6b;
  color: #fff;
  font-weight: 600;
  text-decoration: none;
  transition: background 0.2s ease, transform 0.2s ease;
}
.delete-link:hover {
  background: #e84141;
  transform: translateY(-2px);
}

/* 결과 정보 */
.result-info {
  text-align: center;
  margin-top: 20px;
  color: var(--subtle);
  font-size: 14px;
}

/* 반응형 */
@media (max-width: 768px) {
  .search-box {
    flex-direction: column;
    align-items: stretch;
  }
}
</style>

<div class="container">

  <h1 class="page-header">소모임 목록</h1>

  <!-- 검색 -->
  <form action="list" method="get" class="search-box">
    <select name="column">
      <option value="club_no" ${param.column == "club_no" ? "selected" : ""}>모임 PK</option>
      <option value="club_name" ${param.column == "club_name" ? "selected" : ""}>모임 이름</option>
      <option value="category_name" ${param.column == "category_name" ? "selected" : ""}>카테고리</option>
      <option value="region_name" ${param.column == "region_name" ? "selected" : ""}>활동 지역</option>
    </select>
    <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력" required>
    <button type="submit">검색</button>
  </form>

  <!-- 목록 -->
  <c:choose>
    <c:when test="${empty clubList}">
      <div class="result-info">표시할 결과가 없습니다.</div>
    </c:when>
    <c:otherwise>
      <div class="table-wrapper">
        <table class="table">
          <thead>
            <tr>
              <th>번호</th>
              <th>모임 이름</th>
              <th>카테고리</th>
              <th>지역</th>
              <th>관리</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="clubListVO" items="${clubList}" varStatus="status">
              <tr style="${status.count % 2 == 0 ? 'background-color:#f8f9fa;' : ''}">
                <td>${clubListVO.clubNo}</td>
                <td>
                	<a href="${pageContext.request.contextPath}/club/home?clubNo=${clubListVO.clubNo}" class="member-link">
               		 ${clubListVO.clubName}
                	</a>
                </td>
                <td>${clubListVO.categoryName}</td>
                <td>${clubListVO.regionName}</td>
                <td>
                  <a href="drop?clubNo=${clubListVO.clubNo}" class="delete-link">모임 삭제</a>
                </td>
              </tr>
            </c:forEach>
          </tbody>
          <tfoot>
            <c:if test="${pageVO.search}">
              <tr><td colspan="5" class="result-info">
                검색결과: ${pageVO.begin} - ${pageVO.end} / ${pageVO.dataCount}개
              </td></tr>
              <tr><td colspan="5" class="result-info">
                페이지: ${pageVO.page} / ${pageVO.totalPage}
              </td></tr>
            </c:if>

            <c:if test="${!pageVO.search}">
              <tr><td colspan="5" class="result-info">
                전체 목록: 총 ${pageVO.dataCount}개
              </td></tr>
              <tr><td colspan="5" class="result-info">
                페이지: ${pageVO.page} / ${pageVO.totalPage}
              </td></tr>
            </c:if>
          </tfoot>
        </table>
      </div>

      <!-- 페이지 네비게이터 -->
      <div style="margin-top:20px; text-align:center;">
        <jsp:include page="/WEB-INF/views/template/pagination-num.jsp"></jsp:include>
      </div>
    </c:otherwise>
  </c:choose>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
