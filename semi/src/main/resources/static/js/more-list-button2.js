$(function(){ // HTML 문서가 로드되면 실행될 코드 영역 시작

	// --- 필요한 HTML 요소들을 jQuery 객체로 미리 찾아둠 ---
	var $grid = $(".grid"); // 카드를 추가할 그리드 영역
	var $loadMoreButton = $(".btn-more2"); // "더보기" 버튼
	var $noMoreDataMsg = $(".no-data"); // "더 이상 목록이 없습니다" 메시지 영역

	// --- 초기 데이터 설정 (JSP에서 버튼의 data-* 속성으로 전달받음) ---
	var queryParams = $loadMoreButton.data("query") || ""; // 검색 조건이나 부모 파라미터 (예: "&column=name&keyword=test")
	var dataCount = parseInt($loadMoreButton.data("count")); // 전체 아이템의 총 개수
	// 한 페이지당 보여줄 아이템 개수와 현재 페이지 번호.
	// JSP에서 PageVO 값을 받아와 JS 변수로 설정하는 것이 가장 좋음.
	var itemsPerPage = 10; // !! 중요: 실제 페이지당 아이템 수로 바꿔야 함 (예: parseInt('${pageVO.size}') )
	var currentPage = 1; // 현재 로드된 페이지 번호 (처음엔 1페이지)

	// --- 페이지 로딩 시 초기 상태 확인 ---
	var initialItemCount = $grid.find(".card").length; // 현재 화면에 이미 표시된 카드 개수 세기

	// 총 개수가 유효하지 않거나(숫자가 아니거나), 이미 모든 카드가 로드된 경우
	if (isNaN(dataCount) || initialItemCount >= dataCount) {
		$loadMoreButton.hide(); // "더보기" 버튼 숨기기
		if (initialItemCount > 0) { // 처음부터 아이템이 있었던 경우에만
		    $noMoreDataMsg.show(); // "더 이상 없음" 메시지 보이기
		} else {
            $noMoreDataMsg.hide(); // 처음부터 목록이 비었으면 이 메시지도 숨김
        }
	} else {
	    $noMoreDataMsg.hide(); // 불러올 데이터가 더 있으면 "더 이상 없음" 메시지 숨기기
	}

	// --- "더보기" 버튼 클릭 이벤트 설정 ---
	$loadMoreButton.on("click", function(){ // 버튼을 클릭했을 때 실행될 함수
		currentPage++; // 다음 페이지 번호를 요청하기 위해 페이지 번호 1 증가

		// 버튼을 비활성화하고 텍스트를 "로딩 중..."으로 변경 (중복 클릭 방지 및 상태 표시)
		$loadMoreButton.prop("disabled", true).text("로딩 중...");

        // (이 아래에 AJAX 요청 및 결과 처리 로직이 이어집니다)
    }); // click 이벤트 핸들러 끝
}); // $(function(){ ... }) 끝