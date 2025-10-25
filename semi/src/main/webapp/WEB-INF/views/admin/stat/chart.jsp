<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!-- chartjs cdn -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- swiper cdn -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
<script src="/js/chart.js"></script>
<script src="/js/swiper.js"></script>
<style>
	.swiper-slide canvas { 
	width: 100%; 
	height: 400px;
	max-width: 80%; 
	
	}
	.swiper-slide {
		display: flex;
		flex-direction: column;  /* 세로 배치 */
    	justify-content: center; /* 수평 중앙 */
    	align-items: center;     /* 수직 중앙 */
	}
	
	.swiper-button-next,
	.swiper-button-prev {
  		box-shadow: none !important;
  		background: none !important;
  		color: var(--primary);
	}
	
	.swiper-button-next,
	.swiper-button-prev:hover {
  		box-shadow: none !important;
  		background: none !important;
  		color: var(--primary-600);
	}
	/* 기본 원 색상 */
	.swiper-pagination-bullet {
    background: gray;  /* 원하는 색상 */
	}

	/* 활성 상태 원 색상 */
	.swiper-pagination-bullet-active {
    background: var(--primary);  /* 활성 색상 */
	}
	
</style>
<div class="container w-700">
    <div class="cell center">
        <h1>홈페이지 현황</h1>
    </div>

    <!-- Swiper 슬라이더 시작 -->
    <div class="swiper cell">
        <div class="swiper-wrapper">
            <!-- 카테고리별 모임 차트 -->
            <div class="swiper-slide">
                <h2>카테고리 별 모임 현황</h2>
                <canvas id="club-category-chart"></canvas>
            </div>

            <!-- 지역별 모임 차트 -->
            <div class="swiper-slide">
                <h2>지역 별 모임 현황</h2>
                <canvas id="club-region-chart"></canvas>
            </div>
			<!-- 카테고리별 정모 차트(종료된 정모만 조회) -->
          	<div class="swiper-slide">
                <h2>카테고리 별 정모 수 현황</h2>
                <canvas id="event-category-chart"></canvas>
            </div>
           <!-- 지역별 정모 차트(종료된 정모만 조회) -->
          	<div class="swiper-slide">
                <h2>지역 별 정모 수 현황</h2>
                <canvas id="event-region-chart"></canvas>
            </div>
        </div>

        <!-- 네비게이션 버튼 -->
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>

        <!-- 페이지 점 -->
        <div class="swiper-pagination"></div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>