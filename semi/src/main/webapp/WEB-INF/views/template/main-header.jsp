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

.dropdown-menu { /* 기본 구조 확인 */
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0;
  padding: 0;
  list-style: none;
}
.dropdown-menu > li { position: relative; }
.dropdown-menu > li > a { display: flex; /* ... 기타 스타일 ... */ }
.dropdown-menu ul { /* 1단계 하위 메뉴 */
  display: none; position: absolute; top: 100%; left: 0; /* 왼쪽 정렬 */
  transform: none; /* transform 제거 */
  background: var(--muted); list-style: none; margin: 0; padding: 5px 0;
  border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.15); z-index: 1000;
  min-width: 150px; text-align: left; border: 1px solid rgba(35,50,56,0.05);
}
.dropdown-menu li:hover > ul { display: block; }
.dropdown-menu ul li { width: 100%; }
.dropdown-menu ul li a { display: block; padding: 8px 12px; color: var(--subtle); text-decoration: none; text-align: left; }
.dropdown-menu ul li a:hover { background:var(--muted); color:var(--ink); }

/* ▼▼▼ 2단계 메뉴 스타일 추가 ▼▼▼ */
.dropdown-menu ul ul { /* 2단계 하위 메뉴 */
    display: none;
    position: absolute;
    top: 0;
    left: 100%; /* 부모 li 오른쪽에 위치 */
    margin-left: 1px; /* 약간의 간격 (선택 사항) */
    
    /* 1단계와 유사한 디자인 상속 또는 재정의 */
    background: var(--muted); 
    min-width: 150px; 
    padding: 5px 0;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.15);
    z-index: 1001; /* 1단계 위에 오도록 */
    text-align: left;
}

.dropdown-menu ul li:hover > ul { /* 부모 li에 호버 시 2단계 메뉴 표시 */
    display: block;
}
</style>

<script type="text/javascript">
$("#searchBtn").on("click", function() {
    const keyword = $("#searchInput").val().trim();
    if (keyword) {
        // keyword를 URL에 담아서 페이지 이동
        location.href = `/search?keyword=`+keyword;
    }
});
</script>

<script type="text/template" id="region-level1-template">
    <li>
        <%-- data-depth1 속성에 1단계 지역명 저장 --%>
        <a class="region-depth1-link" href="#" data-depth1="">
            <span class="region-name"></span>
            <%-- 오른쪽 화살표 아이콘 추가 --%>
            <i class="fa-solid fa-chevron-right" style="margin-left: auto; font-size: 0.8em;"></i> 
        </a>
        <%-- 2단계 목록이 삽입될 빈 ul --%>
        <ul class="region-level2-submenu"></ul>
    </li>
</script>
<script type="text/template" id="region-level2-template">
    <li>
        <%-- data 속성에 depth1, depth2 모두 저장 (클릭 시 사용) --%>
        <a class="region-depth2-link" href="#" data-depth1="" data-depth2=""></a>
    </li>
</script>

