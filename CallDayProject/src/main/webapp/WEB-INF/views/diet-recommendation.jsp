<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>AI 맞춤식단추천 - CDP Health</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/navbar.css">
    <link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/ai-diet-recommendation.css">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Pretendard:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- 모달 전용 스타일 -->
    <style>
        /* 모달 스타일링 */
        .exai-modal-content {
            background: rgba(26, 26, 26, 0.9);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
        }

        .exai-modal-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-bottom: none;
            border-radius: 20px 20px 0 0;
            padding: 1.5rem 2rem;
        }

        .exai-modal-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: white;
            margin: 0;
        }

        .exai-modal-title i {
            margin-right: 10px;
            animation: exaiModalRotate 4s linear infinite;
        }

        .exai-modal-close {
            filter: brightness(0) invert(1);
            opacity: 0.8;
            transition: all 0.3s ease;
        }

        .exai-modal-close:hover {
            opacity: 1;
            transform: rotate(90deg);
        }

        .exai-modal-body {
            padding: 2rem;
            background: #2a2a2a;
        }

        .exai-modal-success {
            text-align: center;
        }

        .exai-modal-icon-success {
            font-size: 3rem;
            color: #4facfe;
            margin-bottom: 1rem;
            animation: exaiModalPulse 2s infinite;
        }

        .exai-modal-error {
            text-align: center;
        }

        .exai-modal-icon-error {
            font-size: 3rem;
            color: #ff6b6b;
            margin-bottom: 1rem;
            animation: exaiModalPulse 2s infinite;
        }

        .exai-modal-subtitle {
            color: #ffffff;
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }

        .exai-modal-recommendation {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            padding: 1.5rem;
            color: #b3b3b3;
            line-height: 1.8;
            font-size: 1rem;
            white-space: pre-wrap;
            text-align: left;
            max-height: 400px;
            overflow-y: auto;
        }

        .exai-modal-error-message {
            background: rgba(255, 107, 107, 0.1);
            border: 1px solid rgba(255, 107, 107, 0.3);
            border-radius: 10px;
            padding: 1rem;
            color: #ff6b6b;
            text-align: left;
        }

        .exai-modal-footer {
            background: #2a2a2a;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 0 0 20px 20px;
            padding: 1.5rem 2rem;
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        .exai-modal-btn-copy {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .exai-modal-btn-copy:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(79, 172, 254, 0.4);
            color: white;
        }

        .exai-modal-btn-print {
            background: #888888;
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .exai-modal-btn-print:hover {
            transform: translateY(-2px);
            background: #666;
            color: white;
        }

        .exai-modal-btn-new {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .exai-modal-btn-new:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(250, 112, 154, 0.4);
            color: white;
        }

        .exai-modal-btn-close {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .exai-modal-btn-close:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.3);
            color: #ffffff;
        }

        @keyframes exaiModalRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes exaiModalPulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }

        /* 모바일 반응형 */
        @media (max-width: 768px) {
            .exai-modal-footer {
                flex-direction: column;
            }
            
            .exai-modal-footer .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body class="exai-body">
    <%@ include file="/WEB-INF/views/main_part/header.jsp" %>

	<div style="height: 60px;"></div>
    <div class="exai-main-container">
        <div class="exai-container">
            <!-- 영양 정보 사이드바 -->
            <div class="exai-nutrition-sidebar">
                <div class="exai-nutrition-header">
                    <div>
                        <div class="exai-nutrition-title">맞춤 식단</div>
                        <div class="exai-nutrition-subtitle">AI 개인화 추천</div>
                    </div>
                </div>

                <div class="exai-nutrition-display">
                    <div class="exai-nutrition-number" id="exaiCalorieDisplay">0</div>
                    <div class="exai-nutrition-unit">kcal 목표</div>
                </div>

                <div class="exai-nutrition-details">
                    <div class="exai-nutrition-row">
                        <span class="exai-nutrition-label">성별</span>
                        <span class="exai-nutrition-value" id="exaiGenderDisplay">-</span>
                    </div>
                    <div class="exai-nutrition-row">
                        <span class="exai-nutrition-label">나이</span>
                        <span class="exai-nutrition-value" id="exaiAgeDisplay">-</span>
                    </div>
                    <div class="exai-nutrition-row">
                        <span class="exai-nutrition-label">키</span>
                        <span class="exai-nutrition-value" id="exaiHeightDisplay">-</span>
                    </div>
                    <div class="exai-nutrition-row">
                        <span class="exai-nutrition-label">체중</span>
                        <span class="exai-nutrition-value" id="exaiWeightDisplay">-</span>
                    </div>
                    <div class="exai-nutrition-row">
                        <span class="exai-nutrition-label">목표</span>
                        <span class="exai-nutrition-value" id="exaiGoalDisplay">-</span>
                    </div>
                    <div class="exai-nutrition-row">
                        <span class="exai-nutrition-label">식사 시간</span>
                        <span class="exai-nutrition-value" id="exaiMealTimeDisplay">-</span>
                    </div>
                </div>

                <div class="exai-alert" id="exaiNutritionAlert">
                    개인 정보를 입력하면 맞춤형 식단을 추천해드려요!
                </div>
            </div>

            <!-- 메인 폼 -->
            <div class="exai-main-form">
                <div class="exai-form-header">
                    <h1>AI 식단 추천</h1>
                    <p>개인 맞춤형 건강 식단을 추천받아보세요</p>
                </div>

                <form action="<%=cp %>/ai/diet/recommend" method="post" id="exaiDietForm">
                    <!-- 기본 정보 -->
                    <div class="exai-input-row">
                        <div class="exai-input-group">
                            <label for="exaiAge">나이</label>
                            <input type="number" id="exaiAge" name="age" class="exai-input" placeholder="25" min="10" max="100" required>
                        </div>
                        <div class="exai-input-group">
                            <label for="exaiGender">성별</label>
                            <select id="exaiGender" name="gender" class="exai-input" required>
                                <option value="">선택하세요</option>
                                <option value="male">남성</option>
                                <option value="female">여성</option>
                            </select>
                        </div>
                    </div>

                    <div class="exai-input-row">
                        <div class="exai-input-group">
                            <label for="exaiHeight">키 (cm)</label>
                            <input type="number" id="exaiHeight" name="height" class="exai-input" placeholder="170" min="120" max="220" required>
                        </div>
                        <div class="exai-input-group">
                            <label for="exaiWeight">체중 (kg)</label>
                            <input type="number" id="exaiWeight" name="weight" class="exai-input" placeholder="65" min="30" max="200" required>
                        </div>
                    </div>

                    <!-- 목표 선택 -->
                    <div class="exai-input-group">
                        <label>식단 목표</label>
                        <div class="exai-goal-grid">
                            <div class="exai-goal-card" data-goal="diet">
                                <img src="<%=cp%>/resources/img/ex_a.png" width="40">
                                <div class="exai-goal-name">체중 감량</div>
                            </div>
                            
                            <div class="exai-goal-card" data-goal="muscle">
                                <img src="<%=cp%>/resources/img/ex_b.png" width="40">
                                <div class="exai-goal-name">근육 증가</div>
                            </div>
                           
                            <div class="exai-goal-card" data-goal="maintain">
                                <img src="<%=cp%>/resources/img/ex_c.png" width="40">
                                <div class="exai-goal-name">체중 유지</div>
                            </div>
                            
                            <div class="exai-goal-card" data-goal="health">
                                <img src="<%=cp%>/resources/img/ex_d.png" width="40">
                                <div class="exai-goal-name">건강 관리</div>
                            </div>
                        </div>
                    </div>

                    <!-- 식사 시간 선택 -->
                    <div class="exai-input-group">
                        <label>추천받을 식사</label>
                        <div class="exai-meal-buttons">
                            <button type="button" class="exai-meal-btn" data-meal="breakfast">아침</button>
                            <button type="button" class="exai-meal-btn" data-meal="lunch">점심</button>
                            <button type="button" class="exai-meal-btn" data-meal="dinner">저녁</button>
                            <button type="button" class="exai-meal-btn" data-meal="snack">간식</button>
                            <button type="button" class="exai-meal-btn" data-meal="all">전체</button>
                        </div>
                    </div>

                    <!-- 활동 수준 -->
                    <div class="exai-input-group">
                        <label for="exaiActivity">활동 수준</label>
                        <select id="exaiActivity" name="activity" class="exai-input" required>
                            <option value="">선택하세요</option>
                            <option value="sedentary">앉아서 일하는 편 (운동 거의 안함)</option>
                            <option value="light">가벼운 활동 (주 1-3회 운동)</option>
                            <option value="moderate">보통 활동 (주 3-5회 운동)</option>
                            <option value="active">활발한 활동 (주 6-7회 운동)</option>
                            <option value="very_active">매우 활발 (하루 2회 운동 또는 격한 운동)</option>
                        </select>
                    </div>

                    <!-- 알레르기/제외 음식 -->
                    <div class="exai-input-group">
                        <label for="exaiAllergies">알레르기/제외하고 싶은 음식</label>
                        <input type="text" id="exaiAllergies" name="allergies" class="exai-input" placeholder="예: 견과류, 해산물, 유제품 (선택사항)">
                    </div>

                    <!-- 선호 음식 -->
                    <div class="exai-input-group">
                        <label for="exaiPreferences">선호하는 음식 스타일</label>
                        <input type="text" id="exaiPreferences" name="preferences" class="exai-input" placeholder="예: 한식, 양식, 채식주의 (선택사항)">
                    </div>

                    <!-- 추가 요청사항 -->
                    <div class="exai-input-group">
                        <label for="exaiAdditionalRequest">추가 요청사항</label>
                        <textarea id="exaiAdditionalRequest" name="additionalRequest" class="exai-textarea" placeholder="특별한 요청이나 고려사항이 있으시면 자유롭게 작성해주세요."></textarea>
                    </div>

                    <!-- 숨겨진 필드들 -->
                    <input type="hidden" id="exaiSelectedGoal" name="goal">
                    <input type="hidden" id="exaiSelectedMeal" name="mealTime">
                    <input type="hidden" id="exaiCalculatedCalorie" name="targetCalorie">
                    <input type="hidden" id="exaiUserQuery" name="userQuery">

                    <button type="submit" class="exai-submit-btn">
                        AI 맞춤 식단 추천받기
                    </button>
                </form>

                <!-- 추천 결과 표시 - 모달로 변경 -->
                <c:if test="${not empty recommendation}">
                    <!-- 모달 트리거 스크립트 -->
                    <script>
                        // 페이지 로드 시 모달 자동 열기
                        document.addEventListener('DOMContentLoaded', function() {
                            const resultModal = new bootstrap.Modal(document.getElementById('exaiResultModal'));
                            resultModal.show();
                        });
                    </script>
                </c:if>
            </div>
        </div>
    </div>

    <!-- 결과 모달 -->
    <div class="modal fade" id="exaiResultModal" tabindex="-1" aria-labelledby="exaiResultModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content exai-modal-content">
                <div class="modal-header exai-modal-header">
                    <h5 class="modal-title exai-modal-title" id="exaiResultModalLabel">
                        <i class="fas fa-robot"></i>
                        AI 식단 분석 결과
                    </h5>
                    <button type="button" class="btn-close exai-modal-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body exai-modal-body">
                    <c:if test="${not empty recommendation}">
                        <c:choose>
                            <c:when test="${recommendation.status == 'SUCCESS'}">
                                <div class="exai-modal-success">
                                    <div class="exai-modal-icon-success">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <h6 class="exai-modal-subtitle">맞춤형 식단 추천이 완성되었습니다!</h6>
                                    <div class="exai-modal-recommendation"> ${recommendation.recommendation} </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="exai-modal-error">
                                    <div class="exai-modal-icon-error">
                                        <i class="fas fa-exclamation-triangle"></i>
                                    </div>
                                    <h6 class="exai-modal-subtitle">처리 중 오류가 발생했습니다</h6>
                                    <div class="exai-modal-error-message">
                                        <strong>오류 내용:</strong> ${recommendation.errorMessage}
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </div>
                <div class="modal-footer exai-modal-footer">
                    <button type="button" class="btn exai-modal-btn-copy" onclick="exaiCopyModalResult()">
                        <i class="fas fa-copy"></i> 복사하기
                    </button>
                    
                    <button type="button" class="btn exai-modal-btn-close" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/main_part/footer.jsp" %>
    
    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 전역 변수
        let exaiSelectedGoal = '';
        let exaiSelectedMeal = '';
        let exaiCurrentAge = 0;
        let exaiCurrentGender = '';
        let exaiCurrentHeight = 0;
        let exaiCurrentWeight = 0;
        let exaiCurrentActivity = '';

        // DOM 요소
        const exaiGoalCards = document.querySelectorAll('.exai-goal-card');
        const exaiMealButtons = document.querySelectorAll('.exai-meal-btn');
        const exaiAgeInput = document.getElementById('exaiAge');
        const exaiGenderInput = document.getElementById('exaiGender');
        const exaiHeightInput = document.getElementById('exaiHeight');
        const exaiWeightInput = document.getElementById('exaiWeight');
        const exaiActivityInput = document.getElementById('exaiActivity');

        // 사이드바 표시 요소들
        const exaiCalorieDisplay = document.getElementById('exaiCalorieDisplay');
        const exaiGenderDisplay = document.getElementById('exaiGenderDisplay');
        const exaiAgeDisplay = document.getElementById('exaiAgeDisplay');
        const exaiHeightDisplay = document.getElementById('exaiHeightDisplay');
        const exaiWeightDisplay = document.getElementById('exaiWeightDisplay');
        const exaiGoalDisplay = document.getElementById('exaiGoalDisplay');
        const exaiMealTimeDisplay = document.getElementById('exaiMealTimeDisplay');

        // 숨겨진 필드들
        const exaiHiddenGoal = document.getElementById('exaiSelectedGoal');
        const exaiHiddenMeal = document.getElementById('exaiSelectedMeal');
        const exaiHiddenCalorie = document.getElementById('exaiCalculatedCalorie');
        const exaiHiddenUserQuery = document.getElementById('exaiUserQuery');

        // 초기화
        document.addEventListener('DOMContentLoaded', function() {
            exaiUpdateDisplay();
        });

        // 목표 선택
        exaiGoalCards.forEach(card => {
            card.addEventListener('click', function() {
                exaiGoalCards.forEach(c => c.classList.remove('exai-selected'));
                this.classList.add('exai-selected');
                exaiSelectedGoal = this.dataset.goal;
                exaiHiddenGoal.value = exaiSelectedGoal;
                exaiUpdateDisplay();
                
                this.style.transform = 'scale(0.95)';
                setTimeout(() => { this.style.transform = ''; }, 150);
            });
        });

        // 식사 시간 선택
        exaiMealButtons.forEach(btn => {
            btn.addEventListener('click', function() {
                exaiMealButtons.forEach(b => b.classList.remove('exai-selected'));
                this.classList.add('exai-selected');
                exaiSelectedMeal = this.dataset.meal;
                exaiHiddenMeal.value = exaiSelectedMeal;
                exaiUpdateDisplay();

                this.style.transform = 'scale(0.95)';
                setTimeout(() => { this.style.transform = ''; }, 150);
            });
        });

        // 입력 필드 이벤트
        [exaiAgeInput, exaiGenderInput, exaiHeightInput, exaiWeightInput, exaiActivityInput].forEach(input => {
            input.addEventListener('input', function() {
                exaiCurrentAge = parseInt(exaiAgeInput.value) || 0;
                exaiCurrentGender = exaiGenderInput.value;
                exaiCurrentHeight = parseInt(exaiHeightInput.value) || 0;
                exaiCurrentWeight = parseInt(exaiWeightInput.value) || 0;
                exaiCurrentActivity = exaiActivityInput.value;
                exaiUpdateDisplay();
            });
        });

        // 표시 업데이트
        function exaiUpdateDisplay() {
            const exaiBmr = exaiCalculateBMR(exaiCurrentGender, exaiCurrentWeight, exaiCurrentHeight, exaiCurrentAge);
            const exaiTdee = exaiCalculateTDEE(exaiBmr, exaiCurrentActivity);
            
            exaiCalorieDisplay.textContent = Math.round(exaiTdee);
            exaiGenderDisplay.textContent = exaiCurrentGender ? (exaiCurrentGender === 'male' ? '남성' : '여성') : '-';
            exaiAgeDisplay.textContent = exaiCurrentAge ? exaiCurrentAge + '세' : '-';
            exaiHeightDisplay.textContent = exaiCurrentHeight ? exaiCurrentHeight + 'cm' : '-';
            exaiWeightDisplay.textContent = exaiCurrentWeight ? exaiCurrentWeight + 'kg' : '-';
            exaiGoalDisplay.textContent = exaiGetGoalText(exaiSelectedGoal);
            exaiMealTimeDisplay.textContent = exaiGetMealText(exaiSelectedMeal);
            
            exaiHiddenCalorie.value = Math.round(exaiTdee);
        }

        // BMR 계산 (해리스-베네딕트 공식)
        function exaiCalculateBMR(gender, weight, height, age) {
            if (!gender || !weight || !height || !age) return 0;
            
            if (gender === 'male') {
                return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
            } else {
                return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
            }
        }

        // TDEE 계산 (총 일일 에너지 소비량)
        function exaiCalculateTDEE(bmr, activity) {
            if (!bmr || !activity) return bmr;
            
            const exaiActivityMultipliers = {
                'sedentary': 1.2,
                'light': 1.375,
                'moderate': 1.55,
                'active': 1.725,
                'very_active': 1.9
            };
            
            return bmr * (exaiActivityMultipliers[activity] || 1.2);
        }

        // 목표 텍스트 변환
        function exaiGetGoalText(goal) {
            const exaiGoalTexts = {
                'diet': '체중 감량',
                'muscle': '근육 증가',
                'maintain': '체중 유지',
                'health': '건강 관리'
            };
            return exaiGoalTexts[goal] || '-';
        }

        // 식사 시간 텍스트 변환
        function exaiGetMealText(meal) {
            const exaiMealTexts = {
                'breakfast': '아침',
                'lunch': '점심',
                'dinner': '저녁',
                'snack': '간식',
                'all': '전체'
            };
            return exaiMealTexts[meal] || '-';
        }

        // 폼 제출 전 검증 및 userQuery 생성
        document.getElementById('exaiDietForm').addEventListener('submit', function(e) {
            if (!exaiSelectedGoal || !exaiSelectedMeal) {
                e.preventDefault();
                alert('식단 목표와 식사 시간을 선택해주세요!');
                return false;
            }
            
            const exaiRequiredFields = ['exaiAge', 'exaiGender', 'exaiHeight', 'exaiWeight', 'exaiActivity'];
            for (let field of exaiRequiredFields) {
                if (!document.getElementById(field).value.trim()) {
                    e.preventDefault();
                    alert('모든 필수 정보를 입력해주세요!');
                    return false;
                }
            }
            
            // userQuery 생성
            const age = document.getElementById('exaiAge').value;
            const gender = document.getElementById('exaiGender').value === 'male' ? '남성' : '여성';
            const height = document.getElementById('exaiHeight').value;
            const weight = document.getElementById('exaiWeight').value;
            const goal = exaiGetGoalText(exaiSelectedGoal);
            const meal = exaiGetMealText(exaiSelectedMeal);
            const activity = document.getElementById('exaiActivity').selectedOptions[0].text;
            const allergies = document.getElementById('exaiAllergies').value;
            const preferences = document.getElementById('exaiPreferences').value;
            const additional = document.getElementById('exaiAdditionalRequest').value;
            const targetCalorie = Math.round(exaiCalculateTDEE(exaiCalculateBMR(document.getElementById('exaiGender').value, parseInt(weight), parseInt(height), parseInt(age)), document.getElementById('exaiActivity').value));
            
            let query = age + '세' + gender + ', 키 '+ height + 'cm, 체중' + weight + 'kg, 목표:' + 
             goal+ ', 활동 수준:' + activity + ', 목표 칼로리:' + targetCalorie + 'kcal 사용자에게 ' + meal+ ' 식사를 추천해주세요.';
            
            if (allergies) {
                query += ', 알레르기/제외 음식 : ' + allergies;
            }
            if (preferences) {
                query += ', 선호 음식:' + preferences;
            }
            if (additional) {
                query += ' , 추가 요청:' + additional;
            }
            
            exaiHiddenUserQuery.value = query;
            
            // 디버깅용
            console.log('전송할 userQuery:', query);
            
            if (!query || query.trim() === '') {
                console.error('userQuery가 비어있습니다!');
                alert('데이터 생성 실패!');
                e.preventDefault();
                return false;
            }
            
            return true;
        });

        // 모달 관련 함수들
        function exaiCopyModalResult() {
            const resultText = document.querySelector('.exai-modal-recommendation')?.textContent || 
                             document.querySelector('.exai-modal-error-message')?.textContent || '';
            
            if (navigator.clipboard && resultText) {
                navigator.clipboard.writeText(resultText).then(() => {
                    exaiShowToast('복사되었습니다!', 'success');
                }).catch(() => {
                    exaiFallbackCopy(resultText);
                });
            } else if (resultText) {
                exaiFallbackCopy(resultText);
            }
        }

        function exaiFallbackCopy(text) {
            const textArea = document.createElement('textarea');
            textArea.value = text;
            document.body.appendChild(textArea);
            textArea.select();
            try {
                document.execCommand('copy');
                exaiShowToast('복사되었습니다!', 'success');
            } catch (err) {
                exaiShowToast('복사에 실패했습니다.', 'error');
            }
            document.body.removeChild(textArea);
        }

        function exaiPrintModalResult() {
            const recommendation = document.querySelector('.exai-modal-recommendation')?.textContent || 
                                 document.querySelector('.exai-modal-error-message')?.textContent || '';
            const currentDate = new Date().toLocaleDateString('ko-KR');
            
            const printWindow = window.open('', '_blank');
            const printContent = `
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset="UTF-8">
                    <title>AI 맞춤식단추천 결과</title>
                    <style>
                        body { 
                            font-family: 'Malgun Gothic', sans-serif; 
                            padding: 30px; 
                            background: #1a1a1a; 
                            color: #fff; 
                            line-height: 1.6;
                        }
                        .header { 
                            border-bottom: 2px solid #4facfe; 
                            padding-bottom: 20px; 
                            margin-bottom: 30px; 
                            text-align: center;
                        }
                        .title { 
                            font-size: 24px; 
                            font-weight: bold; 
                            color: #4facfe; 
                            margin-bottom: 10px;
                        }
                        .date { 
                            color: #999; 
                        }
                        .content { 
                            background: #2a2a2a; 
                            padding: 25px; 
                            border-radius: 10px; 
                            border-left: 4px solid #4facfe;
                            margin-top: 20px;
                        }
                        .footer {
                            text-align: center;
                            margin-top: 40px;
                            color: #666;
                            font-size: 14px;
                        }
                    </style>
                </head>
                <body>
                    <div class="header">
                        <div class="title">🤖 AI 맞춤식단추천 결과</div>
                        <div class="date">생성일: ${currentDate}</div>
                    </div>
                    <div class="content">${recommendation}</div>
                    <div class="footer">CDP Health - AI 맞춤식단추천 서비스</div>
                </body>
                </html>
            `;
            
            printWindow.document.write(printContent);
            printWindow.document.close();
            setTimeout(() => printWindow.print(), 500);
        }

        function exaiNewRecommendation() {
            // 모달 닫기
            const modal = bootstrap.Modal.getInstance(document.getElementById('exaiResultModal'));
            if (modal) modal.hide();
            
            // 폼 초기화
            document.getElementById('exaiDietForm').reset();
            
            // 선택 상태 초기화
            document.querySelectorAll('.exai-goal-card').forEach(card => {
                card.classList.remove('exai-selected');
            });
            document.querySelectorAll('.exai-meal-btn').forEach(btn => {
                btn.classList.remove('exai-selected');
            });
            
            // 변수 초기화
            exaiSelectedGoal = '';
            exaiSelectedMeal = '';
            exaiCurrentAge = 0;
            exaiCurrentGender = '';
            exaiCurrentHeight = 0;
            exaiCurrentWeight = 0;
            exaiCurrentActivity = '';
            
            // 사이드바 업데이트
            exaiUpdateDisplay();
            
            // 폼 상단으로 스크롤
            document.querySelector('.exai-form-header').scrollIntoView({ 
                behavior: 'smooth' 
            });
            
            exaiShowToast('새로운 추천을 시작하세요!', 'info');
        }

        // 토스트 알림 함수
        function exaiShowToast(message, type = 'info') {
            // 기존 토스트 제거
            const existingToast = document.querySelector('.exai-toast');
            if (existingToast) {
                existingToast.remove();
            }
            
            const colors = {
                success: '#4facfe',
                error: '#ff6b6b',
                info: '#667eea',
                warning: '#fa709a'
            };
            
            const icons = {
                success: 'fas fa-check-circle',
                error: 'fas fa-exclamation-circle',
                info: 'fas fa-info-circle',
                warning: 'fas fa-exclamation-triangle'
            };
            
            const toast = document.createElement('div');
            toast.className = 'exai-toast';
            toast.style.cssText = `
                position: fixed;
                top: 30px;
                right: 30px;
                background: ${colors[type]};
                color: white;
                padding: 15px 25px;
                border-radius: 10px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
                z-index: 9999;
                font-weight: 600;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 10px;
                transform: translateX(100%);
                transition: all 0.3s ease;
                backdrop-filter: blur(10px);
            `;
            
            toast.innerHTML = `<i class="${icons[type]}"></i>${message}`;
            document.body.appendChild(toast);
            
            // 애니메이션
            setTimeout(() => {
                toast.style.transform = 'translateX(0)';
            }, 100);
            
            // 3초 후 제거
            setTimeout(() => {
                toast.style.transform = 'translateX(100%)';
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }
    </script>
</body>
</html>