	//댓글 처리 ajax
	$(function(){
		var params = new URLSearchParams(location.search);
		var boardNo = params.get("boardNo");
		stateCheck();//댓글 상태여부 호출
		loadList();//최초 목록 호출
		
		//댓글 달렸는지 확인 후 댓글 수 변경
		//댓글이 없어도 확인 가능해야하니까 data로 boardNo 값을 받는다
		function stateCheck(){
			$.ajax({
				url:"/rest/reply/check",
				method:"POST",
				data:{boardNo : boardNo},
				success:function(response){
					$("#reply-count").text(response.count);
				}
			});
		}
			
		//목록 불러오는 함수(callback 함수)
		function loadList(){
			//목록 조회 ajax
			$.ajax({
				url:"/rest/reply/list",
				method:"POST",
				data:{replyTarget : boardNo},
				success:function(response){
					//댓글이 달리지 않은 경우 아무것도 하지 않음
					if(response.length == 0){
						return;
					}
					//댓글 영역 청소
					$(".reply-list-wrapper").empty();
					//댓글 화면 생성
					for(var i = 0; i < response.length; i ++){//response = List<ReplyListVO>
						var reply = response[i];
						
						//템플릿 불러와서
						var origin = $("#reply-view-template").text();
						//html로 재해석
						var html = $.parseHTML(origin);//HTML로 재해석
						$(html).find(".reply-writer-profile").prop("src", "/member/profile?memberId="+reply.replyWriter);
						$(html).find(".reply-writer").text(reply.replyWriter);//작성자 교체
						
						//작성자가 게시글 작성자 본인이라면
						if(reply.writer == true){
							//badge 스타일 추가
							$(html).find(".reply-writer").append("<span class='badge ms-10'>작성자</span>");
						}
						
						$(html).find(".reply-content").text(reply.replyContent);//댓글 내용 교체
						
						//var wtime = moment(reply.replyWtime).format("YYYY-MM-DD HH:mm:ss");//wtime의 표시형태만 변경
						var wtime = moment(reply.replyWtime).fromNow();//상대적 시각
						$(html).find(".reply-time").text(wtime);//작성 시각 교체
						
						$(html).find(".fa-trash").attr("data-pk", reply.replyNo);//삭제 버튼에 PK 설정
						$(html).find(".fa-edit").attr("data-pk", reply.replyNo);//수정 버튼에 PK 설정
						
						//댓글 작성자 본인이 아닌 경우 버튼 영역 삭제(안보이게)
						if(reply.owner == false){
							$(html).find(".button-wrapper").remove();
						}
						
						$(".reply-list-wrapper").append(html); //댓글 목록 영역에 추가
					}
				}
			});
		}//loadList 함수 종료
		
		//삭제 버튼 이벤트
		$(".reply-list-wrapper").on("click", ".fa-trash", function(){
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if(choice == false) return;
			
			var replyNo = $(this).data("pk");
			
			$.ajax({
				url:"/rest/reply/delete",
				method:"POST",
				data:{ replyNo : replyNo },
				success:function(response){
					stateCheck();
					loadList(); //목록 전체 갱신
				}
			});
		});
		//수정 버튼 이벤트(목록에서 edit 버튼 눌렀을때)
		$(".reply-list-wrapper").on("click", ".fa-edit", function(){
			var origin = $("#reply-edit-template").text();//수정 화면 템플릿 불러오기
			var html = $.parseHTML(origin);//HTML로 재해석
			
			var replyNo = $(this).data("pk"); //this == fa-edit 버튼
			var replyContent = $(this).closest(".reply-wrapper").find(".reply-content").text();
			
			$(html).find(".fa-check").attr("data-pk", replyNo);
			$(html).find(".reply-editor").val(replyContent);//textarea에 글자 설정
			
			$(".reply-wrapper").show();//댓글 영역 표시
			$(".reply-edit-wrapper").remove();//기존에 만들어진 편집용 화면 지우고
			$(this).closest(".reply-wrapper").hide().after(html);//버튼이 속한 영역 뒤에 html 추가
			
		});
		//수정 취소 버튼 이벤트
		$(".reply-list-wrapper").on("click", ".fa-xmark", function(){
			$(this).closest(".reply-edit-wrapper").prev(".reply-wrapper").show();//보기 영역 표시
			$(this).closest(".reply-edit-wrapper").hide().remove();//수정 영역 제거
		});
		
		//수정 완료 버튼 이벤트
		$(".reply-list-wrapper").on("click", ".fa-check", function(){
			var replyNo = $(this).data("pk");
			var replyContent = $(this).closest(".reply-edit-wrapper")
								.find(".reply-editor").val();//reply-editor에 적혀있는 값을 content로 저장
			
			$.ajax({
				url:"/rest/reply/edit",
				method:"POST",
				data:{replyNo : replyNo, replyContent : replyContent},
				success:function(response){
					loadList();
				}
			});
		});
		
		//댓글 등록 버튼 이벤트
		$(".reply-btn-write").on("click", function(){
			var content = $(".reply-input").val();
			//아무것도 작성되지 않았을 경우 차단
			if(content.trim().length == 0) return;
			
			$.ajax({
				url:"/rest/reply/write",
				method:"POST",
				data:{replyTarget:boardNo, replyContent:content},
				success:function(response){
					stateCheck();
					loadList();//등록 성공 시 목록 갱신
					$(".reply-input").val("");//입력창의 내용 삭제
				}
			});
		});
	});
