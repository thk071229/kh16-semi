<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
/* 추천 목록 그리드 (항상 4열로 강제) */
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
<div class="container mt-50"> <%-- 전체 컨테이너 및 상단 여백 --%>
    <div class="header"> <%-- 제목과 '더보기' 링크를 위한 레이아웃 --%>
        <h3>⭐ 찜이 많은 소모임 ⭐</h3>
        <a href="/club/list" class="link">더보기 &gt;</a> <%-- 더보기 링크 --%>
    </div>

    <div class="grid mt-20"> <%-- 카드 목록 그리드 (CSS에서 4열로 설정 필요) --%>

        <c:forEach var="club" items="${clubList}">
            <div class="card"> 
                <div> <%-- 이미지 영역 --%>
                    <c:choose>
                        <c:when test="${club.clubProfile != null}">
                            <img src="/attachment/download?attachmentNo=${club.clubProfile}" alt="${club.clubName} 프로필" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;"> <%-- 이미지 스타일 + 상단 모서리 둥글게 --%>
                        </c:when>
                        <c:otherwise>
                            <img src="/images/error/no-image.png" alt="기본 이미지" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;"> <%-- 이미지 스타일 + 상단 모서리 둥글게 --%>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="v-stack" style="padding: 16px;"> <%-- 내용을 위한 세로 스택 + 카드 내부 패딩 --%>
                    <div class="kicker"> <%-- 작은 텍스트 스타일 (지역 | 카테고리) --%>
                        <span>${club.regionName}</span> | <span>${club.categoryName}</span>
                    </div>
                    <h4 style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${club.clubName}</h4> <%-- 모임 이름 (기본 스타일 + 줄바꿈 방지) --%>
                    <div class="h-stack"> <%-- 가로 스택 (좋아요 수) --%>
                        <span class="ms-10"><i class="fa-solid fa-heart red"></i> ${club.clubLike}개</span> <%-- 빨간색 하트 + 좋아요 수 --%>
                    </div>
                    <a href="/club/home?clubNo=${club.clubNo}" class="btn btn-ghost mt-10">자세히 보기</a> <%-- 고스트 버튼 + 상단 여백 --%>
                </div>
            </div>
        </c:forEach>

    </div>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>