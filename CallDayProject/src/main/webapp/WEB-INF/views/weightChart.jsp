<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Weight Tracker - Call Day</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/wt.css">
    <link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/navbar.css">
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
   
      
   
</head>
<body>

<%@ include file="/WEB-INF/views/main_part/header.jsp" %>



<main class="cd-scope theme-solid">

<div style="height: 100px;"></div> 
    <div class="container fade-in">
        <div class="header">
            <h1><i class="fas fa-dumbbell"></i> Weight Tracker</h1>
            <p> Call Day 체중기록 시스템  </p>
        </div>

        <!-- 메시지 표시 -->
        <c:if test="${not empty message}">
            <div class="message success">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="message error">
                <i class="fas fa-exclamation-triangle"></i> ${error}
            </div>
        </c:if>

        <!-- 목표체중 설정 카드 -->
        <div class="card goal-setting">
            <h3 style="color: #ff8e53; margin-bottom: 20px;">
                <i class="fas fa-target"></i> 목표체중 설정
            </h3>
            <div class="goal-input-group">
                <input type="number" id="goalWeight" class="form-control" 
                       placeholder="목표체중 (kg)" step="0.1" min="30" max="200">
                <button class="btn btn-primary" onclick="setGoalWeight()">
                    <i class="fas fa-save"></i> 설정
                </button>
            </div>
            <div class="goal-display">
                <strong style="color: #ff8e53;">현재 목표:</strong> 
                <span id="currentGoal">설정되지 않음</span>
                <div class="goal-progress" id="goalProgress"></div>
            </div>
        </div>

        <!-- 통계 카드 -->
        <c:if test="${not empty weightRecords}">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value">${weightRecords[0].currentweight}kg</div>
                    <div class="stat-label">현재 체중</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">${weightRecords[0].userheight}cm</div>
                    <div class="stat-label">키</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">
                        <fmt:formatNumber value="${weightRecords[0].currentweight / ((weightRecords[0].userheight/100) * (weightRecords[0].userheight/100))}" pattern="#.#"/>
                    </div>
                    <div class="stat-label">BMI</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">${weightRecords.size()}</div>
                    <div class="stat-label">총 기록 수</div>
                </div>
            </div>

            <!-- 체중 변화 차트 -->
            <div class="card chart-container">
                <h3 style="color: #ff8e53; margin-bottom: 20px;">
                    <i class="fas fa-chart-line"></i> 체중 변화 추이
                </h3>
                <div class="chart-wrapper">
                    <canvas id="weightChart"></canvas>
                </div>
                <div class="goal-legend">
                    <div class="legend-item">
                        <div class="legend-line current-line"></div>
                        <strong style="color: #ff8e53;">현재 체중</strong> 
                    </div>
                    <div class="legend-item">
                        <div class="legend-line goal-line"></div>
                        <strong style="color: #ff8e53;">목표 체중</strong> 
                    </div>
                </div>
            </div>
        </c:if>

        <div class="main-grid">
            <!-- 체중 기록 추가 폼 -->
            <div class="card">
                <h3 style="color: #ff8e53; margin-bottom: 20px;">
                    <i class="fas fa-plus-circle"></i> 새 기록 추가
                </h3>
                
                <form action="${pageContext.request.contextPath}/weight/add" method="post">
                    <div class="form-group">
                        <label for="currentweight">
                            <i class="fas fa-weight"></i> 체중 (kg)
                        </label>
                        <input type="number" id="currentweight" name="currentweight" 
                               class="form-control" step="0.1" min="0" max="300" 
                               placeholder="예: 70.5" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="userheight">
                            <i class="fas fa-ruler-vertical"></i> 키 (cm)
                        </label>
                        <input type="number" id="userheight" name="userheight" 
                               class="form-control" min="100" max="250" 
                               placeholder="예: 175" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="recorddate">
                            <i class="fas fa-calendar"></i> 기록 날짜
                        </label>
                        <input type="date" id="recorddate" name="recorddate" 
                               class="form-control" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="weightmemo">
                            <i class="fas fa-sticky-note"></i> 메모 (선택)
                        </label>
                        <textarea id="weightmemo" name="weightmemo" class="form-control" 
                                rows="3" placeholder="오늘의 운동이나 식단에 대한 메모를 남겨보세요..."></textarea>
                    </div>
                    
                    <button type="submit" class="btn btn-primary" style="width: 100%;">
                        <i class="fas fa-save"></i> 기록 저장
                    </button>
                </form>
            </div>

            <!-- 체중 기록 목록 -->
            <div class="card">
                <h3 style="color: #ff8e53; margin-bottom: 20px;">
                    <i class="fas fa-chart-line"></i> 체중 기록 내역
                    <small style="font-size: 0.6em; color: #b0b0b0;">(더블클릭으로 수정)</small>
                </h3>
                
                <c:choose>
                    <c:when test="${empty weightRecords}">
                        <div class="no-records">
                            <i class="fas fa-clipboard" style="font-size: 3em; margin-bottom: 20px; color: #666;"></i>
                            <p>아직 기록된 체중이 없습니다.</p>
                            <p>첫 번째 기록을 추가해보세요!</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="records-table">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th><i class="fas fa-calendar"></i> 날짜</th>
                                        <th><i class="fas fa-weight"></i> 체중</th>
                                        <th><i class="fas fa-ruler-vertical"></i> 키</th>
                                        <th><i class="fas fa-calculator"></i> BMI</th>
                                        <th><i class="fas fa-sticky-note"></i> 메모</th>
                                        <th><i class="fas fa-cog"></i> 관리</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="record" items="${weightRecords}">
                                        <tr data-record-id="${record.weightrecordid}">
                                            <td class="editable-cell" data-field="recorddate" 
                                                ondblclick="makeEditable(this, ${record.weightrecordid}, 'recorddate', 'date')">
                                                ${record.recorddate}
                                            </td>
                                            <td class="editable-cell" data-field="currentweight" 
                                                ondblclick="makeEditable(this, ${record.weightrecordid}, 'currentweight', 'number')">
                                                <strong style="color: #ff8e53;">${record.currentweight}kg</strong>
                                            </td>
                                            <td class="editable-cell" data-field="userheight" 
                                                ondblclick="makeEditable(this, ${record.weightrecordid}, 'userheight', 'number')">
                                                ${record.userheight}cm
                                            </td>
                                            <td>
                                                <c:set var="bmi" value="${record.currentweight / ((record.userheight/100) * (record.userheight/100))}"/>
                                                <fmt:formatNumber value="${bmi}" pattern="#.#"/>
                                            </td>
                                            <td class="editable-cell" data-field="weightmemo" 
                                                ondblclick="makeEditable(this, ${record.weightrecordid}, 'weightmemo', 'text')">
                                                <c:choose>
                                                    <c:when test="${empty record.weightmemo}">
                                                        <span style="color: #666;">-</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${record.weightmemo}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <!-- 수정된 삭제 버튼 -->
                                                <button type="button" class="btn btn-danger" 
                                                        onclick="confirmDelete(${record.weightrecordid})"
                                                        style="padding: 8px 12px;">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</main>

