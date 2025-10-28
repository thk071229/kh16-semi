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

<c:if test="${sessionScope.loginId != null && sessionScope.loginLevel != '관리자'}">
	<script type="text/javascript">
		$(function(){
			//먼저 clubNo를 가져올 수 있게 전체에서 검색
			$(".grid").on("click",".club-like-btn",function(){
				var $icon = $(this);//클릭된 아이콘 저장(jQuery 객체를 담고있다는 coding convention)
				var $likeArea = $icon.closest(".club-like-area");
				var clubNo = $likeArea.data("club-no");
				var $countSpan = $likeArea.find(".like-count-value");
				
				if(!clubNo) return;
				
				$.ajax({
					url:"/rest/club/action",
					method:"post",
					data:{clubNo : clubNo},
					success:function(response){
						$icon.removeClass("fa-regular fa-solid").addClass(response.like ? "fa-solid" : "fa-regular");
						$countSpan.text(response.count);
					},
					error:function(){
						alert("좋아요 처리 중 오류가 발생했습니다");
					}
				})
			});
			$(".club-like-area").each(function(){
				var $likeArea = $(this);
				var clubNo = $likeArea.data("club-no");
				var $icon = $likeArea.find(".club-like-btn");
				var $countSpan = $likeArea.find(".like-count-value");
				
				if(!clubNo) return;
				
				$.ajax({
					url:"/rest/club/check",
					method:"post",
					data:{clubNo : clubNo},
					success:function(response){
						$icon.removeClass("fa-regular fa-solid").addClass(response.like ? "fa-solid" : "fa-regular");
						$countSpan.text(response.count);
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
                    <h4 style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display:block;">${club.clubName}</h4> <%-- 모임 이름 --%>
                    <div class="h-stack club-like-area" data-club-no="${club.clubNo}"> <%-- 가로 스택 (좋아요 수) --%>
                        <span class="ms-10 club-like-count">
                        <i class="fa-regular fa-heart club-like-btn red"></i>
                        <span class="like-count-value">${club.clubLike}</span>
                        </span> <%-- 빨간색 하트 + 좋아요 수 --%>
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