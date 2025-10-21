<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<hr>
<h1>상단 메뉴</h1>
<!-- 로그인 여부에 따라 다른 메뉴들을 표시 -->
<!-- 일단 비회원 화면만 구현 -->
	<a href="/">
	<i class="fa-solid fa-house"></i>
	<span>홈</span>
	</a>
	<a href="/club/list">
	<i class="fa-solid fa-star"></i>
	<span>추천 모임</span>
	</a>
	<a href="/event/home">
	<i class="fa-solid fa-calendar-days"></i>
	<span>정모 일정</span>
	</a>
	<a href="/club/category">
	<i class="fa-solid fa-list"></i>
	<span>카테고리</span>
	</a>
	<a href="#">
	<i class="fa-solid fa-clock-rotate-left"></i>
	<span>최근 본 모임</span>
	</a>
	<a href="/member/join">
	<i class="fa-solid fa-user-plus"></i>
	<span>회원 가입</span>
	</a>
	<c:if test="${sessionScope.loginId == null}">
	<a href="/member/login">
	<i class="fa-solid fa-right-to-bracket"></i>
	<span>로그인</span>
	</a>
	</c:if>
	<c:if test = "${sessionScope.loginId != null}">
	<a href="/member/logout">
	<i class="fa-solid fa-right-from-bracket"></i>
	<span>로그아웃</span>
	</a>
	</c:if>
	<hr>