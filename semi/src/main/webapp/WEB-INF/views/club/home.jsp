<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
	$(function(){
		$(".check-club-delete").on("click", function(e){
			e.preventDefault();
			var isConfirm = confirm("정말 삭제하시겠습니까?");
			if(isConfirm){
				window.location.href = $(this).attr("href");
			}
		});
		
	});
</script>
<div class="container w-800">
		<%-- 메뉴 바 --%>
		<div class="cell">
			<div class="flex-box">
				<h2><a href="home?clubNo=${clubDto.clubNo}" class="btn btn-accent">홈</a></h2>
				<h2><a href="/board/list?clubNo=${clubDto.clubNo}" class="btn btn-accent ms-20">게시판</a></h2>
				<h2><a href="/event/list?clubNo=${clubDto.clubNo}" class="btn btn-accent ms-20">정모</a></h2>
			</div>
		</div>
		
		<div class="cell">
        	<div class="flex-box">
        		<h1 class="flex-fill">모임 이름</h1>
        		<%-- 모임장만 표시 되는 관리영역 --%>
        		<c:if test="${loginId == clubDto.clubLeader}">
        		<a href="edit?clubNo=${clubDto.clubNo}">
					<i class="fa-solid fa-pen-to-square fa-2x mt-30 me-10"></i>
				</a>
				<a href="delete?clubNo=${clubDto.clubNo}" class="check-club-delete">
					<i class="fa-solid fa-trash-can fa-2x mt-30"></i>
				</a>
				</c:if>
				
				<%-- 대표사진 영역(없으면 기본 이미지 사용 --%>
				<div class="cell">
					<c:choose>
						<c:when test="${clubDto.clubProfile != null}">
							<img src="/attachment/download?attachmentNo=${clubDto.clubProfile}">
						</c:when>
						<c:otherwise>
							<img src="/images/error/no-image.png">
						</c:otherwise>
					</c:choose>
				</div>
				
        	</div>
        </div>

        <div class="cell">
            <h2>모임 소개</h2>
        </div>
        <div class="cell">
            <pre>${clubDto.clubIntroduce}</pre>
        </div>

        <div class="cell">
            <h2>정모일정</h2>
        </div>
        
        <div class="cell">
            <h2>모임장</h2>
        </div>

        <div class="cell">
        	<div class="flex-box">
            <h2 class="flex-fill">모인 멤버</h2>
            <c:if test="${loginId == clubDto.clubLeader}">
        	<a href="/clubMember/list?clubNo=${clubDto.clubNo}"><%-- 관리페이지 이동 예정 --%>
        	<i class="fa-solid fa-users fa-2x mt-25"></i>관리
        	</a>
        	</c:if>
        	</div>
        </div>
        
        <%-- 1. 로그인 했고, 모임에 가입하지 않았을 경우 --%>
        <c:if test="${loginId != null && clubMemberDto == null}">
	        <form action="/clubMember/join" method="post" autocomplete="off">
		        <div class="cell">
		        		<input type="hidden" name="clubNo" value="${clubDto.clubNo}">
		                <button type="submit" class="btn btn-primary w-100">참여하기</button>
		        </div>
	        </form>
        </c:if>
        
        <%-- 2. 모임에 가입한 경우 (clubMemberDto가 null이 아님) --%>
        <c:if test="${clubMemberDto != null}">
	        <%-- 단, 모임장은 탈퇴 버튼 숨김 (모임 삭제나 위임만 가능) --%>
	        <c:if test="${loginId != clubDto.clubLeader}">
		        <form action="/clubMember/drop" method="post" autocomplete="off">
			        <div class="cell">
			        		<input type="hidden" name="clubNo" value="${clubDto.clubNo}">
			                <button type="submit" class="btn red w-100 club-delete">탈퇴하기</button>
			        </div>
		        </form>
	        </c:if>
        </c:if>

    </div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>