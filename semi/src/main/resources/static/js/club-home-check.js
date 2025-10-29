$(function(){
		// 삭제 확인 스크립트
		$(".check-club-delete").on("click", function(e){
			e.preventDefault(); // 기본 링크 이동 방지
			var isConfirm = confirm("정말 삭제하시겠습니까? 모임 관련 모든 정보(게시글, 정모 등)가 삭제됩니다.");
			if(isConfirm){
				window.location.href = $(this).attr("href"); // 확인 시 링크로 이동
			}
		});
		
		// --- 좋아요 초기 상태 확인 (페이지 로딩 시 1회 실행) ---
		var params = new URLSearchParams(location.search);
		var clubNo = params.get("clubNo");

		// clubNo가 없으면 (잘못된 URL) 중단
		if(!clubNo) return; 

		$.ajax({
			url:"/rest/club/check", // 상태 확인
			method:"post",
			data:{clubNo : clubNo},
			success: function(response){
				// 초기 하트 모양과 숫자 설정
				$("#club-like").removeClass("fa-regular fa-solid").addClass(response.like ? "fa-solid" : "fa-regular");
				$("#club-like-count").text(response.count);
			}
		});
	});