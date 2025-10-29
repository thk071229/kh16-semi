$(function() {
		var isAlerted = false;
	    var lastBytes = 0;
	    var MAX_VISIBLE_CHARS = 2000;
	    var MAX_BYTES = 4000;
		
		var $editor = $(".summernote-editor");
		var $success = $editor.siblings(".success-feedback");
		var $fail = $editor.siblings(".fail-feedback");
		
	$(document).keydown(function(event) {
		if (event.key === "Tab") {
			// 페이지 내에서만 탭을 이동하도록 하기 위한 조건 추가
			if ($(event.target).closest('body').length) {
				event.preventDefault(); // 기본 탭 키 동작 방지
			}
		}
	});
	$(".summernote-editor").summernote({
		//높이 옵션
		height: 250,
		minHeight: 200, //최소 높이(px)
		maxHeight: 400, //최대 높이(px)
		//placeholder 옵션
		placeholder: "내용을 입력하세요",
		//메뉴 설정(toolbar)
		toolbar: [
			//하나의 메뉴 그룹을 하나의 배열로 묶어서 작성
			//["그룹명", ["메뉴 종류", "메뉴 종류", ...]]
			["style", ["style"]],
			["font", ["fontname", "fontsize", "forecolor", "backcolor"]],
			["style", ["bold", "italic", "underline", "strikethrough"]],
			["attach", ["picture"]],
			["tool", ["ol", "ul", "table", "hr", "fullscreen"]],
		],

		//커스텀 훅(hook)
		callbacks: {
			onImageUpload: function(files) {
				console.log("파일 업로드 시도 중...")
				console.log(files);

				var form = new FormData(); //폼 태그 대신 사용할 도구
				for (var i = 0; i < files.length; i++) {
					form.append("attach", files[i]);
				}

				$.ajax({
					processData: false,
					contentType: false,
					url: "/rest/image/temps",
					method: "post",
					data: form,
					success: function(response) { //response == List<Integer>
						//이미지 태그 생성 후 에디터에 추가
						for (var i = 0; i < response.length; i++) {
							var img = $("<img>").attr("src", "/attachment/download?attachmentNo=" + response[i])
								.attr("data-pk", response[i])
								.addClass("custom-image");
							$(".summernote-editor").summernote("insertNode", img[0]);
						}

					}
				});
			},

			onChange: function(contents, $editable) {
			    var encoder = new TextEncoder();
			    var bytes = encoder.encode(contents).length;
			    var textOnly = $('<div>').html(contents).text();

			    // 1️ alert (DB 기준)
			    if (bytes > MAX_BYTES && !isAlerted) {
			        alert('글자 수가 ' + MAX_BYTES + 'byte(한글 약 2000자)를 초과했습니다!');
			        isAlerted = true;
			    } else if (bytes <= MAX_BYTES) {
			        isAlerted = false;
			    }
			    lastBytes = bytes;

			    // 2️ 피드백 표시
				if (textOnly.length > MAX_VISIBLE_CHARS) {
				                 $success.hide();
				                 $fail.text("${MAX_VISIBLE_CHARS}자를 초과했습니다 (${textOnly.length}자 입력됨)").show();
				             } else {
				                 $fail.hide();
				                 $success.text(`현재 ${textOnly.length}/${MAX_VISIBLE_CHARS}자 입력 중`).show();
				             }
				if(textOnly.length == 0) {
					$success.hide();
					$fail.text("내용을 입력해주세요").show();
				}			 

			    // 3️ 글자수 제한 (커서 튐 방지)
			    if (textOnly.length > MAX_VISIBLE_CHARS) {
			        const trimmed = textOnly.slice(0, MAX_VISIBLE_CHARS);
			        const node = document.createTextNode(trimmed);
			        const range = window.getSelection().getRangeAt(0);
			        range.deleteContents();
			        range.insertNode(node);
			    }
			},

			onPaste: function(e) {
			    var clipboardText = ((e.originalEvent || e).clipboardData).getData('Text');
			    e.preventDefault();
			    document.execCommand('insertText', false, clipboardText);
			}

		}
	});
});