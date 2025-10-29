<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    /* 완료 페이지 전용 스타일 */
    .finish-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 400px; /* 최소 높이를 줘서 페이지가 너무 짧아 보이지 않게 */
        text-align: center;
    }
    .finish-icon {
        font-size: 4em; /* 4배 크기 */
        color: var(--primary); /* 메인 색상 */
        margin-bottom: 20px;
    }
    .finish-title {
        font-size: 2em; /* 2배 크기 */
        font-weight: 700;
        color: var(--ink);
        margin-bottom: 10px;
    }
    .finish-message {
        font-size: 1.1em;
        color: var(--subtle);
        margin-bottom: 30px;
    }
    .finish-buttons {
        display: flex;
        gap: 15px; /* 버튼 사이 간격 */
    }
</style>

<div class="container w-600">
    <div class="cell finish-container">
        
        <%-- 아이콘 --%>
        <div class="finish-icon">
            <i class="fa-solid fa-circle-check"></i>
        </div>
        
        <%-- 제목 --%>
        <h1 class="finish-title">모임 개설이 완료되었습니다!</h1>
        
        <%-- 설명 --%>
        <p class="finish-message">
            이제 모임 홈에서 멤버들을 모집하고 활동을 시작해 보세요.
        </p>
        
        <%-- 버튼 영역 --%>
        <div class="finish-buttons">
            <a href="/" class="btn btn-ghost">메인으로 가기</a>
            
            <c:if test="${clubDto.clubNo != null}">
                <a href="/club/home?clubNo=${clubDto.clubNo}" class="btn btn-primary">개설한 모임 홈 가기</a>
            </c:if>
        </div>

    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>