<%@ include file="/WEB-INF/views/main_part/footer.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<script>
let goalWeight = localStorage.getItem('goalWeight') || null;
let weightChart = null;

// 목표체중 설정 함수
function setGoalWeight() {
    const goalInput = document.getElementById('goalWeight');
    const goal = parseFloat(goalInput.value);
    
    if (isNaN(goal) || goal < 30 || goal > 200) {
        alert('올바른 목표체중을 입력해주세요 (30-200kg)');
        return;
    }
    
    goalWeight = goal;
    localStorage.setItem('goalWeight', goal);
    updateGoalDisplay();
    updateChart();
    
    // 성공 메시지
    showMessage('목표체중이 설정되었습니다!', 'success');
    goalInput.value = '';
}

// 목표체중 표시 업데이트
function updateGoalDisplay() {
    const currentGoalElement = document.getElementById('currentGoal');
    const goalProgressElement = document.getElementById('goalProgress');
    
    if (goalWeight) {
        currentGoalElement.textContent = goalWeight + 'kg';
        
        <c:if test="${not empty weightRecords}">
        const currentWeight = ${weightRecords[0].currentweight};
        const difference = currentWeight - goalWeight;
        
        if (Math.abs(difference) < 0.1) {
            goalProgressElement.innerHTML = '<span style="color: #4CAF50;"><i class="fas fa-trophy"></i> 목표 달성!</span>';
        } else if (difference > 0) {
            goalProgressElement.innerHTML = '<span style="color: #ff8e53;">목표까지 ' + difference.toFixed(1) + 'kg 감량 필요</span>';
        } else {
            goalProgressElement.innerHTML = '<span style="color: #81c784;">목표까지 ' + Math.abs(difference).toFixed(1) + 'kg 증량 필요</span>';
        }
        </c:if>
    } else {
        currentGoalElement.textContent = '설정되지 않음';
        goalProgressElement.innerHTML = '';
    }
}