<script type="text/javascript">
$(function(){
    // 템플릿 텍스트 미리 읽기
    const level1TemplateText = $("#region-level1-template").text();
    const level2TemplateText = $("#region-level2-template").text();
    // 클럽 목록 페이지 기본 URL
    const targetBaseUrl = "/club/list"; // 실제 클럽 목록 URL로 변경 필요

    // --- 1단계 지역 목록 로드 함수 ---
    function loadRegionLevel1(){
        $.ajax({
            url:"/rest/region/depth1List", // RestController 경로 확인
            method:"GET",
            success:function(depth1List){ // depth1List는 ["경기", "서울", ...] 형태의 문자열 배열
                const $regionUl = $("#region-submenu-level1");
                $regionUl.empty(); // 기존 내용 비우기

                depth1List.forEach(function(depth1) {
                    // 1단계 템플릿 복제
                    const $newHtml = $($.parseHTML(level1TemplateText));
                    
                    // 데이터 바인딩: data 속성 및 텍스트 설정
                    $newHtml.find(".region-depth1-link").attr("data-depth1", depth1);
                    $newHtml.find(".region-name").text(depth1);
                    
                    // 목록에 추가
                    $regionUl.append($newHtml);
                });
            },
            error: function() {
                console.error("1단계 지역 목록 로드 실패");
                $("#region-submenu-level1").append("<li><a>로드 실패</a></li>");
            }
        });
    }

    // --- 2단계 지역 목록 로드 함수 (마우스 호버 시 호출) ---
    function loadRegionLevel2(depth1, $targetUl) {
        // 이미 해당 depth1로 로딩했으면 다시 로드하지 않음 (최적화)
        if ($targetUl.data("loaded-depth1") === depth1) return;

        $targetUl.html("<li><a><i class='fa fa-spinner fa-spin'></i></a></li>"); // 로딩 아이콘 표시

        $.ajax({
            // regionDepth1 파라미터로 depth1 값 전달 (URL 인코딩)
            url: `/rest/region/depth2List?regionDepth1=`+depth1, // RestController 경로 확인
            method: "GET",
            success: function(depth2List) { // depth2List는 ["고양시", "수원시", ...] 형태의 문자열 배열
                $targetUl.empty(); // 로딩 아이콘 제거
                $targetUl.data("loaded-depth1", depth1); // 로딩 완료 표시

                if (depth2List.length === 0) {
                     $targetUl.append("<li><a>하위 지역 없음</a></li>");
                     return;
                }

                depth2List.forEach(function(depth2) {
                    // 2단계 템플릿 복제
                    const $newHtml = $($.parseHTML(level2TemplateText));
                                        
                    // 데이터 바인딩: data 속성 (depth1, depth2) 및 텍스트 설정
                    $newHtml.find(".region-depth2-link")
                        .attr("data-depth1", depth1) 
                        .attr("data-depth2", depth2)
                        .text(depth2);
                        
                    // 2단계 목록에 추가
                    $targetUl.append($newHtml);
                });
            },
            error: function() {
                console.error(`2단계 지역 (${depth1}) 목록 로드 실패`);
                $targetUl.empty().append("<li><a>로드 실패</a></li>");
            }
        });
    }

    // --- 이벤트 리스너 설정 ---
    const $regionLevel1List = $("#region-submenu-level1");

    // 1단계 항목에 마우스 올렸을 때: 2단계 목록 로드
    // 이벤트 위임 사용 (동적으로 생성된 li에도 이벤트 적용)
    $regionLevel1List.on("mouseenter", "li", function() {
        const depth1 = $(this).find(".region-depth1-link").data("depth1");
        const $targetUl = $(this).find(".region-level2-submenu"); // 해당 li의 하위 ul
        
        // depth1 값이 있고, 하위 ul이 존재하면 2단계 로드 함수 호출
        if (depth1 && $targetUl.length > 0) {
            loadRegionLevel2(depth1, $targetUl);
        }
    });

    // 1단계 링크 클릭 시: depth1 파라미터 포함 URL로 이동
    $regionLevel1List.on("click", ".region-depth1-link", function(e) {
        e.preventDefault(); // 기본 링크 동작 막기
        const depth1 = $(this).data("depth1");
        if (depth1) {
            // URL 생성 및 페이지 이동
            location.href = `${targetBaseUrl}?regionDepth1=`+depth1;
        }
    });

    // 2단계 링크 클릭 시: depth1, depth2 파라미터 포함 URL로 이동
    // 이벤트 위임 사용
    $regionLevel1List.on("click", ".region-depth2-link", function(e) {
        e.preventDefault(); // 기본 링크 동작 막기
        const depth1 = $(this).data("depth1");
        const depth2 = $(this).data("depth2");
        if (depth1 && depth2) {
            // URL 생성 및 페이지 이동
            location.href = `${targetBaseUrl}?regionDepth1=`+depth1`&regionDepth2=`+depth2;
        }
    });

    // --- 페이지 로드 시 초기 실행 ---
    loadRegionLevel1(); // 1단계 목록 로드 시작
});
</script>


<div class="container w-100">
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
<%-- 			<div class="region-select-bar">
			<div class="first-select-list">
				<!-- 추후 드롭다운으로 구현 -->
				<select id="first-option">
				<option value = "">지역 선택</option>
					<!-- region_depth1의 값을 선택 -->
					<c:forEach var="depth1" items="${firstDepthList}">
					<option value = "${depth1}">
					${depth1}
					</option>
					</c:forEach>
				</select>
				<select id = "second-option">
					<!-- region_depth2의 값을 선택 -->
					<c:forEach var = "depth2" items = "${secondDepthList}">
					<option value = "depth2">
					${depth2}
					</option>
					</c:forEach>
				</select>
			</div>
			</div> --%>
			<ul class="dropdown-menu">
		       <li>
		           <a href="#"> <%-- 최상위 링크 비활성화 --%>
		               <i class="fa-solid fa-map-location-dot"></i>
		               <span>지역별</span>
		           </a>
		           <%-- 1단계 AJAX 결과가 삽입될 곳 --%>
		           <ul id="region-submenu-level1"></ul>
		       </li>
		    </ul>
			<div class="keyword-search">
		  <form action="/search" method="get" id="searchForm" autocomplete="off">
		    <input
		      type="text"
		      name="keyword"
		      id="searchInput" 
		      class="search-input"
		      placeholder="검색어를 입력하세요"
		      required
		    >
		    <button type="submit" id="searchBtn" class="search-btn">검색</button>
		  </form>
		  </div>
		</div>

    </header>  
<!-- 상단 메뉴 -->
<jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>	
</div>

<!-- 사이드 메뉴 (클릭하면 나오도록) 추후 구현 -->
 <jsp:include page="/WEB-INF/views/template/sidebar.jsp"></jsp:include>