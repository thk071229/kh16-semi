<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
	<!-- 보안상의 이슈로 목록은 출력x -->
	<div>
		<h1>회원 검색</h1>
	</div>
	
	<!-- 검색 -->
	<form action="list" method="get">
	<div>
		<select name="column">
			<option value="member_id" ${param.column == "member_id" ? "selected" : ""}>아이디</option>
			<option value="member_nickname" ${param.column == "member_nickname" ? "selected" : ""}>닉네임</option>
			<option value="member_gender" ${param.column == "member_gender" ? "selected" : ""}>성별</option>
			<option value="member_level" ${param.column == "member_level" ? "selected" : ""}>등급</option>
		</select>
	</div>
	<div>
		<input type="text" name="keyword" value="${param.keyword}" required>
	</div>
	<div>
		<button type="submit">검색</button>
	</div>
	</form>
	
	<!-- 결과 -->
	<c:choose>
		<c:when test="${memberList == null}">
			<div>
				<h3>검색어를 입력하세요</h3>
			</div>
		</c:when>
		<c:otherwise>
			<div>
				<table class="table table-hover table-border">
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
					<tbody align="center">
					<c:forEach var="memberDto" items="${memberList}" varStatus="status">
						<tr bgcolor="${status.count % 5 == 0 ? '#ffeaa7' : ''}">
							<th>
								<a href="detail?memberId=${memberDto.memberId}">
									${memberDto.memberId}
								</a>
							</th>
							<td>${memberDto.memberNickname}</td>
							<td>${memberDto.memberEmail}</td>
							<td>${memberDto.memberGender}</td>
							<td>${memberDto.memberBirth}</td>
							<td>${memberDto.memberLevel}</td>
							<td>
								<fmt:formatDate value="${memberDto.memberJoin}" pattern="yyyy-MM-dd"/>
							</td>
							<td>${memberDto.memberPoint}</td>
						</tr>
					</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="7">
								검색결과 : 
								${pageVO.begin} - ${pageVO.end}
								/
								${pageVO.dataCount}개
							</td>
						</tr>
						<tr>
							<td colspan="7">
								검색결과 : 
								${pageVO.page} / ${pageVO.totalPage} 페이지
							</td>
						</tr>
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