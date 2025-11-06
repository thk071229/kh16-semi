<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
 /* 푸터 전체 영역 스타일 */
    .footer-wrapper {
        background-color: var(--bg); /* 연한 배경색 */
        color: var(--subtle); /* 기본 글자색 */
        padding: 40px 0; /* 위아래 여백 */
        border-top: 1px solid var(--muted); /* 상단 구분선 */
        font-size: 14px; /* 기본 폰트 크기 */
        line-height: 1.6;
    }

    /* 푸터 내부 컨테이너 */
    .footer-container {
        /* (commons.css의 .container 사용) */
    }

    /* 푸터 링크 스타일 초기화 */
    .footer-wrapper a {
        text-decoration: none;
        color: inherit; /* 부모 글자색(var(--subtle)) 상속 */
    }
    .footer-wrapper a:hover {
        color: var(--ink); /* 호버 시 진한 글자색 */
        text-decoration: underline;
    }

    /* 푸터 제목 (h3) */
    .footer-wrapper h3 {
        color: var(--ink); /* 제목은 진하게 */
        font-size: 16px;
        margin-top: 0;
        margin-bottom: 12px;
    }

    /* 푸터 내용 (h5, p) */
    .footer-wrapper h5,
    .footer-wrapper p {
        margin: 4px 0;
        font-size: 14px;
        font-weight: 400; /* h5 태그 굵기 초기화 */
    }
</style>

<footer class="footer-wrapper">
    <div class="container footer-container">

        <div class="cell flex-box" style="gap: 40px;"> 
            
            <div class="cell v-stack left" style="flex: 1;">
                    <h3>소모임</h3>
                <a href="${pageContext.request.contextPath}/etc/mainExplain"><h5>소소란</h5></a>
                <a href="${pageContext.request.contextPath}/etc/query"><h5>자주하는 질문</h5></a>
                <a href="${pageContext.request.contextPath}/icon"><h5>아이콘 설명</h5></a>
            </div>

            <div class="cell v-stack left" style="flex: 1;">
                    <h3>서비스 정책</h3>
                <a href="${pageContext.request.contextPath}/etc/serviceAgree"><h5>이용약관</h5></a>
                <a href="${pageContext.request.contextPath}/etc/agree"><h5>개인정보 처리방침</h5></a>
            </div>

            <div class="cell v-stack left" style="flex: 2;"> 
                    <h3>(주)프렌즈큐브</h3>
                <h5>대표: 김영민 | 사업자번호: 129-86-64139</h5>
                <h5>통신판매업 신고번호: 2014-경기성남-1490</h5>
                <h5>고객센터: help@friendscube.com</h5>
            </div>
            
        </div>
    </div>
</footer>