<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script type="text/javascript">
$(function () {
    //상태 객체 
    var state = {
        clubNameValid: false,
        clubIntroduceValid: true,
        clubRegionValid: false,
        clubOpenValid: false,
        clubCategoryValid: false,
        ok: function () {
            return this.clubNameValid && this.clubIntroduceValid
                && this.clubCategoryValid && this.clubRegionValid && this.clubOpenValid;
        }
    };
    //항목 검사
    $("[name=clubName]").on("blur", function () {
        var regex = /^[가-힣a-zA-Z0-9 ]*$/;
        var valid = regex.test($(this).val());
        $(this).removeClass("success fail");
        $(this).addClass(valid ? "success" : "fail");
        state.clubNameValid = valid;
    });
    $("[name=regionName]").on("blur", function () {
        var valid = $(this).val().length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(valid ? "success" : "fail");
        state.clubRegionValid = valid;
    });
    $("[name=clubOpen]").on("blur", function () {
        var valid = $(this).val().length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(valid ? "success" : "fail");
        state.clubOpenValid = valid;
    });
    $("[name=clubCategory]").on("blur", function () {
        var valid = $(this).val().length > 0;
        $(this).removeClass("success fail");
        $(this).addClass(valid ? "success" : "fail");
        state.clubCategoryValid = valid;
    });
    //폼 검사
    $(".check-form").on("submit", function () {
        $(this).find("[name]").trigger("blur");
        if(state.ok() == false) window.alert("필수 정보를 모두 입력해주세요");
        return state.ok();
    });
});
    </script>
<div class="container w-600">
        <form action="add" method="post" autocomplete="off" enctype="multipart/form-data" class="check-form">
            
            <div class="cell center">
                <h1 class="mt-20">모임 개설</h1>
            </div>

            <div class="cell">
            	<label>모임 이름<i class="fa-solid fa-asterisk red"></i></label>
                <input class="input w-100" type="text" name="clubName" placeholder="한글, 영문, 숫자 포함 6글자 이내">
                <div class="success-feedback w-100">올바른 이름 형식입니다</div>
                <div class="fail-feedback w-100">이름은 한글, 숫자, 영문 포함 6글자 이내로 작성해주세요</div>
            </div>

            <div class="cell">
                <textarea class="w-100" name="clubIntroduce" rows="5" placeholder="모임 소개"></textarea>
            </div>

            <div class="cell">
            	<label>활동지역<i class="fa-solid fa-asterisk red"></i></label>
                <input class="input w-100" type="text" name="regionName" placeholder="지역 (API로 검색 예정)">
                <div class="success-feedback w-100"></div>
                <div class="fail-feedback w-100">지역은 반드시 설정해주세요</div>
            </div>

            <div class="cell">
            	<label>승인 방식<i class="fa-solid fa-asterisk red"></i></label>
                <select class="input w-100" name="clubOpen">
                    <option value="">-- 가입승인 여부 (Y:승인, N:바로가입) --</option>
                    <option value="Y">소모임장 승인 후 가입 (Y)</option>
                    <option value="N">누구나 바로 가입 (N)</option>
                </select>
                <div class="success-feedback w-100"></div>
                <div class="fail-feedback w-100">승인 방식을 선택해주세요</div>
            </div>
	
            <div class="cell">
            	<label>관심사<i class="fa-solid fa-asterisk red"></i></label>
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