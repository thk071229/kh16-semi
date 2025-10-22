<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
	*페이지 내비게이터 사용 방법(list 불러올때 pageVO 이외의 파라미터 값이 존재할 경우 (ex:clubNo)) 
	PageVO를 이용한 목록 조회(필수)
	해당 Controller에서 pageVO.putParentParams(String, Integer); 반드시 설정해야합니다
--%>
<%-- 페이지 내비게이터(더보기 방식)--%>
<%-- a태그로 구현 --%>
<c:if test = "${pageVO != null && pageVO.dataCount > 0 && pageVO.page < pageVO.totalPage}">
	<div class = "pagination-more">
			<a href = "list?${pageVO.searchParamsInMore}${pageVO.parentParamsToString}">더보기</a>
	</div>
</c:if>

<%-- ajax로 구현하려면 일일히 DOM 만들어야돼서 포기... --%>
<!-- <script type="text/javascript">
    $(function () {
    	// 현재 페이지의 '총' 데이터 개수 (공지사항 제외)
        var totalCount = ${pageVO.dataCount};

        // 현재 로드된 개수 (초기값: 10)
        // 이 변수가 누적됩니다. (10 -> 20 -> 30 ...)
        var currentSize = ${pageVO.size};

        // 한 번에 로드할 개수 (증가량)
        var itemsPerPage = ${pageVO.size}; // 10

        // RestController로 보낼 파라미터
        var listType = "${type}"; // "board"
        var parentParamsKey = "${parentParamsKey}";
        var parentParamsValue = ${parentParamsValue};
		//비어있는 객체 생성
        var parentParams = {};
		parentParams[parentParamsKey] = parentParamsValue;
		
        $(".btn-more").on("click", function () {
            $(this).prop("disabled", true).text("로딩중...");

            var newSize = currentSize + itemsPerPage;
            
            var data = {
            	page:1,
            	size:newSize,
            	type:listType
            };
            
            data["parentParams[" + parentParamsKey + "]"] = parentParamsValue;
            
            $.ajax({
                url: "/rest/list/more",
                method: "POST",
                data: data,
                success: function(response){
                	
                    var list = response.list;
                    console.log(response);
                    console.log(list);
                    var dataCount = response.dataCount;

                    var newItems = list.slice(currentSize);
                    
                    currentSize = newSize;
                    
                    //버튼 상태 업데이트
                    if(currentSize > dataCount){
                        $(this).hide();
                    }
                    else{
                        $(this).prop("disabled", false).text("더보기");
                    }
                    
                }
            });

        });

    });
</script>

<div class="pagination-more">
    <button type="button" class="btn btn-positive btn-more">
        더보기
    </button>
</div>
-->