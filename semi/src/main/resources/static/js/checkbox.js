window.addEventListener("load", function(){
    //전체선택 체크박스 이벤트
    var checkAllList = document.querySelectorAll(".check-all");
    for(var i=0; i < checkAllList.length; i++) {
        checkAllList[i].addEventListener("input", function(){
            //this == 체크된 전체선택 체크박스
            //체크상태는 this.checked로 알아낸다

            var checkItemList = document.querySelectorAll(".check-item");
            for(var k=0; k < checkItemList.length; k++) {
                checkItemList[k].checked = this.checked;
            }

            refreshCheckbox();
        });
    }
    
    //필수선택 체크박스 이벤트
    var checkRequiredList = document.querySelectorAll(".check-required");
    for(var i=0; i < checkRequiredList.length; i++) {
        checkRequiredList[i].addEventListener("input", function(){
            //this == 체크된 필수선택 체크박스

            var checkRequiredItemList = document.querySelectorAll(".check-item.check-item-required");
            for(var k=0; k < checkRequiredItemList.length; k++) {
                checkRequiredItemList[k].checked = this.checked;
            }

            refreshCheckbox();
        });
    }

    //체크박스 리프레시 함수
    function refreshCheckbox() {
        //전체 체크 항목 수를 조사
        var checkItemList = document.querySelectorAll(".check-item");//전체 체크항목
        var selectedCheckItemList = document.querySelectorAll(".check-item:checked");//선택된 체크항목
        var allChecked = checkItemList.length == selectedCheckItemList.length;//전체 체크 여부 판정
        var checkAllList = document.querySelectorAll(".check-all");//전체선택 체크박스들을 찾아서
        for(var i=0; i < checkAllList.length; i++) {//하나씩 반복하며
            checkAllList[i].checked = allChecked;//상태를 설정
        }        

        //필수 체크 항목 수를 조사
        var requiredItemList = document.querySelectorAll(".check-item.check-item-required");//전체 필수항목
        var selectedRequiredItemList = document.querySelectorAll(".check-item.check-item-required:checked");//선택된 필수항목
        var requiredChecked = requiredItemList.length == selectedRequiredItemList.length;//필수 체크 여부 판정
        var requiredAllList = document.querySelectorAll(".check-required");
        for(var i=0; i < requiredAllList.length; i++) {
            requiredAllList[i].checked = requiredChecked;
        }
    }

    //개별항목 체크박스 이벤트
    var checkItemList = document.querySelectorAll(".check-item");
    for(var i=0; i < checkItemList.length; i++) {
        checkItemList[i].addEventListener("input", refreshCheckbox);
    }
});