<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
.region-name {
  display: inline-block; 
  max-width: 13ch;            /* 글자 단위로 9글자 너비 제한 */
  overflow: hidden;          /* 넘친 글자 숨김 */
  text-overflow: ellipsis;   /* ... 으로 표시 */
  white-space: nowrap;       /* 줄바꿈 방지 */
}
</style>
<!-- header -->
<jsp:include page="/WEB-INF/views/template/main-header.jsp"></jsp:include>	
<div class = "container">
<h1>메인 페이지</h1>
<h2>소모임 - 우리동네 취미 모임</h2>
<h4>소개글</h4>
<label>
<i class="fa-solid fa-location-dot"></i>
서울시 강남구(header에 있는 button-span value 불러오기) 근처 모임
</label>
<!-- 추후 table로 구현  -->

<h4>활동이 활발한 모임 (이벤트)</h4>
	<div class="grid mt-20">
	<c:forEach var="eventCountVO" items="${clubEventCountVO}" varStatus="status">
			<div class="card">
				<div> <%-- 이미지 영역 --%>
                    <c:choose>
                        <c:when test="${eventCountVO.clubProfile != null}">
                        <%-- 액박을 해결하는 onerror 추가 --%>
                            <img src="/attachment/download?attachmentNo=${eventCount.clubProfile}" alt="${eventCount.clubName}" 
                            onerror="this.onerror=null; this.src='/images/error/no-image.png';" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/error/no-image.png" alt="기본 이미지" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;"> <%-- 이미지 스타일 + 상단 모서리 둥글게 --%>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="v-stack center" style="padding: 16px;"> <%-- 내용을 위한 세로 스택 + 카드 내부 패딩 --%>
                    <h4 style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${eventCountVO.clubName}</h4> <%-- 모임 이름 (기본 스타일 + 줄바꿈 방지) --%>
                    <div class="h-stack">
                    <div class="v-stack kicker center"> <%-- 작은 텍스트 스타일 (지역 | 카테고리) --%>
                        <span class="region-name">${eventCountVO.regionName}</span>
                        <span>${eventCountVO.categoryName}</span>
                     </div>
                    <div class="v-stack kicker center"> <%-- 작은 텍스트 스타일 (지역 | 카테고리) --%>
                        <span> 멤버 ${eventCountVO.memberCount}</span>
						<span>정모 ${eventCountVO.eventCount}</span>
                    </div>
                    </div>
                    <a href="/club/home?clubNo=${eventCountVO.clubNo}" class="btn btn-ghost mt-10">자세히 보기</a> <%-- 고스트 버튼 + 상단 여백 --%>
                </div>
            </div>
		</c:forEach>
	</div>
		
	

<h4>활동이 활발한 모임 (게시글)</h4>
	<div class="grid mt-20">
	<c:forEach var="boardCountVO" items="${clubBoardCountVO}" varStatus="status">
			<div class="card">
				<div> <%-- 이미지 영역 --%>
                    <c:choose>
                        <c:when test="${boardCountVO.clubProfile != null}">
                        <%-- 액박을 해결하는 onerror 추가 --%>
                            <img src="/attachment/download?attachmentNo=${boardCount.clubProfile}" alt="${boardCount.clubName}" 
                            onerror="this.onerror=null; this.src='/images/error/no-image.png';" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/error/no-image.png" alt="기본 이미지" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;"> <%-- 이미지 스타일 + 상단 모서리 둥글게 --%>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="v-stack center" style="padding: 16px;"> <%-- 내용을 위한 세로 스택 + 카드 내부 패딩 --%>
                    <h4 style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${boardCountVO.clubName}</h4> <%-- 모임 이름 (기본 스타일 + 줄바꿈 방지) --%>
                    <div class="h-stack">
                    <div class="v-stack kicker center"> <%-- 작은 텍스트 스타일 (지역 | 카테고리) --%>
                        <span class="region-name">${boardCountVO.regionName}</span>
                        <span>${boardCountVO.categoryName}</span>
                     </div>
                    <div class="v-stack kicker center"> <%-- 작은 텍스트 스타일 (지역 | 카테고리) --%>
                        <span> 멤버 ${boardCountVO.memberCount}</span>
						<span> 게시글 ${boardCountVO.boardCount}</span>
                    </div>
                    </div>
                    <a href="/club/home?clubNo=${boardCountVO.clubNo}" class="btn btn-ghost mt-10">자세히 보기</a> <%-- 고스트 버튼 + 상단 여백 --%>
                </div>
            </div>
		</c:forEach>
	</div>





<h4><button type = "button">더보기</button></h4>
<h4>내 근처에서 시작되는 정모</h4>
<img src = "https://dummyimage.com/600x300/000/fff&text=club_2">
<h4><button type = "button">더보기</button></h4>
<h4>카테고리 별 모임</h4>
<img src = "https://dummyimage.com/600x300/000/fff&text=club_3">
<h4><button type = "button">더보기</button></h4>
<hr>
</div>
<!-- footer -->
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	