// 삭제 확인 함수 추가
function confirmDelete(weightrecordid) {
    if (confirm('정말 삭제하시겠습니까?\n삭제된 기록은 복구할 수 없습니다.')) {
        // 삭제 폼 제출
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '${pageContext.request.contextPath}/weight/delete';
        
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'weightrecordid';
        input.value = weightrecordid;
        
        form.appendChild(input);
        document.body.appendChild(form);
        form.submit();
    }
    return false;
}

// 입력 유효성 검사 함수 추가
function validateInput(field, value) {
    switch (field) {
        case 'currentweight':
            const weight = parseFloat(value);
            if (isNaN(weight) || weight <= 0 || weight > 300) {
                alert('체중은 0.1~300kg 사이의 숫자를 입력해주세요.');
                return false;
            }
            break;
            
        case 'userheight':
            const height = parseInt(value);
            if (isNaN(height) || height < 100 || height > 250) {
                alert('키는 100~250cm 사이의 숫자를 입력해주세요.');
                return false;
            }
            break;
            
        case 'recorddate':
            if (!value || !/^\d{4}-\d{2}-\d{2}$/.test(value)) {
                alert('올바른 날짜 형식(YYYY-MM-DD)을 입력해주세요.');
                return false;
            }
            break;
    }
    return true;
}

// 인라인 수정 함수 - 유효성 검사 추가
function makeEditable(cell, recordId, field, inputType) {
    if (cell.querySelector('input') || cell.querySelector('textarea')) return;
    
    const originalValue = cell.textContent.trim().replace('kg', '').replace('cm', '').replace('-', '');
    const isEmptyMemo = cell.textContent.trim() === '-';
    
    let inputElement;
    if (field === 'weightmemo') {
        inputElement = document.createElement('textarea');
        inputElement.rows = 2;
        inputElement.value = isEmptyMemo ? '' : originalValue;
    } else {
        inputElement = document.createElement('input');
        inputElement.type = inputType;
        inputElement.value = originalValue;
        
        if (inputType === 'number') {
            inputElement.step = field === 'currentweight' ? '0.1' : '1';
            inputElement.min = field === 'currentweight' ? '0.1' : '100';
            inputElement.max = field === 'currentweight' ? '300' : '250';
        }
    }
    
    inputElement.className = 'edit-input';
    
    const buttonContainer = document.createElement('div');
    buttonContainer.className = 'save-cancel-buttons';
    
    const saveBtn = document.createElement('button');
    saveBtn.textContent = '저장';
    saveBtn.className = 'save-btn';
    saveBtn.onclick = () => {
        if (validateInput(field, inputElement.value)) {
            saveEdit(cell, recordId, field, inputElement.value, originalValue);
        }
    };
    
    const cancelBtn = document.createElement('button');
    cancelBtn.textContent = '취소';
    cancelBtn.className = 'cancel-btn';
    cancelBtn.onclick = () => cancelEdit(cell, originalValue, field);
    
    buttonContainer.appendChild(saveBtn);
    buttonContainer.appendChild(cancelBtn);
    
    cell.innerHTML = '';
    cell.appendChild(inputElement);
    cell.appendChild(buttonContainer);
    
    inputElement.focus();
    inputElement.select();
    
    // Enter 키로 저장, ESC 키로 취소
    inputElement.onkeydown = function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            if (validateInput(field, inputElement.value)) {
                saveEdit(cell, recordId, field, inputElement.value, originalValue);
            }
        } else if (e.key === 'Escape') {
            e.preventDefault();
            cancelEdit(cell, originalValue, field);
        }
    };
}

