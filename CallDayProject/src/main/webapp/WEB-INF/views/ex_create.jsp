<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>피트니스 플래너</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=cp %>/resources/css/navbar.css">
	<link rel="stylesheet" href="<%=cp %>/resources/css/app.content.css">



    
    
</head>
<body>

<%@ include file="/WEB-INF/views/main_part/header.jsp" %>

<div style="height: 60px;"></div>

<div class="content-container">
    <div class="exex-fitness-container">

        <!-- 왼쪽: 칼로리 계산기 -->
        <aside class="exex-calorie-sidebar">
            <div class="exex-calc-header">
                <img src="<%=cp%>/resources/img/cal.png" alt="">
                <div class="exex-calc-title">칼로리 계산</div>
                <div class="exex-calc-subtitle">실시간 소모 칼로리</div>
            </div>

            <div class="exex-calorie-display">
                <div class="exex-calorie-number" id="calorieDisplay">0</div>
                <div class="exex-calorie-unit">kcal 소모</div>
            </div>

            <div class="exex-calc-details">
                <div class="exex-calc-row">
                    <span class="exex-calc-label">선택된 운동</span>
                    <span class="exex-calc-value" id="selectedExercise">-</span>
                </div>
                <div class="exex-calc-row">
                    <span class="exex-calc-label">운동 강도</span>
                    <span class="exex-calc-value" id="metDisplay">- MET</span>
                </div>
                <div class="exex-calc-row">
                    <span class="exex-calc-label">운동 시간</span>
                    <span class="exex-calc-value" id="timeDisplay">60분</span>
                </div>
                <div class="exex-calc-row">
                    <span class="exex-calc-label">체중</span>
                    <span class="exex-calc-value" id="weightDisplay">70kg</span>
                </div>
                <div class="exex-calc-row">
                    <span class="exex-calc-label">총 소모 칼로리</span>
                    <span class="exex-calc-value" id="totalDisplay">0 kcal</span>
                </div>
            </div>

            <div class="exex-alert" id="calcAlert" style="display:none;">
                운동과 시간을 선택하면 정확한 칼로리를 계산해드려요!
            </div>
        </aside>

        <!-- 오른쪽: 운동 플래너 폼 -->
        <section class="exex-main-form">
            <div class="exex-form-header">
                <h1>운동 플래너</h1>
                <p>스마트한 운동 계획과 칼로리 계산</p>
            </div>

            <form action="/exercise/save" method="post" id="fitnessForm">

                <!-- 운동 카테고리 선택 -->
                <div class="exex-exercise-section">
                    <div class="exex-input-group">
                        <label>운동 카테고리</label>
                        <div class="exex-category-grid">
                            <div class="exex-category-card" data-category="cardio">
                                <img src="<%=cp%>/resources/img/ex22.png" alt="">
                                <div class="exex-category-name">유산소</div>
                            </div>
                            <div class="exex-category-card" data-category="strength">
                                <img src="<%=cp%>/resources/img/ex1.PNG" alt="">
                                <div class="exex-category-name">근력운동</div>
                            </div>
                            <div class="exex-category-card" data-category="combat">
                                <img src="<%=cp%>/resources/img/ex3.png" alt="">
                                <div class="exex-category-name">격투기</div>
                            </div>
                            <div class="exex-category-card" data-category="outdoor">
                                <img src="<%=cp%>/resources/img/ex4.png" alt="">
                                <div class="exex-category-name">야외활동</div>
                            </div>
                            <div class="exex-category-card" data-category="sports">
                                <img src="<%=cp%>/resources/img/ex555.png" alt="">
                                <div class="exex-category-name">구기스포츠</div>
                            </div>
                            <div class="exex-category-card" data-category="bodymind">
                                <img src="<%=cp%>/resources/img/ex6.png" alt="">
                                <div class="exex-category-name">바디마인드</div>
                            </div>
                        </div>
                    </div>

                    <!-- 세부 운동 선택 (동적 생성) -->
                    <div class="exex-exercise-types" id="exerciseTypes">
                        <label>운동 종목</label>
                        <div class="exex-exercise-grid" id="exerciseGrid"></div>
                    </div>
                </div>

                <!-- 운동 시간 선택 -->
                <div class="exex-time-section">
                    <div class="exex-input-group">
                        <label>운동 시간</label>
                        <div class="exex-time-buttons">
                            <button type="button" class="exex-time-btn" data-time="30">30분</button>
                            <button type="button" class="exex-time-btn selected" data-time="60">60분</button>
                            <button type="button" class="exex-time-btn" data-time="90">90분</button>
                            <button type="button" class="exex-time-btn" data-time="90">120분</button>
                            <button type="button" class="exex-time-btn" data-time="custom" style="width: 100px;">직접입력</button>
                        
                        <div class="exex-custom-time" id="customTime">
                            <input type="number" id="customDuration" class="exex-input" placeholder="분 입력" min="5" max="300">
                        </div>
                        </div>
                    </div>
                </div>



				  <!-- 기본 정보 -->
                <div class="exex-input-group">
                    <label for="weight">체중 (kg)</label>
                    <input type="number" id="weight" name="weight" class="exex-input" placeholder="70" min="30" max="200" value="70">
                </div>
              
                <div class="exex-input-row">
                    <div class="exex-input-group">
                        <label for="title">운동 제목</label>
                        <input type="text" id="title" name="title" class="exex-input" placeholder="오늘의 운동 계획" required>
                    </div>
                    <div class="exex-input-group">
                        <label for="date">운동 날짜</label>
                        <input type="date" id="date" name="date" class="exex-input" required>
                    </div>
                </div>



                <!-- 메모 -->
                <div class="exex-input-group">
                    <label for="content">운동 메모</label>
                    <textarea id="content" name="content" class="exex-textarea" placeholder="운동 루틴, 컨디션, 목표 등을 기록하세요"></textarea>
                </div>

                <!-- 숨겨진 필드들 (폼 제출용) -->
                <input type="hidden" id="exerciseCategory" name="exerciseCategory">
                <input type="hidden" id="exerciseType" name="exerciseType">
                <input type="hidden" id="duration" name="duration" value="60">
                <input type="hidden" id="caloriesBurned" name="caloriesBurned" value="0">

                <button type="submit" class="exex-submit-btn">운동 계획 저장</button>
            </form>
        </section>

    </div>
