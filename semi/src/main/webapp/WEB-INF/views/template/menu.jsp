<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

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

<script type="text/template" id="category-template">
    <li>
        <a class="category-link" href="#"></a>
    </li>
</script>

<script type="text/javascript">
$(function(){
	// 템플릿을 미리 읽고 jQuery 객체로 저장
    const templateText = $("#category-template").text();
    
	function loadCategoryList(){
		$.ajax({
			url:"/rest/category/list", 
			method:"GET", 
			success:function(response){
				const $categoryUl = $("#category-submenu");
				$categoryUl.empty(); // 기존 내용 비우기
				
				// 1. 응답 목록을 순회하며 HTML 생성
				response.forEach(function(categoryDto) {
					// 2. 템플릿 복제 및 HTML 구조 재해석
                    // $.parseHTML()을 사용해 텍스트를 HTML 요소로 변환한 후 jQuery 객체로 감쌈
					const $newHtml = $($.parseHTML(templateText));
                    
                    // 3. 내용 변경 (데이터 바인딩)
                    const link = `/club/category?categoryNo=`;
                    
                    // 링크 (<a>) 요소 찾기
                    $newHtml.find(".category-link")
                        .attr("href", link+categoryDto.categoryNo) // href 속성 설정
                        .text(categoryDto.categoryName); // 텍스트 내용 설정
       
					// 4. 대상 영역에 추가
					$categoryUl.append($newHtml);
				});
			},
			error: function() {
				console.error("카테고리 목록을 불러오는 데 실패했습니다.");
                $("#category-submenu").append("<li><a>목록 로드 실패</a></li>");
			}
		});
	}
	
	// 페이지 로드 후 함수 실행
	loadCategoryList();
});
</script>
<script type="text/javascript">
</script>
<!-- 로그인 여부에 따라 다른 메뉴들을 표시 -->
<nav class="nav">	
    <a href="/">
	<i class="fa-solid fa-house"></i>
	<span>홈</span>
	</a>
	<ul class="dropdown-menu">
       <li>
           <a href="/club/list">
           <i class="fa-solid fa-list"></i>
           <span>카테고리</span>
           </a>
           <ul id="category-submenu">
           </ul>
       </li>
   </ul>
	<a href="/club/recommandList">
	<i class="fa-solid fa-star"></i>
	<span>추천 모임</span>
	</a>
	<a href="/event/home">
	<i class="fa-solid fa-calendar-days"></i>
	<span>정모 일정</span>
	</a>
	<c:if test="${sessionScope.loginId == null}">
	<a href="/member/agree">
	<i class="fa-solid fa-user-plus"></i>
	<span>회원 가입</span>
	</a>
	</c:if>
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
<!-- 	<hr> -->