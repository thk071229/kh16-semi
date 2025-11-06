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

<%-- club-like.js 불러오기 --%>
<c:if test="${sessionScope.loginId != null && sessionScope.loginLevel != '관리자'}">
	<script src="${pageContext.request.contextPath}/js/club-like.js"></script>
</c:if>
<!-- ajax 코드 -->
<script type="text/javascript">
	$(function() {
		var size = 4;
		var increase = 4;
		//최초 목록 호출
		loadList();
		
		//더보기 버튼 이벤트
		$(".btn-more").on("click", function(){
			size += increase;
			console.log("size=" + size);
			loadList();
			
		});
		function loadList() {
			
		
		$.ajax({
			url:"/rest/more/club",
			method:"POST",
			data:{
				page:1,
				size:size
			},
			success:function(response){
				var list = response.list;
				console.log("진행" + list);
				if(list.length == 0){
					return;
				}
				
				$(".club-list-wrapper").empty();
				
				//목록 화면 생성
				for(var i = 0; i < list.length; i++){
					var clubList = list[i];
					
					//템플릿 불러와서
					var origin = $("#club-list-template").text();
					//html로 재해석
					var html = $.parseHTML(origin);
					
					if(clubList.clubProfile != null){
					$(html).find(".club-image").attr("src", "/attachment/download?attachmentNo=" + clubList.clubProfile)
											   .attr("alt", clubList.clubName);
					}
					else{
						$(html).find(".club-image").attr("src", "/images/error/no-image.png")
						   						   .attr("alt", "기본 이미지");
					}
					$(html).find(".club-region").text(clubList.regionName);
					$(html).find(".club-category").text(clubList.categoryName);
					$(html).find(".member-count").text("회원 수:" + clubList.memberCount + "명");
					$(html).find(".club-name").text(clubList.clubName);
					$(html).find(".like-area").attr("data-club-no", clubList.clubNo);
					$(html).find(".like-count-value").text(clubList.clubLike);
					$(html).find(".club-number").attr("href", "/club/home?clubNo=" + clubList.clubNo);
					
					$(".club-list-wrapper").append(html);
					
				}//반복문 종료
				
				//button 실행 조건
				if(response.hasMore == false){
					$(".btn-more").hide();
					$(".btn-more").parent().append("<div><h3 class='center'>더이상 게시글이 없습니다</h3></div>");
				}
				else{
					$(".btn-more").show();
					
				}
			}//성공 함수 종료
		 });//ajax 종료
		}//목록 함수 종료
	});
</script>
<!-- 추가될 템플릿 -->
<script type="text/template" id="club-list-template">
	<div class="club-list">
            <div class="card mt-20"> <%-- 카드 기본 스타일 --%>
                <div> <%-- 이미지 영역 --%>
     				<img class="club-image" onerror="this.onerror=null; this.src='/images/error/no-image.png';" style="width:100%; height:auto; aspect-ratio: 4/3; object-fit: cover; border-radius: var(--radius-sm) var(--radius-sm) 0 0;">
                </div>
                <div class="v-stack" style="padding: 16px;"> <%-- 내용을 위한 세로 스택 + 카드 내부 패딩 --%>
                    <h4 class="club-name" style="margin: 4px 0 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display:block;">모임 이름</h4> <%-- 모임 이름 --%>
                    <div class="kicker"> <%-- 작은 텍스트 스타일 (지역 | 카테고리) --%>
                        <span class="club-region">지역명</span>
                    </div>
                    <div class="kicker">
                   		<span class="club-category">카테고리명</span>
                    </div>
                    <div class="kicker">
                   		<span class="member-count">회원 수</span>
                    </div>
                    <div class="h-stack like-area"> <%-- 가로 스택 (좋아요 수) --%>
                        <span class="ms-10 like-count">
                        <i class="fa-regular fa-heart red toggle-like"></i>
                        <span class="like-count-value">좋아요 수</span>
                        </span> <%-- 빨간색 하트 + 좋아요 수 --%>
                    </div>
                    <a class="btn btn-ghost mt-10 club-number">자세히 보기</a> <%-- 고스트 버튼 + 상단 여백 --%>
                </div>
            </div>
	</div>
</script>

<div class="container mt-30"> <%-- 전체 컨테이너 --%>
    <h2>전체 소모임 목록</h2>
	
	<!-- ajax로 바뀌는 영역 -->
	
	<div class="club-list-wrapper grid mt-30"><%-- 카드 목록 그리드 (4열) --%>
    	<h2>아직 등록된 모임이 없습니다</h2>
    </div>
    
	<div class="button-wrapper mt-20">
		<button type="button" class="btn btn-common btn-more w-100">전체 모임 더보기</button>
	</div>
	
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>