// 수정 저장 - 응답 처리 개선
function saveEdit(cell, recordId, field, newValue, originalValue) {
    if (!newValue.trim() && field !== 'weightmemo') {
        alert('값을 입력해주세요.');
        return;
    }
    
    // AJAX로 서버에 업데이트 요청
    $.ajax({
        url: '${pageContext.request.contextPath}/weight/updateField',
        method: 'POST',
        data: {
            weightrecordid: recordId,
            field: field,
            value: newValue
        },
        success: function(response) {
            // 서버 응답 타입 확인 후 처리
            if (typeof response === 'string') {
                try {
                    response = JSON.parse(response);
                } catch (e) {
                    console.error('JSON 파싱 오류:', e);
                    alert('서버 응답 처리 중 오류가 발생했습니다.');
                    cancelEdit(cell, originalValue, field);
                    return;
                }
            }
            
            if (response.success) {
                updateCellDisplay(cell, field, newValue);
                showMessage(response.message || '수정되었습니다!', 'success');
                
                // BMI 재계산이 필요한 경우
                if (field === 'currentweight' || field === 'userheight') {
                    updateBMI(recordId);
                    // 차트와 통계 새로고침
                    setTimeout(() => {
                        location.reload();
                    }, 1000);
                }
            } else {
                alert(response.message || '수정 중 오류가 발생했습니다.');
                cancelEdit(cell, originalValue, field);
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX 오류:', error);
            console.error('응답:', xhr.responseText);
            
            try {
                const errorResponse = JSON.parse(xhr.responseText);
                alert(errorResponse.message || '수정 중 오류가 발생했습니다.');
            } catch (e) {
                alert('수정 중 오류가 발생했습니다.');
            }
            
            cancelEdit(cell, originalValue, field);
        }
    });
}

// 수정 취소
function cancelEdit(cell, originalValue, field) {
    updateCellDisplay(cell, field, originalValue);
}

// 셀 표시 업데이트
function updateCellDisplay(cell, field, value) {
    let displayValue = value;
    
    if (field === 'currentweight') {
        displayValue = '<strong style="color: #ff8e53;">' + value + 'kg</strong>';
    } else if (field === 'userheight') {
        displayValue = value + 'cm';
    } else if (field === 'weightmemo') {
        displayValue = value.trim() || '<span style="color: #666;">-</span>';
    }
    
    cell.innerHTML = displayValue;
}

// BMI 재계산
function updateBMI(recordId) {
    const row = document.querySelector(`tr[data-record-id="${recordId}"]`);
    const weightCell = row.querySelector('[data-field="currentweight"]');
    const heightCell = row.querySelector('[data-field="userheight"]');
    const bmiCell = row.children[3];
    
    const weight = parseFloat(weightCell.textContent.replace('kg', ''));
    const height = parseFloat(heightCell.textContent.replace('cm', ''));
    
    const bmi = weight / ((height / 100) * (height / 100));
    bmiCell.textContent = bmi.toFixed(1);
}

// 메시지 표시 - 개선된 버전
function showMessage(text, type) {
    // 기존 메시지 제거
    const existingMessages = document.querySelectorAll('.message');
    existingMessages.forEach(msg => msg.remove());
    
    const messageDiv = document.createElement('div');
    messageDiv.className = `message ${type}`;
    
    const icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-triangle';
    messageDiv.innerHTML = `<i class="fas ${icon}"></i> ${text}`;
    
    const container = document.querySelector('.container');
    const header = container.querySelector('.header');
    
    // 헤더 다음에 메시지 삽입
    if (header && header.nextSibling) {
        container.insertBefore(messageDiv, header.nextSibling);
    } else {
        container.insertBefore(messageDiv, container.firstChild);
    }
    
    // 3초 후 자동 제거
    setTimeout(() => {
        if (messageDiv && messageDiv.parentNode) {
            messageDiv.remove();
        }
    }, 3000);
}

// 차트 업데이트
function updateChart() {
    if (weightChart && goalWeight) {
        // 목표 라인 추가
        const goalLine = {
            label: '목표체중',
            data: new Array(weightChart.data.labels.length).fill(goalWeight),
            borderColor: '#00ff00',
            borderDash: [5, 5],
            borderWidth: 2,
            fill: false,
            pointRadius: 0,
            pointHoverRadius: 0
        };
        
        // 기존 목표 라인 제거 후 새로 추가
        weightChart.data.datasets = weightChart.data.datasets.filter(dataset => dataset.label !== '목표체중');
        weightChart.data.datasets.push(goalLine);
        weightChart.update();
    }
}

// 페이지 로드 시 실행
document.addEventListener('DOMContentLoaded', function() {
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('recorddate').value = today;
    
    // 목표체중 표시 업데이트
    updateGoalDisplay();
    
    // 폼 제출시 로딩 효과
    document.querySelector('form').addEventListener('submit', function() {
        const submitBtn = this.querySelector('button[type="submit"]');
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 저장 중...';
        submitBtn.disabled = true;
    });
    
    // 체중 차트 생성
    <c:if test="${not empty weightRecords}">
    const ctx = document.getElementById('weightChart').getContext('2d');
    
    const chartData = [];
    <c:forEach var="record" items="${weightRecords}">
        chartData.push({
            date: '${record.recorddate}',
            weight: ${record.currentweight}
        });
    </c:forEach>
    
    chartData.sort((a, b) => new Date(a.date) - new Date(b.date));
    
    const dates = chartData.map(item => item.date);
    const weights = chartData.map(item => item.weight);
    
    const datasets = [{
        label: '체중 (kg)',
        data: weights,
        borderColor: '#ff6b35',
        backgroundColor: 'rgba(255, 107, 53, 0.1)',
        borderWidth: 3,
        fill: true,
        tension: 0.4,
        pointBackgroundColor: '#ff6b35',
        pointBorderColor: '#ffffff',
        pointBorderWidth: 2,
        pointRadius: 6,
        pointHoverRadius: 8
    }];
    
    // 목표체중 라인 추가
    if (goalWeight) {
        datasets.push({
            label: '목표체중',
            data: new Array(dates.length).fill(goalWeight),
            borderColor: '#00ff00',
            borderDash: [5, 5],
            borderWidth: 2,
            fill: false,
            pointRadius: 0,
            pointHoverRadius: 0
        });
    }
    
    weightChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: dates,
            datasets: datasets
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    labels: {
                        color: '#e0e0e0',
                        font: { size: 14 }
                    }
                },
                tooltip: {
                    backgroundColor: 'rgba(0, 0, 0, 0.8)',
                    titleColor: '#ff8e53',
                    bodyColor: '#e0e0e0',
                    borderColor: '#ff6b35',
                    borderWidth: 1
                }
            },
            scales: {
                y: {
                    beginAtZero: false,
                    ticks: {
                        color: '#e0e0e0',
                        font: { size: 12 }
                    },
                    grid: { color: 'rgba(255, 255, 255, 0.1)' },
                    title: {
                        display: true,
                        text: '체중 (kg)',
                        color: '#ff8e53'
                    }
                },
                x: {
                    ticks: {
                        color: '#e0e0e0',
                        font: { size: 12 }
                    },
                    grid: { color: 'rgba(255, 255, 255, 0.1)' },
                    title: {
                        display: true,
                        text: '날짜',
                        color: '#ff8e53'
                    }
                }
            }
        }
    });
    </c:if>
});
</script>
</body>
</html>