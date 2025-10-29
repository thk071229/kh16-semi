<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
/* 추천 목록 그리드 (항상 4열로 강제) */
.grid {
  display: grid !important; /* display 속성 강제 */
  gap: 16px !important; /* 간격 강제 (commons.css와 동일하게) */
  grid-template-columns: repeat(4, 1fr) !important; /* 4열 강제 */
}
/* 카드 최대 너비 설정 (4개가 들어가도록) */
.card .v-stack { /* 카드 내용 영역이 남은 공간 채우도록 */
    flex-grow: 1;
    display: flex;
    flex-direction: column;
}
.region-name {
  display: inline-block; 
  max-width: 13ch;            /* 글자 단위로 9글자 너비 제한 */
  overflow: hidden;          /* 넘친 글자 숨김 */
  text-overflow: ellipsis;   /* ... 으로 표시 */
  white-space: nowrap;       /* 줄바꿈 방지 */
}
.like-area .toggle-like { /* 아이콘 색상 */
  font-size: 16px;
  color: white !important; /* .red 재정의 */
}
.like-area {
  position: absolute;
  top:10px;
  background: rgba(0, 0, 0, 0.5);
  padding: 5px 10px;
  color:white;
  border-radius: var(--radius-sm);
  display: inline-flex; /* h-stack 대체 */
  align-items: center;
  gap: 6px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.2s ease;
  z-index: 10; /* 이미지 위에 표시 */
}

</style>
<jsp:include page="/WEB-INF/views/template/main-header.jsp"></jsp:include>
<%-- js 파일을 불러와 소모임에 토글 기능 추가 --%>
<c:if test="${sessionScope.loginId != null && sessionScope.loginLevel != '관리자'}">
<script type="text/javascript" src="/js/club-like.js"></script>
</c:if>	
<%-- clubLikeList-ajax 코드가 들어갈 js --%>
<script type="text/javascript">
	$(function(){});
</script>

<%-- clubEventList-ajax 코드가 들어갈 js --%>
<script type="text/javascript">
	$(function(){});
</script>

<%-- clubBoardList-ajax 코드가 들어갈 js --%>
<script type="text/javascript">
	$(function(){});
</script>

<%-- clubLikeList의 template --%>
<script type ="text/template">

</script>

<%-- clubEventList의 template --%>
<script type ="text/template">

</script>

<%-- clubBoardList의 template --%>
<script type ="text/template">

</script>


<div class = "container">

	<h1>메인 페이지</h1>
	<h2>소모임 - 우리동네 취미 모임</h2>
	<h4>소개글</h4>
<label>
<i class="fa-solid fa-location-dot"></i>
서울시 강남구(header에 있는 button-span value 불러오기) 근처 모임
</label>

<%-- 찜이 많은 소모임 --%>
<div class="header"> <%-- 제목과 '더보기' 링크를 위한 레이아웃 --%>
        <h3>⭐ 찜이 많은 소모임 ⭐</h3>
        <a href="/club/list" class="link">더보기 &gt;</a> <%-- 더보기 링크 --%>
</div>

<div class="grid mt-20"> <%-- 카드 목록 그리드 (CSS에서 4열로 설정 필요) --%>

        <c:forEach var="likeCountVO" items="${clubLikeCountVO}">
            <div class="card"> 
                <div> <%-- 이미지 영역 --%>
                    <c:choose>
                        <c:when test="${not empty likeCountVO.clubProfile}">
   						 	<img src="/attachment/download?attachmentNo=${likeCountVO.clubProfile}" alt="${likeCountVO.clubName}" 
    						onerror="this.onerror=null; this.src='/images/error/no-image.png';"
    						style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
						</c:when>
                        <c:otherwise>
                            <img src="/images/error/no-image.png" alt="기본 이미지" 
                            style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="v-stack" style="padding: 16px;"> <%-- 내용을 위한 세로 스택 + 카드 내부 패딩 --%>
                    <h4 style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${likeCountVO.clubName}</h4>
                    <div class="kicker"> <%-- 작은 텍스트 스타일 (지역 | 카테고리) --%>
                        <span class="region-name">
                        ${likeCountVO.regionName}
                        </span>
                    </div>
                    <div class="kicker">
                    	<span>${likeCountVO.categoryName}</span>
                    </div>
                    <div class="kicker">
                    	<span>회원수:${likeCountVO.memberCount}</span> | <span>정모 ${likeCountVO.eventCount}</span>
                    </div>
                    <div class="h-stack like-area" data-club-no="${likeCountVO.clubNo}">
                        <span class="ms-10 like-count">
                        <i class="fa-regular fa-heart red toggle-like"></i>
                        <span class="like-count-value">${likeCountVO.clubLike}</span> <%-- '개' 글자 span 안으로 이동 --%>
                        </span>
                    </div>
                    <a href="/club/home?clubNo=${likeCountVO.clubNo}" class="btn btn-ghost mt-10">자세히 보기</a>
                </div>
            </div>
        </c:forEach>
    </div>
    	<div class="cell center mt-20 mb-20">
			<jsp:include page="/WEB-INF/views/template/pagination-num-board.jsp"></jsp:include>	
		</div>
