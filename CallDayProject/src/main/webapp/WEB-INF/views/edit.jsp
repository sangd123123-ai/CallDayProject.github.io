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
    <title> 피트니스 플래너</title>
    
  <!-- Bootstrap CSS -->
  
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/navbar.css">
  <link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/edit.css">
	
</head>
<body>

<%@ include file="/WEB-INF/views/main_part/header.jsp" %>

<div class="content-container">
<div style="height: 50px;"></div>
  <div class="fitness-container"><!-- 좌 300px / 우 1fr 그리드 -->

    <!-- ⬅️ 왼쪽: 네 '기존 계산기'만 이동 (중첩 .calorie-sidebar 제거) -->
    <aside class="calorie-sidebar">
      <div class="calc-header">
        <img src="<%=cp%>/resources/img/cal.png" width="50" alt="">
        <div class="calc-title">칼로리 계산</div>
        <div class="calc-subtitle">실시간 소모 칼로리</div>
      </div>

      <div class="calorie-display">
        <div class="calorie-number" id="calorieDisplay">0</div>
        <div class="calorie-unit">kcal 소모</div>
      </div>

      <div class="calc-details">
        <div class="calc-row">
          <span class="calc-label">선택된 운동</span>
          <span class="calc-value" id="selectedExercise">-</span>
        </div>
        <div class="calc-row">
          <span class="calc-label">운동 강도</span>
          <span class="calc-value" id="metDisplay">- MET</span>
        </div>
        <div class="calc-row">
          <span class="calc-label">운동 시간</span>
          <span class="calc-value" id="timeDisplay">60분</span>
        </div>
        <div class="calc-row">
          <span class="calc-label">체중</span>
          <span class="calc-value" id="weightDisplay">70kg</span>
        </div>
        <div class="calc-row">
          <span class="calc-label">총 소모 칼로리</span>
          <span class="calc-value" id="totalDisplay">0 kcal</span>
        </div>
      </div>

      <div class="alert success" id="calcAlert" style="display:none;">
        💡 운동과 시간을 선택하면 정확한 칼로리를 계산해드려요!
      </div>
    </aside>

    <!-- ➡️ 오른쪽: 네 기존 폼 '그대로' (여기엔 사이드바 넣지 않기) -->
    <section class="main-form">
      <div class="form-header">
        <h1>‍ 운동 플래너</h1>
        <p>스마트한 운동 계획과 칼로리 계산</p>
      </div>

      <form action="<c:url value='/calendar/${calendar.calNum}/update'/>" method="post" id="fitnessForm">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <!-- 운동 카테고리 선택 -->
        <div class="exercise-section">
          <div class="input-group">
            <label> 운동 카테고리</label>
            <div class="category-grid">
              <div class="category-card" data-category="cardio">
                <img src="<%=cp%>/resources/img/ex22.png" width="40" alt=""><div class="category-name">유산소</div>
              </div>
              <div class="category-card" data-category="strength">
                <img src="<%=cp%>/resources/img/ex1.PNG" width="40" alt=""><div class="category-name">근력운동</div>
              </div>
              <div class="category-card" data-category="combat">
                <img src="<%=cp%>/resources/img/ex3.png" width="40" alt=""><div class="category-name">격투기</div>
              </div>
              <div class="category-card" data-category="outdoor">
                <img src="<%=cp%>/resources/img/ex4.png" width="40" alt=""><div class="category-name">야외활동</div>
              </div>
              <div class="category-card" data-category="sports">
                <img src="<%=cp%>/resources/img/ex555.png" width="40" alt=""><div class="category-name">구기스포츠</div>
              </div>
              <div class="category-card" data-category="bodymind">
                <img src="<%=cp%>/resources/img/ex6.png" width="40" alt=""><div class="category-name">바디마인드</div>
              </div>
            </div>
          </div>

          <!-- 세부 운동 선택 (동적 생성) -->
          <div class="exercise-types" id="exerciseTypes">
            <label> 운동 종목</label>
            <div class="exercise-grid" id="exerciseGrid"></div>
          </div>
        </div>

        <!-- 운동 시간 선택 -->
        <div class="time-section">
          <div class="input-group">
            <label> 운동 시간</label>
            <div class="time-buttons">
              <button type="button" class="time-btn" data-time="30">30분</button>
              <button type="button" class="time-btn selected" data-time="60">60분</button>
              <button type="button" class="time-btn" data-time="90">90분</button>
              <button type="button" class="time-btn" data-time="120">120분</button>
              <button type="button" class="time-btn" data-time="custom">직접입력</button>
            </div>
            <div class="custom-time" id="customTime">
              <input type="number" id="customDuration" class="input" placeholder="분 입력" min="5" max="300">
            </div>
          </div>
        </div>

        <!-- 기본 정보 -->
        <div class="input-row">
          <div class="input-group">
            <label for="title"> 운동 제목</label>
            <input type="text" name="calSubject" class="input"
       			value="${calendar.calSubject}" placeholder="오늘의 운동 계획">
          </div>
          <div class="input-group">
            <label for="date"> 운동 날짜</label>
            <input type="date" name="calDate" id="calDate" class="input"
       			value="${calendar.calDate}">
          </div>
        </div>

        <div class="input-group">
          <label for="weight"> 체중 (kg)</label>
          <input type="number" id="weight" name="weight" class="input" placeholder="70" min="30" max="200" value="70">
        </div>

        <!-- 메모 -->
        <div class="input-group">
          <label for="content"> 운동 메모</label>
          	<textarea name="calContent" class="textarea" rows="6"
          		placeholder="운동 루틴, 컨디션, 목표 등을 기록하세요"><c:out value="${calendar.calContent}"/></textarea>
        </div>

		<input type="hidden" name="calNum"                value="${calendar.calNum}">
		<input type="hidden" id="exerciseCategory" name="calPart"  value="${calendar.calPart}">
		<input type="hidden" id="exerciseType"     name="calName"  value="${calendar.calName}">
		<input type="hidden" id="leadTime"         name="leadTime" value="${calendar.leadTime}">
		<input type="hidden" name="back" value="${back}">

        <button type="submit" class="submit-btn">운동 계획 저장</button>
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
    const categoryCards = document.querySelectorAll('.category-card');
    const exerciseTypes = document.getElementById('exerciseTypes');
    const exerciseGrid = document.getElementById('exerciseGrid');
    const timeButtons = document.querySelectorAll('.time-btn');
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
    // --- Minimal category click handler (no design changes) ---
    document.addEventListener('click', function(e){
    	
    	 const cat = e.target.closest('.category-card');
    	  if (cat) {
    	    // data-category에는 백엔드가 기대하는 값(예: sports)을 넣어둬야 함
    	    document.getElementById('exerciseCategory').value = cat.dataset.category;
    	  }

    	  const opt = e.target.closest('.exercise-option');
    	  if (opt) {
    	    document.getElementById('exerciseType').value = opt.dataset.name;
    	  }

    	  const tbtn = e.target.closest('.time-btn');
    	  if (tbtn) {
    	    const v = tbtn.dataset.time === 'custom'
    	      ? (document.getElementById('customDuration').value || '').trim()
    	      : tbtn.dataset.time;
    	    if (v) document.getElementById('leadTime').value = v; // 숫자(분) 기대
    	  }
    	
      var card = e.target.closest('.category-card');
      if (!card) return;
      e.preventDefault();
      var key = card.getAttribute('data-category');
      if (!key) return;
      // hidden calPart
      if (hiddenCategory) hiddenCategory.value = key;
      // highlight
      document.querySelectorAll('.category-card').forEach(function(el){
        el.classList.toggle('selected', el === card);
      });
      // render sub list
      if (typeof showExerciseTypes === 'function') {
        showExerciseTypes(key);
      }
    }, true);

    document.addEventListener('DOMContentLoaded', function(){
      var key = hiddenCategory && hiddenCategory.value ? hiddenCategory.value : null;
      if (key && typeof showExerciseTypes === 'function') {
        // preset highlight
        var presetCard = document.querySelector('.category-card[data-category="'+key+'"]');
        if (presetCard) presetCard.classList.add('selected');
        showExerciseTypes(key);
      }
    });
    // --- end minimal handler ---


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
            exerciseOption.className = 'exercise-option';
            exerciseOption.dataset.exercise = name;
            exerciseOption.dataset.met = met;
            exerciseOption.innerHTML = `
                <div class="exercise-name">\${name}</div>
                <div class="exercise-met">MET \${met}</div>
            `;
            
            exerciseOption.addEventListener('click', function() {
                document.querySelectorAll('.exercise-option').forEach(opt => {
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
    
    (function () {
    	  // 0) 버튼들이 submit 되지 않게 (혹시 type이 비어있으면 기본이 submit이라서)
    	  document.querySelectorAll('.time-btn, .category-btn, .exercise-option').forEach(function(btn){
    	    if (!btn.getAttribute('type')) btn.setAttribute('type','button');
    	  });

    	  // 1) 운동시간(leadTime)
    	  var leadTimeInput = document.getElementById('leadTime');
    	  var customInput   = document.getElementById('customDuration');

    	  document.addEventListener('click', function(e){
    	    var t = e.target;

    	    // 시간 버튼 (예: <button class="time-btn" data-time="60">60분</button>)
    	    if (t.classList.contains('time-btn')) {
    	      var v = t.getAttribute('data-time');
    	      // 선택 표시(디자인 클래스는 그대로 사용)
    	      document.querySelectorAll('.time-btn.selected').forEach(function(x){ x.classList.remove('selected'); });
    	      t.classList.add('selected');

    	      if (v === 'custom') {
    	        // 직접입력 모드면 입력창 값이 바뀔 때 leadTime 세팅 (아래 1-1에서 처리)
    	        customInput && customInput.focus();
    	      } else {
    	        leadTimeInput.value = v; // 숫자만 서버로
    	      }
    	    }

    	    // 2) 상위 카테고리 (예: <button class="category-btn" data-part="outdoor">아웃도어</button>)
    	    if (t.matches('[data-part]')) {
    	      var part = t.getAttribute('data-part');
    	      document.getElementById('calPart').value = part;
    	      // 선택 표시 유지(디자인 클래스 그대로)
    	      var wrap = t.closest('.category-wrap') || document;
    	      wrap.querySelectorAll('[data-part].active')?.forEach(function(x){ x.classList.remove('active'); });
    	      t.classList.add('active');
    	    }

    	    // 3) 하위 종목 (예: <button class="exercise-option" data-name="클라이밍">클라이밍</button>)
    	    if (t.matches('[data-name]')) {
    	      var name = t.getAttribute('data-name');
    	      document.getElementById('calName').value = name;
    	      var group = t.closest('.exercise-group') || document;
    	      group.querySelectorAll('[data-name].active')?.forEach(function(x){ x.classList.remove('active'); });
    	      t.classList.add('active');
    	    }
    	  });

    	  // 1-1) 직접입력(분) 변경 시 leadTime 세팅
    	  if (customInput) {
    	    customInput.addEventListener('input', function(){
    	      var n = parseInt(customInput.value, 10);
    	      if (!isNaN(n) && n > 0) leadTimeInput.value = n;
    	    });
    	  }

    	  // 4) 제출 전 값 검증 (비면 전송 막고 안내)
    	  var form = document.getElementById('fitnessForm');
    	  form.addEventListener('submit', function(e){
    	    var missing = [];
    	    if (!document.getElementById('calPart').value)  missing.push('카테고리');
    	    if (!document.getElementById('calName').value)  missing.push('운동 종목');
    	    if (!document.getElementById('leadTime').value) missing.push('운동 시간');

    	    if (missing.length) {
    	      e.preventDefault();
    	      alert(missing.join(', ') + '을(를) 선택/입력해줘!');
    	    }
    	  });
    	})();

</script>
</html>