$(function(){
    // 기존 모임/정모 차트
    createChart(contextPath+"/rest/admin/stat/club/category", "#club-category-chart", "doughnut", "모임 수");
    createChart(contextPath+"/rest/admin/stat/club/region", "#club-region-chart", "doughnut", "모임 수");
    createChart(contextPath+"/rest/admin/stat/event/category", "#event-category-chart", "doughnut", "정모 수");
    createChart(contextPath+"/rest/admin/stat/event/region", "#event-region-chart", "doughnut", "정모 수");

    // 새로 추가된 회원 관련 차트
    createChart(contextPath+"/rest/admin/stat/member/category", "#member-category-chart", "doughnut", "회원 수");
    createChart(contextPath+"/rest/admin/stat/member/region", "#member-region-chart", "doughnut", "회원 수");
    createChart(contextPath+"/rest/admin/stat/member/gender", "#member-gender-chart", "doughnut", "회원 수");
    createChart(contextPath+"/rest/admin/stat/member/age", "#member-age-chart", "doughnut", "회원 수");
	
	//랭킹 관련 차트
	createChart(contextPath+"/rest/admin/stat/club/ranking", "#club-ranking-chart", "bar", "회원 수");
	createChart(contextPath+"/rest/admin/stat/event/ranking", "#event-ranking-chart", "bar", "정모 수");
	createChart(contextPath+"/rest/admin/stat/board/ranking", "#board-ranking-chart", "bar", "작성 게시글 수");
	createChart(contextPath+"/rest/admin/stat/member/ranking", "#member-ranking-chart", "bar", "정모 참여 + 작성 게시글 및 댓글 수");
	createChart(contextPath+"/rest/admin/stat/region/ranking", "#region-ranking-chart", "bar", "회원 및 모임 수");
	createChart(contextPath+"/rest/admin/stat/category/ranking", "#category-ranking-chart", "bar", "회원 및 모임 수");
	
	// 공통 차트 생성 함수
    function createChart(url, selector, chartType, label){
        $.ajax({
            url: url,
            method: "POST",
            success: function(response){
                new Chart($(selector)[0], {
                    type: chartType,
                    data: {
                        labels: response.labels,
                        datasets: [{
                            label: label,
                            data: response.data,
                            borderWidth: 1,
                            backgroundColor: [
                                '#BFE6D8', '#FFB6B9', '#FFE156', '#6A4C93', '#6A9FB5', '#FF6F61'
                            ],
                        }]
                    },
					options: {
					    responsive: true,
					    layout: {
					        padding: {
					            top: 0,
					            bottom: 0,
					            left: 0,
					            right: 0
					        }
					    },
					    plugins: {
					        legend: {
					            position: 'right',
					        }
					    },
					    scales: {
					        y: {
					            beginAtZero: true
					        }
					    }
					}

                });
            }
        });
    }
});
