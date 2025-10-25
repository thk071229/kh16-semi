	//차트 생성 ajax
	$(function(){
		//카테고리 별 모임 현황 조회한 뒤 차트 생성
		createChart("/rest/admin/stat/club/category", "#club-category-chart", "bar", "모임 수");
		//지역 별 모임 현황 조회한 뒤 차트 생성
		createChart("/rest/admin/stat/club/region", "#club-region-chart", "bar", "모임 수");
		//카테고리 별 정모 현황(종료된 모임 기준)
		createChart("/rest/admin/stat/event/category", "#event-category-chart", "bar", "모임 수");
		//지역 별 정모 현황(종료된 모임 기준)
		createChart("/rest/admin/stat/event/region", "#event-region-chart", "bar", "모임 수");
		//차트 생성 함수
		function createChart(url, selector, chartType, label){
			$.ajax({
				url:url,
				method:"POST",
				success:function(response){
					console.log(response);
					 
					 // ChartVO 속성 사용(배열로 출력안됨)
					var labels = response.labels;
					var data = response.data;
					var chartType = response.type;
		            var label = response.subject;
					
		            new Chart($(selector)[0], {
						type: chartType,
						data:{
							labels:labels,
							//데이터를 배열 형태로 전송
							datasets: [{
								label:label,
								data:data,
								borderWidth:1,
								backgroundColor: '#BFE6D8',
							}]
						},
						options:{
							scales:{
								y:{
									beginAtZero: true,
								}
							}
						}
					});
				}
			});
		}

	});
