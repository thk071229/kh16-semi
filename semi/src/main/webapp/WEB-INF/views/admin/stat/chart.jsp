<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Swiper CDN -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/js/chart.js"></script>
<script src="${pageContext.request.contextPath}/js/swiper.js"></script>

<style>
	.swiper {
	    width: 100%;       /* 700px 기준 */
	    height: 500px; 
	}
	.swiper-slide {
	    display: flex;
	    flex-direction: column;
	    justify-content: center;  /* 세로 중앙 */
	    align-items: center;      /* 가로 중앙 */
	    height: 100%;             /* swiper-wrapper 전체 높이 차지 */
	}

	   .swiper-slide canvas {
	    width: 80%;           /* 가로 폭 */
	    height: auto;         /* 높이는 자동으로 비율 유지 */
	    max-height: 350px;    /* 높이 제한 */
	}

    .swiper-slide {
        display: flex;
        flex-direction: column;  
        justify-content: flex-start; 
        align-items: center;     
    }
    .swiper-slide canvas {
    margin-top: 0;
    padding: 0;
	}
    
    .swiper-button-next,
    .swiper-button-prev {
        box-shadow: none !important;
        background: none !important;
        color: var(--primary);
    }
    .swiper-button-next,
    .swiper-button-prev:hover {
        color: var(--primary-600);
    }
    .swiper-pagination-bullet {
        background: gray;
    }
    .swiper-pagination-bullet-active {
        background: var(--primary);
    }
</style>

<div class="container w-750">
    <div class="cell center">
        <h1>홈페이지 현황</h1>
    </div>

    <!-- Swiper 슬라이더 -->
    <div class="swiper cell">
        <div class="swiper-wrapper">

            <!-- 모임 카테고리 -->
            <div class="swiper-slide">
                <h2>카테고리 별 모임 현황</h2>
                <canvas id="club-category-chart"></canvas>
            </div>

            <!-- 모임 지역 -->
            <div class="swiper-slide">
                <h2>지역 별 모임 현황</h2>
                <canvas id="club-region-chart"></canvas>
            </div>

            <!-- 정모 카테고리 -->
            <div class="swiper-slide">
                <h2>카테고리 별 정모 수 현황</h2>
                <canvas id="event-category-chart"></canvas>
            </div>

            <!-- 정모 지역 -->
            <div class="swiper-slide">
                <h2>지역 별 정모 수 현황</h2>
                <canvas id="event-region-chart"></canvas>
            </div>

            <!-- 회원 카테고리 -->
            <div class="swiper-slide">
                <h2>카테고리 별 회원 현황</h2>
                <canvas id="member-category-chart"></canvas>
            </div>

            <!-- 회원 지역 -->
            <div class="swiper-slide">
                <h2>지역 별 회원 현황</h2>
                <canvas id="member-region-chart"></canvas>
            </div>

            <!-- 회원 성비 -->
            <div class="swiper-slide">
                <h2>회원 성별 비율</h2>
                <canvas id="member-gender-chart"></canvas>
            </div>

            <!-- 회원 나이비율 -->
            <div class="swiper-slide">
                <h2>회원 나이 비율</h2>
                <canvas id="member-age-chart"></canvas>
            </div>

            <!-- 랭킹 차트 -->
            <div class="swiper-slide">
                <h2>회원 수 많은 모임</h2>
                <canvas id="club-ranking-chart"></canvas>
            </div>
            
            <div class="swiper-slide">
                <h2>활동이 활발한 모임(정모 순)</h2>
                <canvas id="event-ranking-chart"></canvas>
            </div>
            
            <div class="swiper-slide">
                <h2>활동이 활발한 모임(게시글 순)</h2>
                <canvas id="board-ranking-chart"></canvas>
            </div>
            
            <div class="swiper-slide">
                <h2>활동이 활발한 회원</h2>
                <canvas id="member-ranking-chart"></canvas>
            </div>
            
            <div class="swiper-slide">
                <h2>인기 지역 순위</h2>
                <canvas id="region-ranking-chart"></canvas>
            </div>
            
            <div class="swiper-slide">
                <h2>인기 카테고리 순위</h2>
                <canvas id="category-ranking-chart"></canvas>
            </div>
            
        </div>

        <!-- 네비게이션 버튼 -->
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
        <!-- 페이지 점 -->
        <div class="swiper-pagination"></div>
    </div>
</div>

