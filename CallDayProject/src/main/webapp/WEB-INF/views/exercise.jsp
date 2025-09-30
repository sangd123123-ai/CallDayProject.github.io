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
<title>운동 가이드 Side Panel</title>

  <!-- Bootstrap CSS -->
  
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/exguide.css">
  <link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/navbar.css">
  <link rel="stylesheet" href="<%=cp%>/resources/css/eg-zindex-fix.css">
	
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  
</head>
<body>



<%@ include file="/WEB-INF/views/main_part/header.jsp" %>
<main class="cd-scope theme-solid">

<div style="height: 60px;"></div>
<div id="app" class="layout">
  <aside id="drawer" class="drawer" aria-hidden="true">
    <div class="drawer-head">
     
      <h2 id="drawerTitle">운동 정보</h2>
       <button id="btnClose" class="close-btn" type="button" aria-label="닫기">닫기</button>
    </div>
    <div class="drawer-body">
      <div id="drawerContent">
        <p class="meta"></p>
        <div id="exList" class="ex-list"></div>
      </div>
    </div>
  </aside>

  <main class="stage" style="align-self: center;">
    <button id="btnOpen" class="open-btn" type="button" aria-label="패널 열기">메뉴</button>
    <!-- 기존 본문 시작 -->
    <div class="img-wrapper">
    <img class="gi-rmap" src="${pageContext.request.contextPath}/resources/img/ex000.png" alt="신체 이미지">
    
    <!-- Hotspot 영역들 -->
    
    <!-- 어깨 (앞면) -->
    <div class="hotspot" style="position: absolute; top: 190px; left: 332px; width: 77px; height: 86px; cursor: pointer; border: 2px solid rgba(255,0,0,0.3); background: rgba(255,0,0,0.1);" 
         onclick="openPanel('어깨', shoulderExercises)" title="어깨">
        <span style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 12px; font-weight: bold; color: #fff; text-shadow: 1px 1px 2px rgba(0,0,0,0.7);">어깨</span>
    </div>
    
    <!-- 가슴 -->
    <div class="hotspot" style="position: absolute; top: 235px; left: 172px; width: 154px; height: 77px; cursor: pointer; border: 2px solid rgba(0,255,0,0.3); background: rgba(0,255,0,0.1);" 
         onclick="openPanel('가슴', chestExercises)" title="가슴">
        <span style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 12px; font-weight: bold; color: #fff; text-shadow: 1px 1px 2px rgba(0,0,0,0.7);">가슴</span>
    </div>
    
    <!-- 복부 -->
    <div class="hotspot" style="position: absolute; top: 320px; left: 199px; width: 101px; height: 125px; cursor: pointer; border: 2px solid rgba(0,0,255,0.3); background: rgba(0,0,255,0.1);" 
         onclick="openPanel('복부', absExercises)" title="복부">
        <span style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 12px; font-weight: bold; color: #fff; text-shadow: 1px 1px 2px rgba(0,0,0,0.7);">복부</span>
    </div>
    
    <!-- 팔 (수정됨) -->
    <div class="hotspot" style="position: absolute; top: 298px; left: 866px; width: 110px; height: 173px; cursor: pointer; border: 2px solid rgba(255,255,0,0.3); background: rgba(255,255,0,0.1);" 
         onclick="openPanel('팔', armExercises)" title="팔">
        <span style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 12px; font-weight: bold; color: #333; text-shadow: 1px 1px 2px rgba(255,255,255,0.7);">팔</span>
    </div>
    
    <!-- 등 (뒷면) -->
    <div class="hotspot" style="position: absolute; top: 224px; left: 699px; width: 172px; height: 116px; cursor: pointer; border: 2px solid rgba(255,0,255,0.3); background: rgba(255,0,255,0.1);" 
         onclick="openPanel('등', backExercises)" title="등">
        <span style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 12px; font-weight: bold; color: #fff; text-shadow: 1px 1px 2px rgba(0,0,0,0.7);">등</span>
    </div>
    
    <!-- 엉덩이 -->
    <div class="hotspot" style="position: absolute; top: 433px; left: 677px; width: 202px; height: 122px; cursor: pointer; border: 2px solid rgba(0,255,255,0.3); background: rgba(0,255,255,0.1);" 
         onclick="openPanel('엉덩이', hipExercises)" title="엉덩이">
        <span style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 12px; font-weight: bold; color: #333; text-shadow: 1px 1px 2px rgba(255,255,255,0.7);">엉덩이</span>
    </div>
    
    <!-- 허벅지 (수정됨) -->
    <div class="hotspot" style="position: absolute; top: 525px; left: 135px; width: 229px; height: 141px; cursor: pointer; border: 2px solid rgba(255,128,0,0.3); background: rgba(255,128,0,0.1);" 
         onclick="openPanel('허벅지', thighExercises)" title="허벅지">
        <span style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 12px; font-weight: bold; color: #fff; text-shadow: 1px 1px 2px rgba(0,0,0,0.7);">허벅지</span>
    </div>
    
    <!-- 종아리 -->
    <div class="hotspot" style="position: absolute; top: 682px; left: 596px; width: 311px; height: 186px; cursor: pointer; border: 2px solid rgba(128,0,255,0.3); background: rgba(128,0,255,0.1);" 
         onclick="openPanel('종아리', calfExercises)" title="종아리">
        <span style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 12px; font-weight: bold; color: #fff; text-shadow: 1px 1px 2px rgba(0,0,0,0.7);">종아리</span>
    </div>
