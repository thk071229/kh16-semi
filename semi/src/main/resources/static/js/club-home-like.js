$(function(){
	var params = new URLSearchParams(location.search);
	var clubNo = params.get("clubNo");
	
	$("#club-like").on("click", function(){ // ID로 클릭 이벤트
		$.ajax({
			url:"/rest/club/action", // 상태 변경
			method:"post",
			data:{clubNo : clubNo},
			success: function(response){
				// 클릭 결과(변경된 상태)로 아이콘과 숫자 업데이트
				$("#club-like").removeClass("fa-regular fa-solid").addClass(response.like ? "fa-solid" : "fa-regular");
				$("#club-like-count").text(response.count);
			},
			error: function() {
				alert("좋아요 처리 중 오류가 발생했습니다.");
			}
		})
	});
});