</div>

<%@ include file="/WEB-INF/views/main_part/footer.jsp" %>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // 운동 데이터 (MET 값 포함)
    const exerciseData = {
    cardio: {
        "스핀(실내사이클)": 8.0,
        "런닝머신": 7.0,
        "엘립티컬": 6.0,
        "계단오르기": 8.5,
        "로잉머신": 7.0,
        "에어바이크": 10.0,
        "파워워킹": 6.5,
        "줄넘기": 9.0,
        "버피": 8.0,
        "마운틴클라이머": 8.5,
        "점프스쿼트": 7.5,
        "고강도인터벌": 11.0
    },
    strength: {
        "프리웨이트": 6.0,
        "머신운동": 5.0,
        "서킷트레이닝": 10.0,
        "크로스핏": 12.0,
        "케틀벨": 9.0,
        "바디웨이트": 7.0,
        "플라이오메트릭": 8.5,
        "파워리프팅": 6.5,
        "덤벨운동": 6.0,
        "바벨운동": 6.5,
        "밴드운동": 4.5,
        "펑셔널트레이닝": 7.5
    },
    combat: {
        "복싱": 10.0,
        "킥복싱": 9.0,
        "태권도": 9.0,
        "주짓수": 8.5,
        "MMA": 11.0,
        "가라테": 8.0,
        "검도": 7.5,
        "합기도": 7.0,
        "유도": 8.5,
        "무에타이": 10.0,
        "쿵푸": 8.0,
        "택견": 7.5
    },
    outdoor: {
        "하이킹": 7.0,
        "클라이밍": 8.0,
        "자전거": 8.0,
        "인라인": 7.5,
        "수영": 8.0,
        "서핑": 6.0,
        "스키": 9.0,
        "캠핑": 4.5,
        "트레킹": 7.5,
        "카약": 6.5,
        "스노보드": 8.5,
        "패러글라이딩": 4.0
    },
    sports: {
        "테니스": 7.0,
        "배드민턴": 5.5,
        "탁구": 4.0,
        "축구": 10.0,
        "농구": 8.0,
        "골프": 4.8,
        "야구": 5.0,
        "볼링": 3.0,
        "배구": 6.0,
        "스쿼시": 9.5,
        "라켓볼": 8.5,
        "핸드볼": 9.0
    },
    bodymind: {
        "요가": 3.0,
        "필라테스": 4.0,
        "스트레칭": 2.5,
        "명상": 1.5,
        "타이치": 3.0,
        "발레": 5.0,
        "댄스": 6.0,
        "맨손체조": 4.5,
        "아쉬탄가요가": 4.5,
        "핫요가": 3.5,
        "바레": 5.5,
        "짐나스틱": 6.0
    }
};

    // 전역 변수
    let selectedCategory = '';
    let selectedExercise = '';
    let selectedMET = 0;
    let currentDuration = 60;
    let currentWeight = 70;

    // DOM 요소
    const categoryCards = document.querySelectorAll('.exex-category-card');
    const exerciseTypes = document.getElementById('exerciseTypes');
    const exerciseGrid = document.getElementById('exerciseGrid');
    const timeButtons = document.querySelectorAll('.exex-time-btn');
    const customTime = document.getElementById('customTime');
    const customDuration = document.getElementById('customDuration');
    const weightInput = document.getElementById('weight');
    
    // 칼로리 표시 요소들
    const calorieDisplay = document.getElementById('calorieDisplay');
    const selectedExerciseEl = document.getElementById('selectedExercise');
    const metDisplay = document.getElementById('metDisplay');
    const timeDisplay = document.getElementById('timeDisplay');
    const weightDisplay = document.getElementById('weightDisplay');
    const totalDisplay = document.getElementById('totalDisplay');
    const calcAlert = document.getElementById('calcAlert');

    // 숨겨진 폼 필드들
    const hiddenCategory = document.getElementById('exerciseCategory');
    const hiddenExerciseType = document.getElementById('exerciseType');
    const hiddenDuration = document.getElementById('duration');
    const hiddenCalories = document.getElementById('caloriesBurned');

    // 초기화
    document.addEventListener('DOMContentLoaded', function() {
        updateCalorieDisplay();
        showAlert();
        
        // 오늘 날짜 설정
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('date').value = today;
    });

    // 카테고리 선택
    categoryCards.forEach(card => {
        card.addEventListener('click', function() {
            categoryCards.forEach(c => c.classList.remove('selected'));
            this.classList.add('selected');
            selectedCategory = this.dataset.category;
            hiddenCategory.value = selectedCategory;
            showExerciseTypes(selectedCategory);

            selectedExercise = '';
            selectedMET = 0;
            hiddenExerciseType.value = '';

            updateCalorieDisplay();

            this.style.transform = 'scale(0.95)';
            setTimeout(() => { this.style.transform = ''; }, 150);
        });
    });

    // 세부 운동 목록 표시
    function showExerciseTypes(category) {
        const exercises = exerciseData[category];
        exerciseGrid.innerHTML = '';
        
        Object.entries(exercises).forEach(([name, met]) => {
            const exerciseOption = document.createElement('div');
            exerciseOption.className = 'exex-exercise-option';
            exerciseOption.dataset.exercise = name;
            exerciseOption.dataset.met = met;
            exerciseOption.innerHTML = `
                <div class="exex-exercise-name">\${name}</div>
                <div class="exex-exercise-met">MET \${met}</div>
            `;
            
            exerciseOption.addEventListener('click', function() {
                document.querySelectorAll('.exex-exercise-option').forEach(opt => {
                    opt.classList.remove('selected');
                });
                this.classList.add('selected');
                selectedExercise = this.dataset.exercise;
                selectedMET = parseFloat(this.dataset.met);
                hiddenExerciseType.value = selectedExercise;

                updateCalorieDisplay();
                hideAlert();

                this.style.transform = 'scale(0.95)';
                setTimeout(() => { this.style.transform = ''; }, 150);
            });
            
            exerciseGrid.appendChild(exerciseOption);
        });
        
        exerciseTypes.classList.add('show');
    }

    // 시간 선택
    timeButtons.forEach(btn => {
        btn.addEventListener('click', function() {
            timeButtons.forEach(b => b.classList.remove('selected'));
            this.classList.add('selected');

            const timeValue = this.dataset.time;
            if (timeValue === 'custom') {
                customTime.classList.add('show');
                customDuration.focus();
            } else {
                customTime.classList.remove('show');
                currentDuration = parseInt(timeValue);
                hiddenDuration.value = currentDuration;
                updateCalorieDisplay();
            }

            this.style.transform = 'scale(0.95)';
            setTimeout(() => { this.style.transform = ''; }, 150);
        });
    });

    // 커스텀 시간 입력
    customDuration.addEventListener('input', function() {
        const value = parseInt(this.value);
        if (value && value > 0) {
            currentDuration = value;
            hiddenDuration.value = currentDuration;
            updateCalorieDisplay();
        }
    });

    // 체중 변경
    weightInput.addEventListener('input', function() {
        const value = parseFloat(this.value);
        if (value && value > 0) {
            currentWeight = value;
            updateCalorieDisplay();
        }
    });

    // 칼로리 계산 및 표시 업데이트
    function updateCalorieDisplay() {
        const calories = calculateCalories(selectedMET, currentWeight, currentDuration);
        calorieDisplay.textContent = Math.round(calories);
        selectedExerciseEl.textContent = selectedExercise || '-';
        metDisplay.textContent = selectedMET > 0 ? `\${selectedMET} MET` : '- MET';
        timeDisplay.textContent = `\${currentDuration}분`;
        weightDisplay.textContent = `\${currentWeight}kg`;
        totalDisplay.textContent = `\${Math.round(calories)} kcal`;
        hiddenCalories.value = Math.round(calories);
    }

    // 칼로리 계산 함수
    function calculateCalories(met, weight, duration) {
        if (!met || !weight || !duration) return 0;
        return met * weight * (duration / 60);
    }

    // 알림 표시/숨김
    function showAlert() {
        calcAlert.style.display = 'block';
    }
    function hideAlert() {
        calcAlert.style.display = 'none';
    }

    // 폼 제출 전 검증
    document.getElementById('fitnessForm').addEventListener('submit', function(e) {
        if (!selectedCategory || !selectedExercise) {
            e.preventDefault();
            alert('운동 카테고리와 종목을 선택해주세요!');
            return false;
        }
        if (!document.getElementById('title').value.trim()) {
            e.preventDefault();
            alert('운동 제목을 입력해주세요!');
            return false;
        }
        if (!document.getElementById('date').value) {
            e.preventDefault();
            alert('운동 날짜를 선택해주세요!');
            return false;
        }
        return true;
    });

</script>
</body>
</html>

        