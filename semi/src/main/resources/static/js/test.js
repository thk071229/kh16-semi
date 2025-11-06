// /js/club-like-list-more.js

$(function(){ // HTML 문서가 로드되면 실행
	
	// --- 1. 요소 선택 ---
	var $grid = $("#club-like-grid"); // 찜 목록을 추가할 그리드
	var $loadMoreButton = $("#btn-more-like"); // 찜 목록 더보기 버튼
	var $noMoreDataMsg = $loadMoreButton.closest(".pagination-more").find(".no-data"); // "더 이상 없음" 메시지
	var $template = $("#club-like-template"); // 찜 목록 카드 템플릿

	// 더보기 버튼이나 템플릿이 없으면, "더보기" 기능이 없는 페이지이므로 스크립트 중단
	if($loadMoreButton.length === 0 || $template.length === 0) {
		return; 
	}

	// --- 2. 초기 페이지 정보 설정 ---
	var itemsPerPage = parseInt($loadMoreButton.data("page-size")); // 한 번에 불러올 개수 (JSP에서 전달)
	var dataCount = parseInt($loadMoreButton.data("total-count")); // 전체 개수 (JSP에서 전달)
	var currentPage = 1; // 현재 로드된 페이지 (1페이지는 JSP가 이미 그림)
	var initialItemCount = $grid.find(".card").length; // 현재 표시된 아이템 수
	var isLoading = false; // 중복 요청 방지 플래그

	// --- 3. 초기 버튼 상태 확인 ---
	// dataCount가 숫자가 아니거나, 이미 모든 아이템이 로드되었다면 버튼 숨김
	if (isNaN(dataCount) || isNaN(itemsPerPage) || initialItemCount >= dataCount) {
		$loadMoreButton.hide();
		// 처음부터 아이템이 있었던 경우에만 "더 이상 없음" 표시
		if (initialItemCount > 0 && initialItemCount >= dataCount) {
            $noMoreDataMsg.show();
        }
	} else {
	    $noMoreDataMsg.hide(); // 불러올 데이터가 더 있으면 숨김
	}

	// --- 4. "더보기" 버튼 클릭 이벤트 ---
	$loadMoreButton.on("click", function(){
		if(isLoading) return; // 로딩 중이면 중복 클릭 방지
		isLoading = true;
		currentPage++; // 다음 페이지 요청
		$loadMoreButton.prop("disabled", true).text("로딩 중..."); // 버튼 비활성화

		// --- 5. AJAX 요청 ---
		$.ajax({
			url: contextPath+"/rest/more/recommendClub", // 찜 목록용 REST 컨트롤러
			method: "post", // 컨트롤러가 POST를 받으므로
			data: {
				page: currentPage,
				size: itemsPerPage
			},
			success: function(moreClubList) { // List<ClubCountVO> JSON 받음
				if (moreClubList && moreClubList.length > 0) {
					
					// --- 6. 템플릿 복제 및 데이터 채우기 ---
					$.each(moreClubList, function(index, club){
						var $newCard = $($template.html()); // 템플릿 복제

						// 데이터 채우기
						if(club.clubProfile) {
							$newCard.find(".card-image-placeholder")
								.attr("src", contextPath+"/attachment/download?attachmentNo=" + club.clubProfile)
								.attr("alt", club.clubName)
								.on("error", function() { $(this).attr("src", "/images/error/no-image.png"); });
						}
						$newCard.find(".card-title").text(club.clubName);
						
						// [수정됨] .kicker span:last-child 대신 .category-name 클래스로 직접 찾기
						$newCard.find(".region-name").text(club.regionName || '');
						$newCard.find(".category-name").text(club.categoryName || ''); 

						$newCard.find(".member-count").text(club.memberCount);
						$newCard.find(".event-count").text(club.eventCount);
						$newCard.find(".like-area").attr("data-club-no", club.clubNo);
						$newCard.find(".like-count-value").text(club.clubLike);
						$newCard.find(".detail-link").attr("href", "/club/home?clubNo=" + club.clubNo);

						// (선택) 초기 좋아요 상태 반영 (RestController에서 club.liked 값을 보내줬다면)
						if(club.liked) {
						   $newCard.find(".like-icon").removeClass("fa-regular").addClass("fa-solid");
						}
						
						$grid.append($newCard); // 그리드에 추가
					});

					// --- 7. 버튼 상태 업데이트 ---
					var totalItemCount = $grid.find(".card").length;
					if (totalItemCount >= dataCount) {
						$loadMoreButton.hide();
						$noMoreDataMsg.show();
					} else {
						$loadMoreButton.prop("disabled", false).text("더보기");
					}
				} else {
					// 서버에서 빈 리스트를 받으면 (더 이상 데이터 없음)
					$loadMoreButton.hide();
					$noMoreDataMsg.show();
				}
				isLoading = false; // 로딩 완료
			},
			error: function(){
				alert("목록 로딩 중 오류 발생");
				$loadMoreButton.prop("disabled", false).text("더보기");
				isLoading = false; // 에러 시에도 로딩 해제
			}
		}); // AJAX 끝
	}); // click 이벤트 끝
}); // $(function) 끝