<div class="header"> <%-- 제목과 '더보기' 링크를 위한 레이아웃 --%>
        <h3>⭐ 활동이 활발한 모임 (이벤트) ⭐</h3>
        <a href="/club/list" class="link">더보기 &gt;</a> <%-- 더보기 링크 --%>
</div>
	<div class="grid mt-20">
	
	<c:forEach var="eventCountVO" items="${clubEventCountVO}" varStatus="status">
			<div class="card">
				<div> <%-- 이미지 영역 --%>
                    <c:choose>
                        <c:when test="${not empty eventCountVO.clubProfile}">
                            <img src="/attachment/download?attachmentNo=${eventCountVO.clubProfile}" alt="${eventCountVO.clubName}" 
                            onerror="this.onerror=null; this.src='/images/error/no-image.png';" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/error/no-image.png" alt="기본 이미지" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="v-stack" style="padding: 16px;"> <%-- [수정] center 클래스 제거, v-stack만 사용 --%>
                    <h4 style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${eventCountVO.clubName}</h4>
                    <div class="kicker">
                        <span class="region-name">${eventCountVO.regionName}</span>
                    </div>
                    <div class="kicker">
                        <span>${eventCountVO.categoryName}</span>
                    </div>
                    <div class="kicker">
                        <span> 멤버 ${eventCountVO.memberCount}</span> | <span>정모 ${eventCountVO.eventCount}</span>
                    </div>
                    <div class="h-stack like-area" data-club-no="${eventCountVO.clubNo}">
                        <span class="ms-10 like-count">
                        <i class="fa-regular fa-heart red toggle-like"></i>
                        <span class="like-count-value">${eventCountVO.clubLike}</span> <%-- '개' 글자 span 안으로 이동 --%>
                        </span>
                    </div>
                    <a href="/club/home?clubNo=${eventCountVO.clubNo}" class="btn btn-ghost mt-10">자세히 보기</a>
                </div>
            </div> <%-- card 닫기 --%>
		</c:forEach>

	</div> <%-- grid 닫기 --%>
		<div class="cell center mt-20 mb-20">
			<jsp:include page="/WEB-INF/views/template/pagination-num-event.jsp"></jsp:include>	
		</div>
	

<div class="header"> <%-- 제목과 '더보기' 링크를 위한 레이아웃 --%>
        <h3>⭐ 활동이 활발한 모임 (게시글) ⭐</h3>
        <a href="/club/list" class="link">더보기 &gt;</a> <%-- 더보기 링크 --%>
</div>
	<div class="grid mt-20">
	<c:forEach var="boardCountVO" items="${clubBoardCountVO}" varStatus="status">
			<div class="card">
				<div> <%-- 이미지 영역 --%>
                    <c:choose>
                        <c:when test="${not empty boardCountVO.clubProfile}">
                            <img src="/attachment/download?attachmentNo=${boardCountVO.clubProfile}" alt="${boardCountVO.clubName}" 
                            onerror="this.onerror=null; this.src='/images/error/no-image.png';" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/error/no-image.png" alt="기본 이미지" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="v-stack" style="padding: 16px;"> <%-- [수정] center 클래스 제거, v-stack만 사용 --%>
                    <h4 style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${boardCountVO.clubName}</h4>
                    <div class="kicker">
                        <span class="region-name">${boardCountVO.regionName}</span>
                    </div>
                    <div class="kicker">
                        <span>${boardCountVO.categoryName}</span>
                    </div>
                    <div class="kicker">
                         <span> 멤버 ${boardCountVO.memberCount}</span> | <span> 게시글 ${boardCountVO.boardCount}</span>
                    </div>
                    <div class="h-stack like-area" data-club-no="${boardCountVO.clubNo}">
                        <span class="ms-10 like-count">
                        <i class="fa-regular fa-heart red toggle-like"></i>
                        <span class="like-count-value">${boardCountVO.clubLike}</span>개 <%-- '개' 글자 span 안으로 이동 --%>
                        </span>
                    </div>
                    <a href="/club/home?clubNo=${boardCountVO.clubNo}" class="btn btn-ghost mt-10">자세히 보기</a>
                </div>
            </div> <%-- card 닫기 --%>
		</c:forEach>
	</div> <%-- grid 닫기 --%>
		<div class="cell center mt-20 mb-20">
			<jsp:include page="/WEB-INF/views/template/pagination-num-like.jsp"></jsp:include>	
		</div>
<div class="header"> <%-- 제목과 '더보기' 링크를 위한 레이아웃 --%>
        <h3>⭐ 내 근처에서 시작되는 정모 ⭐</h3>
        <a href="/club/list" class="link">더보기 &gt;</a> <%-- 더보기 링크 --%>
</div>

<div class="header"> <%-- 제목과 '더보기' 링크를 위한 레이아웃 --%>
        <h3>⭐ 카테고리 별 모임 ⭐</h3>
        <a href="/club/list" class="link">더보기 &gt;</a> <%-- 더보기 링크 --%>
</div>

<%-- 구분선 --%>
<hr>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>