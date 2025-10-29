/* 전체 소모임 좋아요에 적용할 js - class 및 id, data를 적용
	좋아요 기능은 관리자나 비회원은 이용 불가능하기 때문에
	<c:if test="${sessionScope.loginId != null && sessionScope.loginLevel != '관리자'}">
	</c:if>
	로 감싸면 됨
*/
$(function() {
	//먼저 clubNo를 가져올 수 있게 전체에서 검색
	$(".grid").on("click", ".toggle-like", function() {
		var $icon = $(this);//클릭된 아이콘 저장(jQuery 객체를 담고있다는 coding convention)
		var $likeArea = $icon.closest(".like-area");
		var clubNo = $likeArea.data("club-no");
		var $countSpan = $likeArea.find(".like-count-value");

		if (!clubNo) return;

		$.ajax({
			url: "/rest/club/action",
			method: "post",
			data: { clubNo: clubNo },
			success: function(response) {
				$icon.removeClass("fa-regular fa-solid").addClass(response.like ? "fa-solid" : "fa-regular");
				$countSpan.text(response.count);
			},
			error: function() {
				alert("좋아요 처리 중 오류가 발생했습니다");
			}
		})
	});
	$(".like-area").each(function() {
		var $likeArea = $(this);
		var clubNo = $likeArea.data("club-no");
		var $icon = $likeArea.find(".toggle-like");
		var $countSpan = $likeArea.find(".like-count-value");

		if (!clubNo) return;

		$.ajax({
			url: "/rest/club/check",
			method: "post",
			data: { clubNo: clubNo },
			success: function(response) {
				$icon.removeClass("fa-regular fa-solid").addClass(response.like ? "fa-solid" : "fa-regular");
				$countSpan.text(response.count);
			}
		})
	});
});

