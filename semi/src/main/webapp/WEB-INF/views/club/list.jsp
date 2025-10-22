<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container w-800">
        <div class="cell center">
            <h1>소모임 전체 목록</h1>
        </div>

        <div class="cell right">
            <a href="add" class="btn btn-primary">소모임 등록하기</a>
        </div>
        <div class="cell">
            <table class="table field w-100" var>
                <thead>
                    <tr>
                        <th>모임 이름</th>
			            <th>모임지역</th>
			            <th>분류</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="clubListVO" items="${clubList}">
                    <tr>
                        <td>${clubListVO.clubName}</td>
                        <td>${clubListVO.regionName}</td>
                        <td>${clubListVO.categoryName}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <!-- 페이지 네비게이터 -->
        <div class="cell">
            <span>페이지 네비게이터</span>
        </div>
        <!-- 검색창 -->
        <div class="flex-box">
            <input type="text" class="field w-100">
        </div>
    </div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>