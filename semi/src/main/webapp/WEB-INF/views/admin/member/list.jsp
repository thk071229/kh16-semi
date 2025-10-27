<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
/* member-list.jsp 전용 스타일 */

.page-header {
  text-align: center;
  margin: 30px 0 40px;
  color: var(--ink);
}

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

/* 검색결과 테이블 */
.table-wrapper {
  background: var(--surface);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 20px;
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

/* 페이징 및 결과 텍스트 */
.result-info {
  text-align: center;
  margin-top: 20px;
  color: var(--subtle);
  font-size: 14px;
}

@media (max-width: 768px) {
  .search-box {
    flex-direction: column;
    align-items: stretch;
  }
}
</style>

<div class="container">

  <h1 class="page-header">회원 검색</h1>

  <!-- 검색 폼 -->
  <form action="list" method="get" class="search-box">
    <select name="column">
      <option value="member_id" ${param.column == "member_id" ? "selected" : ""}>아이디</option>
      <option value="member_nickname" ${param.column == "member_nickname" ? "selected" : ""}>닉네임</option>
      <option value="member_gender" ${param.column == "member_gender" ? "selected" : ""}>성별</option>
      <option value="member_level" ${param.column == "member_level" ? "selected" : ""}>등급</option>
    </select>
    <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요"  class="search-input" required>
    <button type="submit">검색</button>
  </form>

  <!-- 결과 출력 -->
  <c:choose>
    <c:when test="${memberList == null}">
      <div class="result-info">검색어를 입력하세요</div>
    </c:when>
    <c:otherwise>
      <div class="table-wrapper">
        <table class="table">
          <thead>
            <tr>
              <th>아이디</th>
              <th>닉네임</th>
              <th>이메일</th>
              <th>성별</th>
              <th>생년월일</th>
              <th>등급</th>
              <th>가입일</th>
              <th>포인트</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="memberDto" items="${memberList}" varStatus="status">
              <tr style="${status.count % 5 == 0 ? 'background-color:#fff9e6;' : ''}">
                <td>
                  <a href="detail?memberId=${memberDto.memberId}" class="member-link">
                    ${memberDto.memberId}
                  </a>
                </td>
                <td>${memberDto.memberNickname}</td>
                <td>${memberDto.memberEmail}</td>
                <td>${memberDto.memberGender}</td>
                <td>${memberDto.memberBirth}</td>
                <td>${memberDto.memberLevel}</td>
                <td><fmt:formatDate value="${memberDto.memberJoin}" pattern="yyyy-MM-dd"/></td>
                <td>${memberDto.memberPoint}</td>
              </tr>
            </c:forEach>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="8" class="result-info">
                검색결과: ${pageVO.begin} - ${pageVO.end} / ${pageVO.dataCount}명
              </td>
            </tr>
            <tr>
              <td colspan="8" class="result-info">
                페이지: ${pageVO.page} / ${pageVO.totalPage}
              </td>
            </tr>
          </tfoot>
        </table>
      </div>
    </c:otherwise>
  </c:choose>
  <!-- 페이지 네비게이터 -->
  <jsp:include page="/WEB-INF/views/template/pagination-num.jsp"></jsp:include>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
