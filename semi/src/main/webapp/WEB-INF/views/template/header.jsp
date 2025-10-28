<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 모든 jsp에서 사용 가능한 css파일과 cdn 파일을 header에 등록 --%>
<%-- 디자인 파일 추가 --%>
<link rel ="stylesheet" type="text/css" href="/css/common.css">
<%-- font-awesome css --%>
<link rel ="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
<%-- jQuery cdn --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<%-- momentjs cdn --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>

<style>
/* header 검색창 영역 */
.header-search {
  margin-left: auto; /* 오른쪽 끝으로 */
  display: flex;
  align-items: center;
}

/* form 자체 정렬 */
.search-form {
  display: flex;
  align-items: center;
  gap: 8px;
}


/* 버튼 */
.search-btn {
  background: var(--primary);
  color: #fff;
  font-weight: 600;
  border: none;
  border-radius: 8px;
  padding: 10px 16px;
  cursor: pointer;
  transition: background 0.2s ease, transform 0.2s ease;
}

.search-btn:hover {
  background: var(--primary-600);
  transform: translateY(-1px);
}

</style>

<div class="container">
    <header class="header">
        <a class="brand" href="/">
        <!-- 로고 이미지 -->
        <div class="logo">SS</div>
        <div class="cell">
            <div style="font-weight:800">Somoim Spring</div>
            <div style="font-size:12px;color:var(--subtle)">모임/커뮤니티 플랫폼 예시</div>
        </div>
        </a>
        <!-- 헤더 내 검색 영역 -->
		<div class="header-search">
			<div class="keyword-search">
		  <form action="/search" method="get" autocomplete="off">
		    <input
		      type="text"
		      name="keyword"
		      class="search-input"
		      placeholder="검색어를 입력하세요"
		      required
		    >
		    <button type="submit" class="search-btn">검색</button>
		  </form>
		  </div>
		</div>

    </header>  
<!-- 상단 메뉴 -->
<jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>	
</div>

<!-- 사이드 메뉴 (클릭하면 나오도록) 추후 구현 -->
 <jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>