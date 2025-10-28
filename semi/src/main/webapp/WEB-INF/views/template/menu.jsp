<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.dropdown-menu {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0;
  padding: 0;
  list-style: none;
}

/* 드롭다운 상위 항목 (카테고리 버튼) — 다른 메뉴와 동일한 높이감 */
.dropdown-menu > li > a {
  display: flex;
  align-items: center;
  justify-content: center;
  text-decoration: none;
  color: var(--subtle);
  padding: 8px 10px;
  border-radius: 8px;
  font-weight: 600;
  font-size: 14px;
  transition: background 0.2s ease;
}

.dropdown-menu > li > a:hover {
  background: var(--muted);
  color: var(--ink);
}

/* 하위 메뉴 (드롭다운 목록) */
.dropdown-menu ul {
  display: none;
  position: absolute;
  top: 100%;
  left: 50%; /* 가운데 정렬 */
  transform: translateX(-50%);
  background: var(--muted);
  list-style: none;
  margin: 0;
  padding: 5px 0;
  border-radius: 8px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.15);
  z-index: 1000;
  min-width: 130px;
  text-align: center;
}

/* hover 시 하위 메뉴 표시 */
.dropdown-menu li:hover > ul {
  display: block;
}

/* 하위 메뉴 항목 스타일 */
.dropdown-menu ul li a {
  display: block;
  padding: 8px 10px;
  color: var(--subtle);
  text-decoration: none;
  border-radius: 0;
}

.dropdown-menu ul li a:hover {
  background:var(--muted); 
  color:var(--ink)
}

</style>

<hr>
<!-- <h1>상단 메뉴</h1> -->
<!-- 로그인 여부에 따라 다른 메뉴들을 표시 -->
<!-- 일단 비회원 화면만 구현 -->
<nav class="nav">	
    <a href="/">
	<i class="fa-solid fa-house"></i>
	<span>홈</span>
	</a>
	<a href="/club/recommandList">
	<i class="fa-solid fa-star"></i>
	<span>추천 모임</span>
	</a>
	<a href="/event/home">
	<i class="fa-solid fa-calendar-days"></i>
	<span>정모 일정</span>
	</a>
	<ul class="dropdown-menu">
        <li>
            <a href="/club/category">
            <i class="fa-solid fa-list"></i>
            <span>카테고리</span>
            </a>
            <ul>
            	<c:forEach items="${categoryList}" var="categoryDto">
                <li>
                    <a href="/club/category?categoryNo=${categoryDto.categoryNo}">${categoryDto.categoryName}</a>
                </li>
            	</c:forEach>
            </ul>
        </li>
    </ul>
	<a href="#">
	<i class="fa-solid fa-clock-rotate-left"></i>
	<span>최근 본 모임</span>
	</a>
	<a href="/member/agree">
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
	<a href="/member/mypage">
	<i class="fa-solid fa-user"></i>
	<span>마이페이지</span>
	</a>
	</c:if>
	<c:if test = "${sessionScope.loginId != null && loginLevel == '관리자'}">
	<a href="/admin/home">
	<i class="fa-solid fa-user-tie"></i>
	<span>관리자페이지</span>
	</a>
	</c:if>
</nav>
	<hr>