<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8e8665a62573621467f321f74eb7cae4&libraries=services"></script>

<script type="text/javascript">
$(function () {
    //상태 객체 
    var state = {
        clubNameValid: false,
        clubIntroduceValid: true,
        clubRegionValid: false, // 주소 검색/선택 성공 시 true
        clubOpenValid: false,
        clubCategoryValid: false,
        ok: function () {
            return this.clubNameValid && this.clubIntroduceValid
                && this.clubCategoryValid && this.clubRegionValid && this.clubOpenValid;
        }
    };
    
    // --- 유효성 검사 로직 (공백 및 길이 체크 보완) ---
    $("[name=clubName]").on("blur", function () {
        var value = $(this).val();
        var trimmedValue = value.trim();
        // 한글, 영문, 숫자, 공백 포함 패턴 (중간 공백 허용)
        var regex = /^[가-힣a-zA-Z0-9 ]*$/;
        
        // 2~6자 길이 체크
        var lengthValid = trimmedValue.length >= 2 && trimmedValue.length <= 6;
        var patternValid = regex.test(value);
        var valid = patternValid && lengthValid;
        
        $(this).removeClass("success fail");
        
        if (value.length > 0 && !valid) {
            $(this).addClass("fail");
        } else if (valid) {
             $(this).addClass("success");
        }
        
        state.clubNameValid = valid;
    });
    
    // 지역 검사 (주소 검색 완료 여부) - 이 blur 이벤트는 검색 버튼 클릭 후 강제 발생되어야 함
    $("[name=regionName]").on("blur", function () {
        var valid = $(this).val().length > 0 && $("[name=regionDepth1]").val().length > 0; // regionDepth1 값도 확인
        $(this).removeClass("success fail");
        if(valid) {
             $(this).addClass("success");
        } else if ($(this).val().length > 0) { // 입력은 했으나 검색/선택이 안된 경우 fail
             $(this).addClass("fail");
        }
        state.clubRegionValid = valid;
    });
    
    // 승인 방식 검사
    $("[name=clubOpen]").on("change blur", function () {
        var valid = $(this).val() !== "";
        $(this).removeClass("success fail").addClass(valid ? "success" : "fail");
        state.clubOpenValid = valid;
    });
    // 카테고리 검사
    $("[name=clubCategory]").on("change blur", function () {
        var valid = $(this).val() !== "";
        $(this).removeClass("success fail").addClass(valid ? "success" : "fail");
        state.clubCategoryValid = valid;
    });
    
    //폼 검사
    $(".check-form").on("submit", function (e) {
        // blur 강제 발생
        $(this).find("[name=clubName], [name=regionName], [name=clubOpen], [name=clubCategory]").trigger("blur");
        
        if(state.ok() == false) {
             e.preventDefault();
             window.alert("필수 정보를 모두 올바르게 입력해주세요.");
        }
        // return state.ok(); // state.ok()가 true면 submit 진행
    });
    
    // --- 카카오 주소 검색 로직 (지도 없이, depth1/depth2 저장) ---
    var geocoder = new kakao.maps.services.Geocoder();
    
    $(".address-search-btn").on("click", function () {
        var keyword = $(".address-input").val(); 
        if (keyword.trim().length == 0) {//공란으로 두면 표시
            alert("검색할 지역 키워드를 입력하세요.");
            return;
        }

        geocoder.addressSearch(keyword, function (result, status) {
            if (status === kakao.maps.services.Status.OK) {
                if (result.length > 0) {
                    var firstResult = result[0];
                    
                    // region_1depth_name: 시/도 (예: 서울특별시)
                    var depth1 = firstResult.address.region_1depth_name;
                    // region_2depth_name: 시/군/구 (예: 강남구)
                    var rawDepth2 = firstResult.address.region_2depth_name;
                    var depth2Parts = rawDepth2.split(' ');
                    var depth2 = depth2Parts[0];
                    var fullAddress = firstResult.address_name;
                    
                    // 1. regionName 입력 필드에 전체 주소를 설정
                    $("[name=regionName]").val(fullAddress); 
                    
                    // 2. Hidden input에 depth1, depth2 값 설정
                    $("[name=regionDepth1]").val(depth1);
                    $("[name=regionDepth2]").val(depth2);

                    alert("지역이 선택되었습니다: " + fullAddress);
                    // 3. 유효성 검사 강제 발생 및 상태 업데이트
                    state.clubRegionValid = true; 
                    $("[name=regionName]").removeClass("fail").addClass("success").trigger("blur");

                } else {
                     alert("검색 결과가 없습니다.");
                     // 실패 시 값 초기화
                     $("[name=regionDepth1]").val("");
                     $("[name=regionDepth2]").val("");
                     state.clubRegionValid = false;
                     $("[name=regionName]").removeClass("success").addClass("fail").trigger("blur");
                }
            } else {
                alert("주소 검색 중 오류가 발생했습니다.");
                 // 실패 시 값 초기화
                 $("[name=regionDepth1]").val("");
                 $("[name=regionDepth2]").val("");
                 state.clubRegionValid = false;
                 $("[name=regionName]").removeClass("success").addClass("fail").trigger("blur");
            }
        });
    });
    
});
</script>
<div class="container w-600">
        <form action="add" method="post" autocomplete="off" enctype="multipart/form-data" class="check-form">
            
            <input type="hidden" name="regionDepth1">
            <input type="hidden" name="regionDepth2">
            
            <div class="cell center">
                <h1 class="mt-20">모임 개설</h1>
            </div>

            <div class="cell">
            	<label>모임 이름<i class="fa-solid fa-asterisk red ms-5"></i></label>
                <input class="input w-100" type="text" name="clubName" placeholder="한글, 영문, 숫자 포함 2~6글자">
                <div class="success-feedback w-100">올바른 이름 형식입니다</div>
                <div class="fail-feedback w-100">이름은 한글, 숫자, 영문, 공백 포함 2~6글자로 작성해주세요</div>
            </div>

            <div class="cell">
                <textarea class="w-100" name="clubIntroduce" rows="5" placeholder="모임 소개"></textarea>
            </div>

            <div class="cell">
	            <label>활동지역<i class="fa-solid fa-asterisk red ms-5"></i></label>
	            <div class="flex-box">
	                <%-- 보이는 주소 입력 필드 (검색 키워드 입력용) --%>
	                <input class="input w-100 field address-input" type="text" name="regionName" placeholder="예시 : (경기도 용인시 혹은 용인시)">
	                <button type="button" class="btn btn-primary ms-10 address-search-btn" style="white-space: nowrap;">
	                    <i class="fa-solid fa-magnifying-glass"></i> 검색
	                </button>
	            </div>
	            <div class="success-feedback w-100">지역이 선택되었습니다.</div>
	            <div class="fail-feedback w-100">활동 지역을 검색하여 선택해주세요.</div>
        </div>

            <div class="cell">
            	<label>승인 방식<i class="fa-solid fa-asterisk red ms-5"></i></label>
                <select class="input w-100" name="clubOpen">
                    <option value="">-- 가입승인 여부 (Y:승인, N:바로가입) --</option>
                    <option value="Y">소모임장 승인 후 가입 (Y)</option>
                    <option value="N">누구나 바로 가입 (N)</option>
                </select>
                <div class="success-feedback w-100"></div>
                <div class="fail-feedback w-100">승인 방식을 선택해주세요</div>
            </div>
	
            <div class="cell">
            	<label>관심사<i class="fa-solid fa-asterisk red ms-5"></i></label>
                <select class="input w-100" name="clubCategory">
                <option value="">-- 카테고리를 선택하세요 --</option>
                <c:forEach var="category" items="${categoryList}">
                    <option value="${category.categoryNo}">${category.categoryName}</option>
                </c:forEach>
                </select>
                <div class="success-feedback w-100"></div>
                <div class="fail-feedback w-100">카테고리를 선택해주세요</div>
            </div>
            
            <%-- 대표 사진 추가 --%>
            <div class= "cell">
            	<label>대표 사진(미설정 시 기본 이미지가 제공됩니다)</label>
            	<input class="input w-100" type="file" name="attach" accept="image/*">
            </div>

            <div class="cell">
                <button type="submit" class="btn btn-primary w-100">모임 만들기</button>
            </div>
            
            
        </form>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>