<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 모든 jsp에서 사용 가능한 css파일과 cdn 파일을 header에 등록 --%>
<%-- 디자인 파일 추가 --%>
<link rel ="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
<%-- font-awesome css --%>
<link rel ="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
<%-- jQuery cdn --%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 모든 jquery ajax의 전송 시 주소 앞에 절대경로를 추가 -->
<script>
	var contextPath = "${pageContext.request.contextPath}";//어쩔 수 없는 코드
	$.ajaxSetup({
		beforeSend: function(xhr, settings) {
			//xhr = 요청객체 / settiongs = 요청옵션
			//$.ajax({}) > 요청객체 / 괄호 안에 들어가는 것: 요청옵션
			if(settings.url.startsWith("/")){ //주소가 절대경로라면
				settings.url = contextPath + settings.url;
			}
		}
	});
</script>
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
/* ========================================================= */
/* 1. 기본 설정 및 목록 기호 제거 */
/* ========================================================= */

.dropdown-menu2 {
    position: relative;
    /* nav의 Flex 흐름에서 독립적인 블록 요소로 동작 */
    display: inline-block; 
    margin: 0;
    padding: 0;
    list-style: none; /* 최상위 목록 기호 제거 */
}

/* 모든 하위 목록의 기호 및 마진/패딩 초기화 */
.dropdown-menu2 ul {
    list-style: none;
    margin: 0;
    padding: 0;
}

/* 1단계 항목 LI (Absolute 위치의 기준점) */
.dropdown-menu2 > li {
    position: relative; 
    width: 150px; /* 상위 버튼 너비 */
    list-style: none;
}

/* --------------------------------------------------------- */
/* 2. 1차 메뉴 (세로 1열) */
/* --------------------------------------------------------- */

/* 1차 메뉴 UL (#region-submenu-level1) */
.dropdown-menu2 ul {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    z-index: 1000;
    
    /* 1차 메뉴 스타일: 세로 1열로 길게 */
    max-height: none; 
    width: 150px; /* 1차 메뉴 폭 고정 */
    column-count: 1; /* 1열 강제 */
    
    /* 디자인 */
    background: var(--bg);
    border-radius: var(--radius-sm);
    box-shadow: var(--shadow);
    border: 1px solid rgba(35,50,56,0.05);
    padding: 5px 0; 
}

/* --------------------------------------------------------- */
/* 3. 2차 메뉴 (Multi-Column 3열 및 위치) */
/* --------------------------------------------------------- */

/* 2단계 하위 UL (상위 LI 옆으로 펼쳐짐) */
.dropdown-menu2 ul ul {
    position: absolute;
 	top: auto;
    left: 100%; /* 1차 메뉴의 오른쪽 끝에 위치 */
    z-index: 1001;
    margin-left: 1px;
    
    /* ▼▼▼ [핵심] 2차 메뉴: 3열 Multi-Column 설정 ▼▼▼ */
    max-height: 400px; /* 10개 항목 높이 */
    width: 450px; /* 3열(150px * 3) 너비 확보 */
    column-count: 3; /* 3열 강제 */
    column-gap: 10px; 
    
    /* 디자인 */
    background: var(--muted); 
    border-radius: var(--radius-sm);
    box-shadow: var(--shadow);
    padding: 5px;
}

/* hover 시 하위 메뉴 표시 */
.dropdown-menu2 li:hover > ul {
    display: block;
}

/* --------------------------------------------------------- */
/* 4. 항목 및 링크 공통 스타일 */
/* --------------------------------------------------------- */

/* 모든 LI 항목 */
.dropdown-menu2 li {
    padding: 0; 
    margin: 0;
}

/* 모든 A 태그 (폰트, 색상, 패딩) */
.dropdown-menu2 a {
    text-decoration: none;
    color: var(--subtle);
    display: flex; 
    align-items: center;
    justify-content: flex-start;
    padding: 6px 8px; /* 항목별 패딩 */
    font-size: 14px;
    font-weight: 600;
    width: 100%;
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    border-radius: 4px;
}

