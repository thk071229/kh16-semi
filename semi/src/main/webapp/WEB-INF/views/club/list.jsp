<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.grid {
  display: grid !important;
  gap: 16px !important;
  grid-template-columns: repeat(4, 1fr) !important; /* 4열 강제 */
}
.card {
    max-width: 260px !important; /* 카드 최대 너비 (컨테이너 크기에 맞게 조절) */
    width: 100% !important;
}
.pagination { /* 페이지 네비게이션 스타일 (기본 예시) */
    list-style: none; padding: 0; margin: 20px 0; display: flex; justify-content: center; gap: 5px;
}
.pagination a {
    display: inline-block; padding: 5px 10px; border: 1px solid #ddd; text-decoration: none; color: var(--ink); border-radius: 4px;
}
.pagination a.on {
    background-color: var(--primary); color: white; border-color: var(--primary); font-weight: bold;
}
.pagination a:hover:not(.on) {
    background-color: #eee;
}
</style>
<%-- 좋아요 관련 javaSciprt 코드 --%>
<c:if test="${sessionScope.loginId != null && sessionScope.loginLevel != '관리자'}">
	<script type="text/javascript">
		$(function(){
			$(".club-like").on("click",function(){
				$.ajax({
					url:"/rest/club/action",
					method:"post",
					data:{clubNo : clubNo},
					success:function(response){
						
					}
				})				
			});
		});
	</script> 
</c:if>
<div class="container mt-30"> <%-- 전체 컨테이너 --%>
    <h2>전체 소모임 목록</h2>

    <div class="grid mt-20"> <%-- 카드 목록 그리드 (4열) --%>

        <c:forEach var="club" items="${clubList}"> <%-- 컨트롤러에서 전달한 clubList 반복 --%>
            <div class="card"> <%-- 카드 기본 스타일 --%>
                <div> <%-- 이미지 영역 --%>
                    <c:choose>
                        <c:when test="${club.clubProfile != null}">
                            <img src="/attachment/download?attachmentNo=${club.clubProfile}" alt="${club.clubName} 프로필" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:when>
                        <c:otherwise>
                            <img src="/images/error/no-image.png" alt="기본 이미지" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="v-stack" style="padding: 16px;"> <%-- 내용을 위한 세로 스택 + 카드 내부 패딩 --%>
                    <div class="kicker"> <%-- 작은 텍스트 스타일 (지역 | 카테고리) --%>
                        <span>${club.regionName}</span> | <span>${club.categoryName}</span>
                    </div>
                    <h4 style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${club.clubName}</h4> <%-- 모임 이름 --%>
                    <div class="h-stack"> <%-- 가로 스택 (좋아요 수) --%>
                        <span class="ms-10 club-like-count">
                        <i class="fa-regular fa-heart red club-like"></i>${club.clubLike}개
                        </span> <%-- 빨간색 하트 + 좋아요 수 --%>
                    </div>
                    <a href="/club/home?clubNo=${club.clubNo}" class="btn btn-ghost mt-10">자세히 보기</a> <%-- 고스트 버튼 + 상단 여백 --%>
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