</div>

</main>

<%@ include file="/WEB-INF/views/main_part/footer.jsp" %>


  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<script>
// ========== 부위별 YouTube 영상 ID 매핑 ==========
const exerciseVideos = {
    '어깨': 'EUrqHPFm3HQ',      // 어깨 운동 영상
    '가슴': 'your_chest_video_id',      // 가슴 운동 영상 ID로 변경하세요
    '복부': 'your_abs_video_id',       // 복부 운동 영상 ID로 변경하세요
    '팔': 'your_arm_video_id',         // 팔 운동 영상 ID로 변경하세요
    '등': 'your_back_video_id',        // 등 운동 영상 ID로 변경하세요
    '엉덩이': 'your_hip_video_id',     // 엉덩이 운동 영상 ID로 변경하세요
    '허벅지': 'your_thigh_video_id',   // 허벅지 운동 영상 ID로 변경하세요
    '종아리': 'your_calf_video_id'     // 종아리 운동 영상 ID로 변경하세요
};

function ytEmbedUrl(id, start=0, end=""){
    const p = new URLSearchParams({
        autoplay: "1",
        mute: "1",
        controls: "0",
        loop: "1",
        playlist: id,
        start, end,
        rel: "0",
        modestbranding: "1",
        playsinline: "1"
    });
    return `https://www.youtube-nocookie.com/embed/${id}?` + p.toString();
}

// 유튜브 썸네일 URL 생성 함수 추가
function getYoutubeThumbnail(videoId) {
    // 고화질 썸네일 우선, 없으면 기본 썸네일 사용
	return 'https://i.ytimg.com/vi/' + videoId + '/hqdefault.jpg';
}

// YouTube ID 추출 함수 개선
function extractYTId(url) {
    if (!url) return '';
    
    // 이미 ID인 경우
    if (/^[\w-]{8,}$/.test(url)) return url;
    
    try {
        const urlObj = new URL(url, location.href);
        
        // youtu.be 형태
        if (urlObj.hostname.includes('youtu.be')) {
            return urlObj.pathname.slice(1);
        }
        
        // youtube.com?v= 형태
        if (urlObj.searchParams.get('v')) {
            return urlObj.searchParams.get('v');
        }
        
        // embed 형태
        const embedMatch = urlObj.pathname.match(/\/embed\/([-\w]+)/);
        if (embedMatch) return embedMatch[1];
        
        return '';
    } catch (e) {
        return '';
    }
}

