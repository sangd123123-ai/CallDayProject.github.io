<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<body>
<%-- Auto-generated workout table from 11.xlsx --%>
<style>
.table-wrap { overflow-x: auto; }
.table-wrap table { border-collapse: collapse; width: 100%; }
.table-wrap th, .table-wrap td { border: 1px solid #ddd; padding: 8px; vertical-align: top; }
.table-wrap th { background: #f7f7f7; text-align: left; }
</style>
<div class="table-wrap">
<table class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>운동 파트</th>
      <th>운동 이름</th>
      <th>타겟 근육</th>
      <th>운동 효과</th>
      <th>운동 방법</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>덤벨 플랫 벤치 프레스</td>
      <td>대흉근, 삼각근, 삼두근</td>
      <td>가슴 전체 발달, 가슴 두께 증가, 상체 파워 향상</td>
      <td>벤치에 누워 어깨너비보다 약간 넓게 덤벨 잡기<br/>덤벨을 가슴 위로 천천히 내리기 (가슴에 닿을 정도)<br/>힘을 주며 원래 자리로 밀어올리기<br/>12-15회 × 3세트<br/>유튜브: https://www.youtube.com/watch?v=xTQL6jvVMNA</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>덤벨 인클라인 벤치 프레스</td>
      <td>상부 대흉근, 전면 삼각근</td>
      <td>가슴 윗부분 발달, 어깨와 가슴 경계선 개선</td>
      <td>인클라인 벤치(30-45도)에 누워서 덤벨 준비<br/>가슴 위쪽으로 덤벨을 천천히 내리기<br/>가슴을 펴며 덤벨을 위로 밀어올리기<br/>유튜브: https://www.youtube.com/watch?v=s9D_mxCWpeQ</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>머신 디클라인 벤치 프레스</td>
      <td>하부 대흉근, 삼두근</td>
      <td>가슴 아래쪽 발달, 가슴과 복근 경계선 개선</td>
      <td>디클라인 벤치에 누워 발을 고정<br/>바를 가슴 아래쪽으로 천천히 내리기<br/>힘을 주며 바를 위로 밀어올리기<br/>유튜브: https://www.youtube.com/watch?v=0DsXTSHo3lU</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>머신 체스트 프레스</td>
      <td>대흉근 전체</td>
      <td>안전한 가슴 운동, 초보자도 쉽게 접근 가능</td>
      <td>머신에 앉아 등받이에 등을 붙이기<br/>손잡이를 잡고 가슴을 펴며 앞으로 밀기<br/>천천히 원래 자리로 되돌리기<br/>유튜브: https://www.youtube.com/watch?v=ppPQgmgpafM</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>덤벨 플라이</td>
      <td>대흉근 (스트레칭 중심)</td>
      <td>가슴 근육 분리, 가슴 폭 확장</td>
      <td>벤치에 누워 덤벨을 가슴 위에서 시작<br/>팔을 약간 구부린 채 양옆으로 천천히 내리기<br/>가슴을 모으는 느낌으로 덤벨을 위로 모으기<br/>유튜브: https://www.youtube.com/watch?v=fkIAiiz4Aq8</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>벤치 케이블 플라이</td>
      <td>대흉근, 전면 삼각근</td>
      <td>일정한 텐션 유지, 가슴 근육 컷팅</td>
      <td>벤치에 누워 케이블 손잡이 잡기<br/>팔을 벌려 가슴을 스트레칭<br/>가슴을 모으며 손잡이를 위로 모으기<br/>유튜브: https://www.youtube.com/watch?v=Il7FXbxd1cY</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>다이아몬드 푸시업</td>
      <td>삼두근, 상부 대흉근</td>
      <td>팔 뒤쪽 강화, 가슴 윗부분 발달</td>
      <td>바닥에 엎드려 손을 다이아몬드 모양으로 만들기<br/>몸을 일직선으로 유지하며 내려가기<br/>팔에 힘을 주며 몸을 밀어올리기<br/>유튜브: https://www.youtube.com/watch?v=ZdDDuJX0-wk</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>인클라인 푸시업</td>
      <td>하부 대흉근, 삼두근</td>
      <td>초보자용 푸시업, 가슴 하부 발달</td>
      <td>벤치나 계단에 손을 올리고 푸시업 자세<br/>몸을 일직선으로 유지하며 내려가기<br/>가슴에 힘을 주며 몸을 밀어올리기<br/>유튜브: https://www.youtube.com/watch?v=IDhOU_mLi98</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>플레이트 디클라인 체스트 프레스</td>
      <td>하부 대흉근</td>
      <td>가슴 아래쪽 집중 발달</td>
      <td>디클라인 벤치에서 플레이트 들고 시작<br/>가슴 아래쪽으로 플레이트 내리기<br/>힘을 주며 플레이트를 위로 밀어올리기<br/>유튜브: https://www.youtube.com/watch?v=DUary1hEAfE</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>푸시업</td>
      <td>대흉근, 삼각근, 삼두근, 코어</td>
      <td>전신 근력 향상, 체중 관리, 코어 강화</td>
      <td>바닥에 엎드려 손을 어깨너비로 벌리기<br/>몸을 일직선으로 유지하며 내려가기<br/>가슴이 바닥에 닿을 때까지 내린 후 밀어올리기<br/>유튜브: https://www.youtube.com/watch?v=aoH7qNedO8k<br/>💪 2. 등 운동 (BACK)</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>머신 백 익스텐션</td>
      <td>척추기립근, 광배근</td>
      <td>허리 강화, 자세 교정, 등 라인 개선</td>
      <td>머신에 앉아 패드에 등을 대기<br/>등을 뒤로 젖히며 척추기립근 수축<br/>천천히 원래 자리로 되돌리기<br/>유튜브: https://www.youtube.com/watch?v=kmR8E1yv7PU</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>어시스티드 머신 친업</td>
      <td>광배근, 이두근, 후면 삼각근</td>
      <td>등 너비 확장, 역삼각형 몸매</td>
      <td>머신에 무릎을 올리고 손잡이 잡기<br/>등에 힘을 주며 몸을 위로 끌어올리기<br/>천천히 원래 자리로 내려가기<br/>유튜브: https://www.youtube.com/watch?v=nfORs3t0G44</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>밴드 친업</td>
      <td>광배근, 이두근</td>
      <td>친업 보조, 단계적 근력 향상</td>
      <td>밴드를 친업바에 걸고 무릎에 밴드 걸기<br/>밴드의 도움으로 몸을 위로 끌어올리기<br/>천천히 컨트롤하며 내려가기<br/>유튜브: https://www.youtube.com/watch?v=SIYet5taYIE</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>머신 랫 풀 다운</td>
      <td>광배근, 중간승모근, 이두근</td>
      <td>등 너비 발달, 어깨 안정성 향상</td>
      <td>머신에 앉아 바를 어깨너비보다 넓게 잡기<br/>등을 펴고 바를 가슴 쪽으로 당기기<br/>천천히 원래 자리로 되돌리기<br/>유튜브: https://www.youtube.com/watch?v=OyAAq3qoGss</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>덤벨 인클라인 로우</td>
      <td>중간승모근, 광배근, 후면 삼각근</td>
      <td>등 두께 증가, 자세 개선</td>
      <td>인클라인 벤치에 가슴을 대고 덤벨 잡기<br/>팔꿈치를 몸에 붙여 덤벨을 위로 당기기<br/>등 근육을 수축시키며 천천히 내리기<br/>유튜브: https://www.youtube.com/watch?v=GkSJUxYxDf4</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>레네게이드 로우</td>
      <td>광배근, 코어, 어깨 안정근</td>
      <td>전신 근력, 코어 안정성, 등 근력</td>
      <td>푸시업 자세에서 덤벨 2개 잡기<br/>한쪽 덤벨을 가슴 쪽으로 당기기<br/>코어를 안정시키며 좌우 교대로 실시<br/>유튜브: https://www.youtube.com/watch?v=v8JcGO-ICAQ</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>바벨 로우</td>
      <td>광배근, 승모근, 후면 삼각근</td>
      <td>등 전체 발달, 파워 향상</td>
      <td>바벨을 잡고 상체를 앞으로 숙이기<br/>바벨을 배꼽 쪽으로 당기기<br/>등 근육 수축을 느끼며 천천히 내리기<br/>유튜브: https://www.youtube.com/watch?v=EEqGCoTuYfQ</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>티바로우</td>
      <td>광배근, 승모근</td>
      <td>등 근력 향상, 데드리프트 보조</td>
      <td>T바를 다리 사이에 두고 잡기<br/>상체를 숙이고 바를 가슴 쪽으로 당기기<br/>등을 수축시키며 천천히 원래 자리로<br/>유튜브: https://www.youtube.com/watch?v=4KQ0YdppHPs</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>케이블 시티드 로우</td>
      <td>광배근, 승모근, 이두근</td>
      <td>등 두께 증가, 자세 교정</td>
      <td>케이블 머신에 앉아 손잡이 잡기<br/>가슴을 펴고 손잡이를 배꼽 쪽으로 당기기<br/>등 근육을 수축시키며 천천히 되돌리기<br/>유튜브: https://www.youtube.com/watch?v=MSxvJMWuR6s</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>인버티드 로우</td>
      <td>광배근, 승모근, 이두근</td>
      <td>체중 이용한 등 운동, 자세 교정</td>
      <td>바 아래 누워서 바를 잡기<br/>몸을 일직선으로 유지하며 가슴을 바에 당기기<br/>천천히 원래 자리로 내려가기<br/>유튜브: https://www.youtube.com/watch?v=51jHxHBZTBo<br/>🔥 3. 어깨 운동 (SHOULDERS)</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>클린 앤 저크</td>
      <td>전신 (어깨, 등, 다리)</td>
      <td>폭발적인 파워 향상, 전신 협응력</td>
      <td>바벨을 바닥에서 어깨까지 끌어올리기(클린)<br/>무릎을 굽혔다 펴며 바벨을 머리 위로 올리기(저크)<br/>안전하게 바벨을 내려놓기<br/>유튜브: https://www.youtube.com/watch?v=-PhJG-A7p4o</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>덤벨 리버스 플라이</td>
      <td>후면 삼각근, 승모근</td>
      <td>어깨 뒤쪽 강화, 라운드숄더 교정</td>
      <td>상체를 숙이고 덤벨을 양손에 잡기<br/>팔을 양옆으로 벌려 덤벨을 위로 올리기<br/>어깨뼈를 모으며 천천히 내리기<br/>유튜브: https://www.youtube.com/watch?v=n3aX0oJyvWA</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>덤벨 프론트 레이즈</td>
      <td>전면 삼각근</td>
      <td>어깨 앞쪽 발달, 어깨 라인 개선</td>
      <td>덤벨을 양손에 잡고 서기<br/>팔을 곧게 펴고 덤벨을 앞으로 올리기<br/>어깨 높이까지 올린 후 천천히 내리기<br/>유튜브: https://www.youtube.com/watch?v=m0ddyws4VL4</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>바벨 프론트 레이즈</td>
      <td>전면 삼각근</td>
      <td>어깨 전면 근력 향상</td>
      <td>바벨을 어깨너비로 잡고 서기<br/>팔을 곧게 펴고 바벨을 앞으로 올리기<br/>어깨 높이까지 올린 후 컨트롤하며 내리기<br/>유튜브: https://www.youtube.com/watch?v=nMUQR-dI_S8</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>케이블 페이스 풀</td>
      <td>후면 삼각근, 승모근</td>
      <td>어깨 안정성, 자세 교정</td>
      <td>케이블을 얼굴 높이로 설정하고 로프 잡기<br/>로프를 얼굴 쪽으로 당기며 팔꿈치 벌리기<br/>어깨뼈를 모으며 천천히 되돌리기<br/>유튜브: https://www.youtube.com/watch?v=BGpqQbnb3kM</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>케이블 레터럴 레이즈</td>
      <td>측면 삼각근</td>
      <td>어깨 너비 확장, V라인 체형</td>
      <td>케이블 손잡이를 한 손에 잡기<br/>팔을 옆으로 벌려 어깨 높이까지 올리기<br/>천천히 원래 자리로 내리기<br/>유튜브: https://www.youtube.com/watch?v=fr-5MKeRfVU</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>시티드 덤벨 숄더 프레스</td>
      <td>삼각근 전체, 삼두근</td>
      <td>어깨 전체 발달, 안정성 향상</td>
      <td>벤치에 앉아 덤벨을 어깨 높이에서 시작<br/>덤벨을 머리 위로 밀어올리기<br/>천천히 원래 자리로 내리기<br/>유튜브: https://www.youtube.com/watch?v=_geC1KPo2og</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>푸시 프레스</td>
      <td>어깨, 다리, 코어</td>
      <td>폭발적 파워, 전신 근력</td>
      <td>바벨을 어깨에 올리고 서기<br/>무릎을 살짝 굽혔다 펴며 바벨을 위로 밀기<br/>머리 위에서 바벨을 안정화시키기<br/>유튜브: https://www.youtube.com/watch?v=RSgtqPFuQNU</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>시티드 바벨 비하인드 넥 프레스</td>
      <td>삼각근, 삼두근</td>
      <td>어깨 전체 발달 (주의: 어깨 유연성 필요)</td>
      <td>벤치에 앉아 바벨을 목 뒤에서 잡기<br/>바벨을 머리 위로 밀어올리기<br/>천천히 목 뒤로 내리기 (과도한 가동범위 주의)<br/>유튜브: https://www.youtube.com/watch?v=EoGMVSORHtM</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>원 암 케틀벨 숄더 프레스</td>
      <td>삼각근, 코어 안정근</td>
      <td>한쪽씩 집중, 코어 안정성</td>
      <td>케틀벨을 한 손으로 어깨에 올리기<br/>코어를 안정시키며 케틀벨을 위로 밀기<br/>천천히 원래 자리로 내리기<br/>유튜브: https://www.youtube.com/watch?v=YETAgUPTC9I<br/>💪 4. 복근 운동 (ABS)</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>상복부 (Upper Abs)</td>
      <td>복직근 전체, 고관절굴곡근</td>
      <td>복부 전체 발달, 기능적 움직임 향상</td>
      <td>바닥에 누워 무릎을 구부리고 발을 고정<br/>손을 머리 뒤에 깍지 끼기<br/>복근 힘으로 상체를 완전히 일으켜 앉기<br/>천천히 누운 자세로 돌아가기<br/>유튜브: https://www.youtube.com/watch?v=1fbU_MkV7NE</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>하복부 (Lower Abs)</td>
      <td>하복부, 전신</td>
      <td>하복부 강화, 심폐지구력 향상, 칼로리 소모</td>
      <td>플랭크 자세에서 시작<br/>한쪽 무릎을 가슴 쪽으로 당기기<br/>빠르게 좌우 다리를 교대로 움직이기<br/>코어에 힘을 주고 엉덩이 높이 유지<br/>유튜브: https://www.youtube.com/watch?v=nmwgirgXLYM</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>측복부 (Obliques)</td>
      <td>복사근, 회전근</td>
      <td>측복부 강화, 척추 안정성</td>
      <td>옆으로 누워 전완으로 몸을 지지<br/>몸을 일직선으로 만들어 올리기<br/>엉덩이가 처지지 않게 유지<br/>30초-1분간 자세 유지 후 반대편<br/>유튜브: https://www.youtube.com/watch?v=K2VljzCC16g</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>코어 전체 (Full Core)</td>
      <td>코어, 허리, 둔근</td>
      <td>전신 안정성, 균형감각 향상</td>
      <td>네발기기 자세에서 시작<br/>반대편 팔과 다리를 동시에 뻗기<br/>몸의 중심선을 유지하며 균형 잡기<br/>5초간 유지 후 반대편으로 교체<br/>유튜브: https://www.youtube.com/watch?v=wiFNA3sqjCA<br/>5. 둔근 (엉덩이)</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>힙 쓰러스트</td>
      <td>둔근</td>
      <td>둔근 최대 활성화, 골반 안정성 향상, 허리 통증 완화, 힙 파워 증가</td>
      <td>등을 벤치에 기대고 무릎을 90도로 구부리기<br/>둔근에 힘을 주며 골반을 위로 들어올리기<br/>최고점에서 둔근을 강하게 수축<br/>천천히 시작 자세로 돌아가기<br/>유튜브: https://www.youtube.com/watch?v=SEdqd1n0cvg</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>불가리안 스쿼트</td>
      <td>둔근, 대퇴사두근</td>
      <td>한쪽 다리 집중 강화, 균형감각 발달, 둔근 활성화, 좌우 불균형 해소</td>
      <td>뒷발을 벤치나 의자 위에 올리기<br/>앞다리 중심으로 스쿼트 동작 실시<br/>앞무릎이 발끝을 넘지 않게 주의<br/>둔근에 집중하며 천천히 올라오기<br/>유튜브: https://www.youtube.com/watch?v=2C-uNgKwPLE</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>사이드 런지</td>
      <td></td>
      <td>측면 움직임 강화, 둔근 측면 발달, 고관절 가동성 향상</td>
      <td>발을 넓게 벌리고 서기<br/>한쪽 다리로 옆으로 크게 런지<br/>반대쪽 다리는 곧게 펴서 유지<br/>측면 둔근과 내전근을 느끼며 원위치<br/>유튜브: https://www.youtube.com/watch?v=8paRb4jAR2o</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>클램쉘</td>
      <td>중둔근</td>
      <td>중둔근 활성화, 골반 안정성, 무릎 부상 예방, 고관절 외회전 강화</td>
      <td>옆으로 누워 무릎을 90도로 구부리기<br/>발은 붙인 채 무릎만 벌리기<br/>중둔근을 느끼며 최대한 벌리기<br/>천천히 시작 자세로 돌아가기<br/>유튜브: https://www.youtube.com/watch?v=EY240aIQc7E<br/>🦵6. 허벅지 운동 (THIGHS)</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>대퇴사두근 (허벅지 앞쪽)</td>
      <td>대퇴사두근, 파워</td>
      <td>폭발적 파워, 심폐지구력</td>
      <td>일반 스쿼트 자세에서 시작<br/>스쿼트 후 폭발적으로 점프<br/>착지와 동시에 다음 스쿼트 실시<br/>유튜브: https://www.youtube.com/watch?v=A-Hemn_A7GU</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>햄스트링 (허벅지 뒤쪽)</td>
      <td>햄스트링, 둔근</td>
      <td>강력한 햄스트링 발달</td>
      <td>GHD 머신에 무릎을 고정하고 앞으로 기울이기<br/>햄스트링 힘으로 몸을 일으켜 세우기<br/>천천히 원래 자리로 내려가기<br/>유튜브: https://www.youtube.com/watch?v=ZQZcgf8Do5k<br/>7. 종아리근 (제2의 심장)</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>카프 레이즈</td>
      <td>종아리</td>
      <td>종아리 전체 발달, 하지 혈액순환 개선, 점프력 향상, 발목 안정성</td>
      <td>발끝으로 서서 발뒤꿈치를 최대한 들어올리기<br/>종아리 근육을 강하게 수축<br/>최고점에서 1초 정지<br/>천천히 발뒤꿈치를 내리기<br/>유튜브: https://www.youtube.com/watch?v=gwWv7rrFNKk</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>시티드 카프 레이즈</td>
      <td>가자미근</td>
      <td>가자미근 집중 발달, 지구력 향상, 종아리 하부 강화</td>
      <td>의자에 앉아 무릎 위에 중량 올리기<br/>발끝으로 발뒤꿈치를 들어올리기<br/>가자미근 수축을 느끼며 정점에서 멈추기<br/>천천히 시작 자세로 돌아가기<br/>유튜브: https://www.youtube.com/watch?v=JbyjNymZOt0</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>점핑 카프 레이즈</td>
      <td>종아리 전체</td>
      <td>종아리 폭발적 파워, 점프력 증가, 심폐지구력 향상, 칼로리 소모</td>
      <td>발끝으로 서서 폭발적으로 점프<br/>착지 시 발끝으로만 착지<br/>연속적으로 빠르게 점프 반복<br/>종아리 근육의 탄성을 최대한 활용<br/>유튜브: https://www.youtube.com/watch?v=3RamUe64C-g</td>
    </tr>
    <tr>
      <td>가슴 운동 (CHEST)</td>
      <td>월 푸시 카프 레이즈</td>
      <td>종아리</td>
      <td>종아리 스트레칭과 강화 동시, 아킬레스건 유연성, 발목 가동성 향상</td>
      <td>벽에 손을 대고 몸을 기울이기<br/>뒷발을 뒤로 빼고 발뒤꿈치를 바닥에 붙이기<br/>종아리 스트레칭을 느끼며 카프 레이즈 실시<br/>스트레칭과 수축을 번갈아가며 실시<br/>유튜브: https://www.youtube.com/watch?v=nFLFHR6bNSE</td>
    </tr>
  </tbody>
</table>
</div>
			

</body>
</html>