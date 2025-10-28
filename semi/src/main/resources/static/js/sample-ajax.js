	$(function(){
		var params = new URLSearchParams(location.search);
		var clubNo = params.get("clubNo");
		var size = 1;
		var increase = 1;
		//최초 목록 호출
		loadList();
		
		//더보기 버튼 이벤트
		$(".btn-more").on("click", function(){
			size += increase;
			console.log("size=" + size);
			loadList();
			
		});
		
		//목록 불러오는 함수
		function loadList(){

			$.ajax({
				url:"/rest/more/board",
				method:"POST",
				data:{
					page: 1,
					size: size,
					clubNo:clubNo,
				},
				success:function(response){//response == Map(list와 noticeCount가 들어있음)
					console.log(response);
					console.log(size)
					//list가 비어있을 경우 아무것도 하지 않음
					var list = response.list;
				
					if(list.length == 0){
						return;
					}
					
					$(".board-list-wrapper").empty();
					//목록 화면 생성
					for(var i = 0 ; i < list.length ; i++){
						var boardList = list[i];
						
						//템플릿 불러와서
						var origin = $("#board-list-template").text();
						//html로 재해석
						var html = $.parseHTML(origin);
						//공지글 효과 위한 class
						if(i < response.noticeCount){
							$(html).find(".board-list").addClass("notice");
						}
						$(html).find(".member-profile").prop("src", "/member/profile?memberId="+boardList.boardWriter);
						$(html).find(".board-writer-nickname").text(boardList.boardWriter);
						
						//작성자가 모임장이라면
						if(boardList.boardWriter == boardList.clubLeader){
							//badge 스타일 추가
							$(html).find(".board-writer-nickname").append("<span class='badge2'>모임장</span>");
						}
						
						$(html).find(".board-writer-nickname").text(boardList.memberNickname);
						
						//공지 여부에 따른 board-info
						if(boardList.boardNotice == 'Y'){
							$(html).find(".board-notice").show();
							$(html).find(".board-free").hide();
						}
						else{
							$(html).find(".board-free").show();
							$(html).find(".board-notice").hide();
						}
						var wtime = moment(boardList.boardWtime).format("YYYY-MM-DD");
					
						$(html).find(".write-time").text(wtime);//작성 시각 변경
						
						$(html).find(".board-title-link").prop("href", "detail?boardNo="+ boardList.boardNo).text(boardList.boardTitle);
						if(boardList.boardNotice == 'Y'){
							$(html).find(".badge").show();
						}
						else{
							$(html).find(".badge").hide();
						}
						$(html).find(".read-count").text(boardList.boardRead);
						$(html).find(".like-count").text(boardList.boardLike);
						$(html).find(".comment-count").text(boardList.boardComment);
						
						$(".board-list-wrapper").append(html);
					}
					
					//button 실행 조건
					if(response.hasMore == false){
						$(".btn-more").hide();
						$(".btn-more").parent().append("<div><h3>더이상 게시글이 없습니다</h3></div>");
					}
					else{
						$(".btn-more").show();
						
					}
				}
				
		});
			
		}
		
	});