// YouTube 프리뷰 이벤트 설정 - 완전히 새로운 함수로 교체
function setupYouTubePreview() {
    document.querySelectorAll('.yt-preview').forEach((preview) => {
        const videoId = extractYTId(preview.dataset.vid);
        if (!videoId) return;
        
        let iframe;
        let isPlaying = false;
        
        const thumb = preview.querySelector('.yt-thumb');
        const playButton = preview.querySelector('.yt-play-button');
        
        const createIframe = () => {
            const iframe = document.createElement('iframe');
            iframe.src = ytEmbedUrl(videoId);
            iframe.title = "YouTube preview";
            iframe.allow = "autoplay; encrypted-media; picture-in-picture";
            iframe.style.display = 'none'; // 처음엔 숨김
            return iframe;
        };

        const showVideo = () => {
            if (!iframe) {
                iframe = createIframe();
                preview.appendChild(iframe);
            }
            
            if (thumb) thumb.style.display = 'none';
            if (playButton) playButton.style.display = 'none';
            iframe.style.display = 'block';
            isPlaying = true;
        };

        const hideVideo = () => {
            if (iframe && iframe.parentNode) {
                iframe.style.display = 'none';
            }
            if (thumb) thumb.style.display = 'block';
            if (playButton) playButton.style.display = 'flex';
            isPlaying = false;
        };

        // 데스크톱: 마우스 호버
        if (window.matchMedia('(hover: hover)').matches) {
            preview.addEventListener('mouseenter', showVideo);
            preview.addEventListener('mouseleave', hideVideo);
        }

        // 클릭 이벤트 (모바일 포함)
        preview.addEventListener('click', (e) => {
            e.preventDefault();
            if (isPlaying) {
                hideVideo();
            } else {
                showVideo();
            }
        });
    });
}

// 컨트롤러에서 넘어온 데이터를 자바스크립트 변수로 변환
console.log("JSP 데이터 변환 시작");

