		//swiper js
        $(function () {
            //var swiper = new Swiper(selector, options);
            var swiper = new Swiper('.swiper', {
                //direction: 'vertical', //슬라이드 방향(안적으면 horizontal)
                loop: true, //무한 반복 설정 (안적으면 false)

                // 페이지의 위치가 표시되도록 설정
                pagination: {
                    el: '.swiper-pagination', //적용시킬 대상 영역의 선택자
                    type: "bullets", //표시되는 방식(bullets/fraction/progressbar/custom)
                    clickable: true, //클릭을 통한 이동 허용
                },
              
                // Navigation arrows
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                    hideOnClick: true, //클릭 시 숨김 처리
                },
                //자동 재생 옵션
                /* autoplay: {
                    delay: 5000,
                    pauseOnMouseEnter: true,//마우스가 올라가있으면 자동재생 중지
                }, */
                effect: 'coverflow',
                grabCursor: true,
                centeredSlides: true,
                slidesPerView: 'auto',       // 화면에 맞춰 슬라이드 크기 자동 조정
                loop: true,
                coverflowEffect: {
                    rotate: 30,              // 회전 각도
                    stretch: 0,              // 늘리기
                    depth: 150,              // Z축 깊이
                    modifier: 0.8,             // 효과 강도
                    scale: 0.85,
                    slideShadows: false,      // 그림자 표시
                },
                lazy:true,
            });
        });
