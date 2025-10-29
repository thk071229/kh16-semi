<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.grid {
  display: grid !important;
  gap: 16px !important;
  grid-template-columns: repeat(4, 1fr) !important; 
}
.card {
    max-width: 260px !important; /* 카드 최대 너비 (컨테이너 크기에 맞게 조절) */
    width: 100% !important;
}
</style>

<%-- 좋아요 관련 javaSciprt 코드 --%>

<%-- js 파일을 불러와 소모임에 토글 기능 추가 --%>
<c:if test="${sessionScope.loginId != null && sessionScope.loginLevel != '관리자'}">
<script type="text/javascript" src="/js/club-like.js"></script>
</c:if>	

<div class="container mt-30"> <%-- 전체 컨테이너 --%>
    <h2>전체 소모임 목록</h2>

    <div class="grid mt-20"> <%-- 카드 목록 그리드 (4열) --%>

        <c:forEach var="club" items="${clubList}"> <%-- 컨트롤러에서 전달한 clubList 반복 --%>
            <div class="card"> <%-- 카드 기본 스타일 --%>
                <div> <%-- 이미지 영역 --%>
                    <c:choose>
                        <c:when test="${club.clubProfile != null}">
                        	<%-- 액박을 해결하는 onerror 추가 --%>
                            <img src="/attachment/download?attachmentNo=${club.clubProfile}" alt="${club.clubName}" 
                            onerror="this.onerror=null; this.src='/images/error/no-image.png';" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/error/no-image.png" alt="기본 이미지" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="v-stack" style="padding: 16px;"> <%-- 내용을 위한 세로 스택 + 카드 내부 패딩 --%>
                    <div class="kicker"> <%-- 작은 텍스트 스타일 (지역 | 카테고리) --%>
                        <span>${club.regionName}</span>
                    </div>
                    <div class="kicker">
                   		<span>${club.categoryName}</span>
                    </div>
                    <div class="kicker">
                   		<span>회원수:${club.memberCount}명</span>
                    </div>
                    <h4 style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display:block;">${club.clubName}</h4> <%-- 모임 이름 --%>
                    	<div class="h-stack like-area" data-club-no="${club.clubNo}">
                        <span class="ms-10 like-count">
                        <i class="fa-regular fa-heart red toggle-like"></i>
                        <span class="like-count-value">${club.clubLike}</span> <%-- '개' 글자 span 안으로 이동 --%>
                        </span>
                    </div>
                    <a href="/club/home?clubNo=${club.clubNo}" class="btn btn-ghost mt-10 club-number">자세히 보기</a> <%-- 고스트 버튼 + 상단 여백 --%>
                </div>
            </div>
        </c:forEach>

    </div>
    
	<%-- 페이지 네비게이터 영역 --%>
	<div class="cell center mt-20 mb-20">
		<jsp:include page="/WEB-INF/views/template/pagination-num.jsp"></jsp:include>
	</div>
	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>