const shoulderExercises = [
<c:forEach var="ex" items="${Shoulder}" varStatus="status">
    {
        exName: "${ex.exName}",
        targetMuscle: "${ex.targetMuscle}",
        effect: "${ex.effect}",
        method: "${ex.method}",
        youtubeUrl: "${ex.youtubeUrl}"
    }<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

const chestExercises = [
<c:forEach var="ex" items="${Chest}" varStatus="status">
    {
        exName: "${ex.exName}",
        targetMuscle: "${ex.targetMuscle}",
        effect: "${ex.effect}",
        method: "${ex.method}",
        youtubeUrl: "${ex.youtubeUrl}"
    }<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

const armExercises = [
<c:forEach var="ex" items="${Arm}" varStatus="status">
    {
        exName: "${ex.exName}",
        targetMuscle: "${ex.targetMuscle}",
        effect: "${ex.effect}",
        method: "${ex.method}",
        youtubeUrl: "${ex.youtubeUrl}"
    }<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

const absExercises = [
<c:forEach var="ex" items="${Abs}" varStatus="status">
    {
        exName: "${ex.exName}",
        targetMuscle: "${ex.targetMuscle}",
        effect: "${ex.effect}",
        method: "${ex.method}",
        youtubeUrl: "${ex.youtubeUrl}"
    }<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

const backExercises = [
<c:forEach var="ex" items="${Back}" varStatus="status">
    {
        exName: "${ex.exName}",
        targetMuscle: "${ex.targetMuscle}",
        effect: "${ex.effect}",
        method: "${ex.method}",
        youtubeUrl: "${ex.youtubeUrl}"
    }<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

const hipExercises = [
<c:forEach var="ex" items="${Hip}" varStatus="status">
    {
        exName: "${ex.exName}",
        targetMuscle: "${ex.targetMuscle}",
        effect: "${ex.effect}",
        method: "${ex.method}",
        youtubeUrl: "${ex.youtubeUrl}"
    }<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

const thighExercises = [
<c:forEach var="ex" items="${Thigh}" varStatus="status">
    {
        exName: "${ex.exName}",
        targetMuscle: "${ex.targetMuscle}",
        effect: "${ex.effect}",
        method: "${ex.method}",
        youtubeUrl: "${ex.youtubeUrl}"
    }<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

const calfExercises = [
<c:forEach var="ex" items="${Calf}" varStatus="status">
    {
        exName: "${ex.exName}",
        targetMuscle: "${ex.targetMuscle}",
        effect: "${ex.effect}",
        method: "${ex.method}",
        youtubeUrl: "${ex.youtubeUrl}"
    }<c:if test="${!status.last}">,</c:if>
</c:forEach>
];

</script>
    <!-- 기존 본문 끝 -->
  </main>
</div>


<script>
(function(){
  const app = document.getElementById('app');
  if(!app) return;
  const drawer = document.getElementById('drawer');
  const btnOpen = document.getElementById('btnOpen');
  const btnClose = document.getElementById('btnClose');
  const drawerTitle = document.getElementById('drawerTitle');
  const exList = document.getElementById('exList');

  
  const drawerBody = document.querySelector('#drawer .drawer-body');function openDrawer(){ app.classList.add('open'); drawer.setAttribute('aria-hidden','false'); onResize(); }
  function closeDrawer(){ app.classList.remove('open'); drawer.setAttribute('aria-hidden','true'); onResize(); }

  

  // Reset scroll to top of drawer when view changes
  function resetDrawerToTop(){
    try { drawerBody && drawerBody.scrollTo({ top: 0, left: 0, behavior: 'instant' }); }
    catch(e){ if(drawerBody) drawerBody.scrollTop = 0; }
  }
if(btnOpen) btnOpen.addEventListener('click', openDrawer);
  if(btnClose) btnClose.addEventListener('click', closeDrawer);
  document.addEventListener('keydown', function(e){ if(e.key === 'Escape') closeDrawer(); });

  // Reflow coords when layout transitions end
  drawer.addEventListener('transitionend', function(e){ if(e.propertyName === 'transform') onResize(); });
  var stage = document.querySelector('.stage');
  if(stage) stage.addEventListener('transitionend', function(e){ if(e.propertyName === 'margin-left') onResize(); });

  // ===== Responsive scaling for absolute-positioned .hotspot =====
  var img = document.querySelector('.img-wrapper img, .img-wrap img, img.gi-rmap');
  var hotspots = Array.prototype.slice.call(document.querySelectorAll('.img-wrapper .hotspot, .img-wrap .hotspot'));

  function storeOriginals(){
    var container = document.querySelector('.img-wrapper, .img-wrap');
    if(container && getComputedStyle(container).position === 'static'){
      container.style.position = 'relative';
    }
    hotspots.forEach(function(h){
      var st = h.getAttribute('style') || '';
      if(!h.dataset.orig){
        var mTop = /top:\s*([0-9.]+)px/.exec(st);
        var mLeft = /left:\s*([0-9.]+)px/.exec(st);
        var mW = /width:\s*([0-9.]+)px/.exec(st);
        var mH = /height:\s*([0-9.]+)px/.exec(st);
        if(mTop && mLeft && mW && mH){
          h.dataset.orig = JSON.stringify({top:parseFloat(mTop[1]), left:parseFloat(mLeft[1]), w:parseFloat(mW[1]), h:parseFloat(mH[1])});
        }
      }
    });
  }

  function scaleHotspots(){
    if(!img) return;
    var natW = img.naturalWidth || img.width;
    var natH = img.naturalHeight || img.height;
    if(!natW || !natH) return;

    var rect = img.getBoundingClientRect();
    var sx = rect.width / natW;
    var sy = rect.height / natH;

    hotspots.forEach(function(h){
      if(!h.dataset.orig) return;
      var o = JSON.parse(h.dataset.orig);
      var top = Math.round(o.top * sy);
      var left = Math.round(o.left * sx);
      var w = Math.round(o.w * sx);
      var ht = Math.round(o.h * sy);
      h.style.top = top + "px";
      h.style.left = left + "px";
      h.style.width = w + "px";
      h.style.height = ht + "px";
    });
  }

  function onResize(){ scaleHotspots(); }
  window.addEventListener('resize', onResize);
  if(img){
    img.addEventListener('load', function(){ storeOriginals(); onResize(); });
    if(img.complete){ storeOriginals(); onResize(); }
  }

  // ===== Drawer population (DTO list) - 수정된 부분 =====
  if(!window.openPanel){
    window.openPanel = function(title, list){
      try{
        drawerTitle.textContent = title || "운동 정보";
        exList.innerHTML = '';
        if(Array.isArray(list) && list.length){
          list.forEach(function(item){
            var card = document.createElement('div');
            card.className = 'ex-card';

            var h3 = document.createElement('h3');
            h3.textContent = (item.exName || '—');
            card.appendChild(h3);

            var meta = document.createElement('div');
            meta.className = 'meta';
            meta.textContent = '타겟: ' + (item.targetMuscle || '—');
            card.appendChild(meta);

            var eff = document.createElement('div');
            eff.textContent = '효과: ' + (item.effect || '—');
            card.appendChild(eff);

            var method = document.createElement('div');
            method.style.marginTop = '6px';
            method.style.whiteSpace = 'pre-line';
            method.textContent = '방법: ' + (item.method || '—');
            card.appendChild(method);

            // 유튜브 프리뷰 부분 수정
            if(item.youtubeUrl){
              var videoId = extractYTId(item.youtubeUrl);
              if(videoId) {
                // 프리뷰 컨테이너 생성
                var preview = document.createElement('div');
                preview.className = 'yt-preview';
                preview.style.marginTop = '8px';
                preview.dataset.vid = videoId;
                
                // 썸네일 이미지 생성
                var thumb = document.createElement('img');
                thumb.className = 'yt-thumb';
                thumb.src = getYoutubeThumbnail(videoId);
                thumb.alt = '유튜브 썸네일';
                thumb.loading = 'lazy';
                
                // 재생 버튼 생성
                var playBtn = document.createElement('div');
                playBtn.className = 'yt-play-button';
                
                preview.appendChild(thumb);
                preview.appendChild(playBtn);
                card.appendChild(preview);
              } else {
                // 기존 방식 유지 (videoId를 추출할 수 없는 경우)
                var wrap = document.createElement('div');
                wrap.className = 'yt-embed';
                wrap.style.marginTop = '8px';
                var iframe = document.createElement('iframe');
                iframe.setAttribute('allow', 'accelerometer;autoplay;clipboard-write;encrypted-media;gyroscope;picture-in-picture;web-share');
                iframe.setAttribute('allowfullscreen', '');
                iframe.src = ytEmbedUrl(item.youtubeUrl);
                wrap.appendChild(iframe);
                card.appendChild(wrap);
              }
            }

            exList.appendChild(card);
          });
          
          // 프리뷰 설정 함수 호출
          setTimeout(setupYouTubePreview, 100);
          
        }else{
          exList.innerHTML = '<div class="meta">표시할 데이터가 없어요.</div>';
        }
        requestAnimationFrame(resetDrawerToTop);
        openDrawer();
      }catch(err){
        console.error(err);
      }
    };
  }

  // Fallback ytEmbedUrl if missing
  if(typeof window.ytEmbedUrl !== 'function'){
    window.ytEmbedUrl = function(url){
      try{
        var id = extractYTId(url);
        var params = 'rel=0&modestbranding=1&playsinline=1';
        return 'https://www.youtube-nocookie.com/embed/' + id + '?' + params;
      }catch(e){ return ''; }
    };
  }

})();
</script>


</body>
</html>