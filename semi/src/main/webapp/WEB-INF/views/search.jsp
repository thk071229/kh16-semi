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

<div class="container mt-30"> <%-- 전체 컨테이너 --%>
    <h2>다음에 대한 소모임 검색 결과 표시 중 : ${keyword}</h2>
	
	<c:choose>
		<%-- 검색결과가 존재하지 않는다면 --%>
		<c:when test="${resultCount==0}">
			<div class="cell">
				<h4 style="color:#e17055;">검색 결과에 맞는 소모임이 존재하지 않습니다</h4>
			</div>
		</c:when>
		<%-- 검색결과가 존재한다면 --%>
		<c:otherwise>
			 <div class="grid mt-20"> <%-- 카드 목록 그리드 (4열) --%>
		  <c:forEach var="clubCountVO" items="${clubList}">
		  <div class="card">
		  <div> <%-- 이미지 영역 --%>
                    <c:choose>
                        <c:when test="${clubCountVO.clubProfile != null}">
                        	<%-- 액박을 해결하는 onerror 추가 --%>
                            <img src="/attachment/download?attachmentNo=${clubCountVO.clubProfile}" alt="${clubCountVO.clubName}" 
                            onerror="this.onerror=null; this.src='/images/error/no-image.png';" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/error/no-image.png" alt="기본 이미지" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="v-stack" style="padding: 16px;"> <%-- 내용을 위한 세로 스택 + 카드 내부 패딩 --%>
                    <div class="kicker"> <%-- 작은 텍스트 스타일 (지역 | 카테고리) --%>
                        <span>${clubCountVO.regionName}</span>
                    </div>
                    <div class="kicker">
                   		<span>${clubCountVO.categoryName}</span>
                    </div>
                    <div class="kicker">
                   		<span>회원수:${clubCountVO.memberCount}명</span>
                    </div>
                    <h4 style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display:block;">${club.clubName}</h4> <%-- 모임 이름 --%>
                    <div class="h-stack club-like-area" data-club-no="${clubCountVO.clubNo}"> <%-- 가로 스택 (좋아요 수) --%>
                        <span class="ms-10 club-like-count">
                        <i class="fa-regular fa-heart club-like-btn red"></i>
                        <span class="like-count-value">${clubCountVO.clubLike}</span>
                        </span> <%-- 빨간색 하트 + 좋아요 수 --%>
                    </div>
                    <a href="${pageContext.request.contextPath}/club/home?clubNo=${clubCountVO.clubNo}" class="btn btn-ghost mt-10 club-number">자세히 보기</a> <%-- 고스트 버튼 + 상단 여백 --%>
                </div>
            </div>
        </c:forEach>
		
	</div>
	
	<div class="cell center mt-20 mb-20">
		<jsp:include page="/WEB-INF/views/template/pagination-num-search.jsp"></jsp:include>
	</div>
		
		</c:otherwise>
	</c:choose>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
