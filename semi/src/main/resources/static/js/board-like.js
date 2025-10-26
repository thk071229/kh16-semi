	//좋아요 확인 처리 ajax
	$(function(){
		//파라미터 읽어오는 코드 추가
		var params = new URLSearchParams(location.search);
		var boardNo = params.get("boardNo");
		
		$.ajax({
			url:"/rest/board/check?boardNo="+boardNo,
			method:"get",
			success:function(response){
				$("#board-like-count").text(response.count);
					if(response.like){//좋아요 설정 했을경우 - 이모지 변경
						$("#board-like").removeClass("fa-solid fa-regular").addClass("fa-solid");
					}
					else{//좋아요 해제 했을 경우 - 이모지 변경
						$("#board-like").removeClass("fa-solid fa-regular").addClass("fa-regular");
					}
			}
		});
		
	});
	//좋아요 관련 처리 ajax
		$(function(){
			var params = new URLSearchParams(location.search);
			var boardNo = params.get("boardNo");
			
			//하트에 클릭이벤트를 걸어서 /action 으로 신호 전송
			$("#board-like").on("click", function(){
				$.ajax({
					url:"/rest/board/action?boardNo="+boardNo,
					method:"post",
					success:function(response){
						$("#board-like-count").text(response.count);
						if(response.like){//좋아요 설정 시
							$("#board-like").removeClass("fa-solid fa-regular").addClass("fa-solid");
						}
						else{//좋아요 해제 시
							$("#board-like").removeClass("fa-solid fa-regular").addClass("fa-regular");
						}
					}
					
				});
				
			});
		});
