<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

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
				<a href="delete?clubNo=${clubDto.clubNo}">
					<i class="fa-solid fa-trash-can fa-2x mt-30"></i>
				</a>
				</c:if>
				
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
        	<a href="#">
        	<i class="fa-solid fa-users fa-2x mt-25"></i>관리
        	</a>
        	</c:if>
        	</div>
        </div>
        
        <form action="join" method="post" autocomplete="off">
        <div class="cell">
        		<input type="hidden" name="clubNo" value="${clubDto.clubNo}">
                <button type="submit" class="btn btn-primary w-100">참여하기</button>
            </div>
        </form>
        
        <form action="drop" method="post" autocomplete="off">
        <div class="cell">
        		<input type="hidden" name="clubNo" value="${clubDto.clubNo}">
                <button type="submit" class="btn red w-100">탈퇴하기</button>
            </div>
        </form>

    </div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>