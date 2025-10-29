<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

.grid {
  display: grid !important; /* display 속성 강제 */
  gap: 16px !important; /* 간격 강제 (commons.css와 동일하게) */
  grid-template-columns: repeat(4, 1fr) !important; /* 4열 강제 */
}
/* 카드 최대 너비 설정 (4개가 들어가도록) */
.card {
    max-width: 260px !important; /* 최대 너비 강제 (1100px 컨테이너 기준 계산 값) */
    width: 100% !important;
}
</style>

<%-- club-like.js 불러오기 --%>
<c:if test="${sessionScope.loginId != null && sessionScope.loginLevel != '관리자'}">
	<script src="/js/club-like.js"></script>
</c:if>

<div class="container mt-30"> <%-- 전체 컨테이너 --%>

    <div class = "header">
    <h2>${categoryDto.categoryName} 관련 소모임</h2>
	</div>
	
    <div class="grid mt-20"> <%-- 카드 목록 그리드 (CSS에서 4열로 설정 필요) --%>

        <c:forEach var="clubCountVO" items="${clubList}">
            <div class="card"> 
                <div> <%-- 이미지 영역 --%>
                    <c:choose>
                        <c:when test="${not empty clubCountVO.clubProfile}">
   						 	<img src="/attachment/download?attachmentNo=${clubCountVO.clubProfile}" alt="${clubCountVO.clubName}" 
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
                    <h4 style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${clubCountVO.clubName}</h4>
                    <div class="kicker"> <%-- 작은 텍스트 스타일 (지역 | 카테고리) --%>
                        <span class="region-name">
                        ${clubCountVO.regionName}
                        </span>
                    </div>
                    <div class="kicker">
                    	<span>${clubCountVO.categoryName}</span>
                    </div>
                    <div class="kicker">
                    	<span>회원수:${clubCountVO.memberCount}</span> | <span>정모 ${clubCountVO.eventCount}</span>
                    </div>
                    <div class="h-stack like-area" data-club-no="${clubCountVO.clubNo}">
                        <span class="ms-10 like-count">
                        <i class="fa-regular fa-heart red toggle-like"></i>
                        <span class="like-count-value">${clubCountVO.clubLike}</span> <%-- '개' 글자 span 안으로 이동 --%>
                        </span>
                    </div>
                    <a href="/club/home?clubNo=${clubCountVO.clubNo}" class="btn btn-ghost mt-10">자세히 보기</a>
                </div>
            </div>
        </c:forEach>
    </div>
	
	<div class="cell center mt-20 mb-20">
		<jsp:include page="/WEB-INF/views/template/pagination-num.jsp"></jsp:include>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    