/* hover 시 색상 */
.dropdown-menu2 a:hover {
    background: var(--muted);
    color: var(--ink);
}

/* 2차 메뉴 hover 시 배경 강조 (3열 전체에 적용) */
.dropdown-menu2 ul ul a:hover {
    background: rgba(127,200,169,0.2); 
    color: var(--primary-600);
}

</style>


<script type="text/javascript">
var contextPath = "${pageContext.request.contextPath}"; // 어쩔 수 없는 코드
$("#searchBtn").on("click", function() {
    const keyword = $("#searchInput").val().trim();
    if (keyword) {
        // keyword를 URL에 담아서 페이지 이동
        location.href = contextPath+`/search?keyword=`+keyword;
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
    
    // --- 1단계 지역 목록 로드 함수 ---
    function loadRegionLevel1(){
        $.ajax({
            url:contextPath+"/rest/region/depth1List", // RestController 경로 확인
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
            url: contextPath+`/rest/region/depth2List?regionDepth1=`+depth1, // RestController 경로 확인
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
            // 1. 2단계 목록 불러오기
        	loadRegionLevel2(depth1, $targetUl);
            // 2. ▼▼▼ [핵심] 위치 계산 및 설정 ▼▼▼
            const $hoveredLi = $(this);
            
            // 1차 메뉴 UL (부모 컨테이너)의 상단 위치 (offset().top)
            const parentUlTop = $regionLevel1List.offset().top; 
            
            // 호버된 LI의 상단 위치 (offset().top)
            const hoveredLiTop = $hoveredLi.offset().top;
            
            // 2차 메뉴가 부모 UL을 기준으로 시작해야 하는 상대적인 TOP 위치 계산
            // (호버된 LI 위치 - 부모 UL 위치)
            const relativeTop = hoveredLiTop - parentUlTop;

            // 2차 메뉴의 CSS 'top' 속성 설정
            // 미세 조정을 위해 2차 메뉴가 1차 메뉴의 <li> 시작점에 정확히 오도록 합니다.
            // (필요에 따라 1px~3px 정도 음수 값을 빼서 간격을 조정할 수 있습니다.)
            $targetUl.css({
                'top': relativeTop + 'px',
                'left': '100%' // 오른쪽에 고정
            });
        }
    });

    // 1단계 링크 클릭 시: depth1 파라미터 포함 URL로 이동
    $regionLevel1List.on("click", ".region-depth1-link", function(e) {
        e.preventDefault(); // 기본 링크 동작 막기
        const depth1 = $(this).data("depth1");
        if (depth1) {
            // URL 생성 및 페이지 이동
            location.href = contextPath+`/?regionDepth1=`+depth1;
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
            location.href = contextPath+`/?regionDepth1=`+depth1+`&regionDepth2=`+depth2;
        }
    });

    // --- 페이지 로드 시 초기 실행 ---
    loadRegionLevel1(); // 1단계 목록 로드 시작
});
</script>


<div class="container">
    <header class="header">
        <a class="brand" href="${pageContext.request.contextPath}/">
        <!-- 로고 이미지 -->
        <div class="logo">SS</div>
        <div class="cell">
            <div style="font-weight:800">SOSO</div>
            <div style="font-size:12px;color:var(--subtle)">소소한 만남을 원하는 사람들의 모임</div>
        </div>
        </a>
        <!-- 헤더 내 검색 영역 -->
		<div class="cell right">
			<div class="flex-box">
			<div class="flex-fill">
			<ul class="dropdown-menu2">
		       <li>
		           <a href="#"> <%-- 최상위 링크 비활성화 --%>
		               <i class="fa-solid fa-map-location-dot"></i>
		               <span>지역별</span>
		           </a>
		           <%-- 1단계 AJAX 결과가 삽입될 곳 --%>
		           <ul id="region-submenu-level1"></ul>
		       </li>
		    </ul>
		</div>
			
		  <form action="${pageContext.request.contextPath}/search" method="get" id="searchForm" autocomplete="off">
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