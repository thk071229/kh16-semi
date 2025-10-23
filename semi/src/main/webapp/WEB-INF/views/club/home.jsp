<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1><a href="home?clubNo=${clubDto.clubNo}">홈</a></h1>
<h1><a href="/board/list?clubNo=${clubDto.clubNo}">게시판</a></h1>
<h1><a href="/event/list?clubNo=${clubDto.clubNo}">정모</a></h1>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>