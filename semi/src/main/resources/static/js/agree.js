// 문서(DOM)가 모두 로드된 후에 스크립트 실행
document.addEventListener("DOMContentLoaded", function() {
    
    // --- 1. 필요한 요소(Element)들 선택 ---
    const checkRequiredAll = document.querySelector(".check-required"); // (필수) 전체동의
    const checkAll = document.querySelector(".check-all"); // (전체) 전체동의
    const checkItems = document.querySelectorAll(".check-item"); // (개별) 모든 항목
    const requiredItems = document.querySelectorAll(".check-item-required"); // (개별) 필수 항목만
    const nextButtonContainer = document.querySelector("#next-step-container"); // 다음 단계 버튼 컨테이너

    // (예외 처리) 필수 요소가 페이지에 없는 경우, 스크립트 중단
    if (!checkRequiredAll || !checkAll || checkItems.length === 0 || requiredItems.length === 0 || !nextButtonContainer) {
        // console.warn("약관 동의 스크립트: 필수 요소 중 일부가 페이지에 없습니다.");
        return; 
    }

    // --- 2. (핵심) 필수 항목 체크 상태를 확인하고 버튼을 표시/숨김하는 함수 ---
    function toggleNextButton() {
        let allRequiredChecked = true; // 일단 모두 체크되었다고 가정
        
        // 필수 항목들을 하나씩 반복 검사
        requiredItems.forEach(function(item) {
            if (!item.checked) { // 하나라도 체크가 안되어 있다면
                allRequiredChecked = false; // 가정을 false로 변경
            }
        });

        // 결과에 따라 버튼 표시/숨김
        if (allRequiredChecked) {
            nextButtonContainer.style.display = "block"; // 모두 체크됨 -> 보이기
        } else {
            nextButtonContainer.style.display = "none"; // 하나라도 체크 안됨 -> 숨기기
        }
    }

    // --- 3. (보조) 개별 항목 체크 상태에 따라 '전체동의' 체크박스들을 업데이트하는 함수 ---
    function updateMainCheckboxes() {
        let allChecked = true;
        let allRequiredChecked = true;

        checkItems.forEach(function(item) {
            if (!item.checked) {
                allChecked = false; // (전체) 중 하나라도 체크 안되면 false
            }
            if (item.classList.contains('check-item-required') && !item.checked) {
                allRequiredChecked = false; // (필수) 중 하나라도 체크 안되면 false
            }
        });

        checkAll.checked = allChecked;
        checkRequiredAll.checked = allRequiredChecked;
    }

    // --- 4. 이벤트 리스너(Event Listeners) 등록 ---

    // (필수) 전체동의 체크박스를 클릭했을 때
    checkRequiredAll.addEventListener("input", function() {
        const isChecked = this.checked;
        // 모든 '필수' 항목들의 상태를 (필수) 전체동의 체크박스 상태와 동일하게 변경
        requiredItems.forEach(function(item) {
            item.checked = isChecked;
        });
        updateMainCheckboxes(); // (전체) 전체동의 체크박스 상태 업데이트
        toggleNextButton();     // 버튼 상태 업데이트
    });

    // (전체) 전체동의 체크박스를 클릭했을 때
    checkAll.addEventListener("input", function() {
        const isChecked = this.checked;
        // '모든' 항목들의 상태를 (전체) 전체동의 체크박스 상태와 동일하게 변경
        checkItems.forEach(function(item) {
            item.checked = isChecked;
        });
        updateMainCheckboxes(); // (필수) 전체동의 체크박스 상태 업데이트
        toggleNextButton();     // 버튼 상태 업데이트
    });

    // (개별) 항목들을 클릭했을 때
    checkItems.forEach(function(item) {
        item.addEventListener("input", function() {
            updateMainCheckboxes(); // (필수), (전체) 체크박스 상태 업데이트
            toggleNextButton();     // 버튼 상태 업데이트
        });
    });

    // --- 5. 페이지 로드 시 즉시 1회 실행 ---
    // (뒤로가기 등으로 체크박스 상태가 유지되었을 경우를 대비)
    updateMainCheckboxes();
    toggleNextButton();
});