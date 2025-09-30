<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>CallDay - 메인 페이지</title>
  
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <!-- Custom CSS Files -->
  <link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/navbar.css">
  <link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/main2.css">
  
  <!-- Slick CSS -->
  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
  

</head>
<body>

  <!-- 헤더 -->
  <%@ include file="/WEB-INF/views/main_part/header.jsp" %>

<div style="height: 60px;"></div>
  <!-- Hero + Slider -->
  <section id="hero1" class="hero-section">
    <div class="hero-inner">
      <div class="slider-container slide-in-left">
        <div class="slide">

          <c:if test="${lists != null}">
            <c:forEach var="slider" items="${lists}">
              <div class="item"
                style="background-image: url('${pageContext.request.contextPath}/resources/main/slider/${slider.saveFileName}');">
                <div class="slider-content">
                  <div class="name">${slider.title}</div>
                  <div class="des">${slider.content}</div>
                  <a href="${slider.linkUrl}">
                    <button>자세히 보기</button>
                  </a>
                </div>
              </div>
            </c:forEach>
          </c:if>
          
          <c:if test="${lists == null}">
            <div class="item" style="background-image: url('${pageContext.request.contextPath}/resources/img/default-slide.jpg');">
              <div class="slider-content">
                <div class="name">CallDay에 오신 것을 환영합니다</div>
                <div class="des">건강한 라이프스타일을 시작해보세요</div>
                <button onclick="scrollToPopular()">시작하기</button>
              </div>
            </div>
          </c:if>

        </div>
        <div class="slider-button">
          <button class="prev" aria-label="이전 슬라이드"></button>
          <button class="next" aria-label="다음 슬라이드"></button>
        </div>
      </div>
    </div>
  </section>

  <!-- 인기 게시물 섹션 -->
  <section class="hero-section" style="background: var(--bg-light);">
    <div class="hero-inner" style="background: transparent; min-height: auto; padding: 80px 0;">
      <div class="container">
        
        <h3 class="section-title fade-in">🔥 인기 게시물 TOP 3 🔥</h3>

        <div class="row justify-content-center">
          <c:forEach var="post" items="${top3Likes}" varStatus="status">
            <div class="col-lg-4 col-md-6 mb-4">
              <div class="card custom-card shadow-sm h-100 fade-in" style="animation-delay: ${status.index * 0.2}s;">

                <!-- 게시글 이미지 -->
                <div class="position-relative">
                  <c:choose>
                    <c:when test="${not empty post.saveFileName}">
                      <img src="${pageContext.request.contextPath}/pds/upload/${post.saveFileName}"
                           class="card-img-top"
                           alt="게시물 이미지">
                    </c:when>
                    <c:otherwise>
                      <img src="${pageContext.request.contextPath}/resources/images/no-image.png"
                           class="card-img-top"
                           alt="기본 이미지">
                    </c:otherwise>
                  </c:choose>
                  
                  <!-- 랭킹 배지 -->
                  <div class="rank-badge ${status.index == 0 ? 'first' : status.index == 1 ? 'second' : 'third'}">
                    ${status.index + 1}위
                  </div>
                </div>

                <div class="card-body text-center">
                  <h6 class="card-subtitle mb-3 text-truncate">
                    <a href="${pageContext.request.contextPath}/imgArticle.action?num=${post.num}&pageNum=1"
                       class="post-link">
                      ${post.subject}
                    </a>
                  </h6>
                  <p class="like-text">
                    <i class="fas fa-heart"></i>
                    좋아요 <span class="fw-bold">${post.likeCount}</span>개
                  </p>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>

      </div>
    </div>
  </section>

 <!-- 스토어 섹션 -->
<section id="hero2" class="hero-section">
  <div class="hero-inner">
    <div class="container-fluid px-0 my-0" id="store">
      <h2 class="section-title slide-in-left" style="color: white;">🛍️ 스토어</h2>
      
      <div class="loading" id="storeLoading">
        <div class="spinner"></div>
        <p style="color: white; margin-top: 1rem;">상품을 불러오는 중...</p>
      </div>
      
      <div class="store-slider fade-in">
        <c:if test="${not empty products}">
          <c:forEach var="product" items="${products}">
            <div>
              <div class="store-card">
                <!-- 인라인 스타일 제거하고 CSS에 맡김 -->
                <img src="${pageContext.request.contextPath}/resources/main/store/${product.saveFileName}" 
                     alt="${product.title}">
                <div class="card-body">
                  <h5 class="card-title">${product.title}</h5>
                  <p class="card-text">${product.content}</p>
                  <p class="price-text">
                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₩" />
                  </p>
                  <a href="${product.linkUrl}" target="_blank" class="btn-purchase">
                    <i class="fas fa-shopping-cart me-2"></i>구매하기
                  </a>
                </div>
              </div>
            </div>
          </c:forEach>
        </c:if>
      </div>
      
    </div>
  </div>
</section>

  <!-- CTA 섹션 -->
  <section class="hero-section" style="background: var(--bg-light);">
    <div class="hero-inner" style="background: transparent; min-height: 400px; padding: 60px 0;">
      <div class="container text-center">
        <div class="fade-in">
          <h2 class="section-title">지금 CallDay와 함께하세요!</h2>
          <p class="lead text-muted mb-4">건강한 라이프스타일의 시작, CallDay가 함께합니다.</p>
          <div class="d-flex gap-3 justify-content-center flex-wrap">
            <a href="<c:url value='/signup'/>" class="btn btn-primary btn-lg px-5">
              <i class="fas fa-user-plus me-2"></i>회원가입
            </a>
            <a href="<c:url value='/ai/diet'/>" class="btn btn-outline-primary btn-lg px-5">
              <i class="fas fa-utensils me-2"></i>AI 식단 추천 받기
            </a>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/main_part/footer.jsp" %>

  <!-- JS -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

  <script type="text/javascript">
    "use strict";

 // 슬라이더 기능 개선 - 연속 실행 방지
    let next = document.querySelector(".next");
    let prev = document.querySelector(".prev");
    let autoSlideInterval;
    let isSliding = false; // 슬라이드 진행 상태 체크

    function nextSlide() {
      // 이미 슬라이딩 중이면 실행하지 않음
      if (isSliding) return;
      
      let items = document.querySelectorAll(".item");
      if (items.length > 1) {
        isSliding = true; // 슬라이드 시작
        document.querySelector(".slide").appendChild(items[0]);
        
        // 애니메이션이 끝난 후 플래그 해제
        setTimeout(() => {
          isSliding = false;
        }, 800); // CSS 전환 시간과 맞춤
      }
    }

    function prevSlide() {
      // 이미 슬라이딩 중이면 실행하지 않음
      if (isSliding) return;
      
      let items = document.querySelectorAll(".item");
      if (items.length > 1) {
        isSliding = true; // 슬라이드 시작
        document.querySelector(".slide").prepend(items[items.length - 1]);
        
        // 애니메이션이 끝난 후 플래그 해제
        setTimeout(() => {
          isSliding = false;
        }, 800); // CSS 전환 시간과 맞춤
      }
    }

    // 자동 슬라이드 기능 - 안전한 실행
    function startAutoSlide() {
      // 기존 인터벌이 있으면 먼저 제거
      if (autoSlideInterval) {
        clearInterval(autoSlideInterval);
      }
      
      autoSlideInterval = setInterval(() => {
        // 슬라이딩 중이 아닐 때만 자동 실행
        if (!isSliding) {
          nextSlide();
        }
      }, 8000); // 8초마다 실행
    }

    function stopAutoSlide() {
      if (autoSlideInterval) {
        clearInterval(autoSlideInterval);
        autoSlideInterval = null; // 명확하게 null로 설정
      }
    }

    // 이벤트 리스너 - 중복 실행 방지
    if (next) {
      next.addEventListener("click", function() {
        if (!isSliding) { // 슬라이딩 중이 아닐 때만 실행
          nextSlide();
          stopAutoSlide();
          // 사용자 조작 후 충분한 시간 후 재시작
          setTimeout(startAutoSlide, 15000);
        }
      });
    }

    if (prev) {
      prev.addEventListener("click", function() {
        if (!isSliding) { // 슬라이딩 중이 아닐 때만 실행
          prevSlide();
          stopAutoSlide();
          // 사용자 조작 후 충분한 시간 후 재시작
          setTimeout(startAutoSlide, 15000);
        }
      });
    }

    // 마우스 호버 시 자동 슬라이드 정지 - 안전한 처리
    const sliderContainer = document.querySelector('.slider-container');
    if (sliderContainer) {
      sliderContainer.addEventListener('mouseenter', () => {
        stopAutoSlide();
      });
      
      sliderContainer.addEventListener('mouseleave', () => {
        // 슬라이딩 중이 아닐 때만 재시작
        if (!isSliding) {
          startAutoSlide();
        } else {
          // 슬라이딩이 끝나면 재시작
          setTimeout(startAutoSlide, 1000);
        }
      });
    }

    // 스토어 슬라이더 설정 개선 - 속도 조정
    $(document).ready(function() {
    	$('.store-slider').slick({
    		  rows: 2,
    		  slidesPerRow: 3,  // 4 → 3으로 변경
    		  slidesToScroll: 1,
    		  arrows: true,
    		  dots: true,
    		  infinite: true,
    		  autoplay: true,
    		  autoplaySpeed: 7000,
    		  speed: 800,
    		  pauseOnHover: true,
    		  pauseOnFocus: true,
    		  cssEase: 'ease-in-out',
    		  responsive: [
    		    {
    		      breakpoint: 1200,
    		      settings: {
    		        slidesPerRow: 3,  // 3 → 2로 변경
    		        speed: 800
    		      }
    		    },
    		    {
    		      breakpoint: 768,
    		      settings: {
    		        slidesPerRow: 2,  // 2 → 1로 변경
    		        rows: 3,
    		        speed: 800
    		      }
    		    },
    		    {
    		      breakpoint: 576,
    		      settings: {
    		        slidesPerRow: 1,
    		        rows: 4,
    		        speed: 800
    		      }
    		    }
    		  ]
    		});

      // 스토어 로딩 처리 - 로딩 시간도 조금 늘림
      $('#storeLoading').show();
      setTimeout(function() {
        $('#storeLoading').fadeOut(500); // fadeOut 효과 추가
        $('.store-slider').fadeIn(800);  // fadeIn 시간 늘림
      }, 1200); // 1초 → 1.2초로 변경
    });

    // 자동 슬라이드 시작 - 페이지 로드 후 안전하게 실행
    document.addEventListener('DOMContentLoaded', function() {
      // DOM이 완전히 로드된 후 시작
      setTimeout(startAutoSlide, 1000);
    });

    // 페이지 언로드 시 인터벌 정리
    window.addEventListener('beforeunload', function() {
      stopAutoSlide();
    });
    // 다크 모드 개선 (메모리 기반)
    let darkMode = false;
    const body = document.body;
    const darkToggle = document.getElementById("darkToggle");

    function toggleDarkMode() {
      darkMode = !darkMode;
      body.classList.toggle("dark", darkMode);
      
      if (darkToggle) {
        darkToggle.innerHTML = darkMode ? '<i class="fas fa-sun"></i>' : '<i class="fas fa-moon"></i>';
      }
    }

    if (darkToggle) {
      darkToggle.addEventListener("click", toggleDarkMode);
    }

    // 스크롤 애니메이션
    const observerOptions = {
      threshold: 0.1,
      rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.style.animationPlayState = 'running';
        }
      });
    }, observerOptions);

    // 애니메이션 요소들 관찰
    document.querySelectorAll('.fade-in, .slide-in-left').forEach(el => {
      el.style.animationPlayState = 'paused';
      observer.observe(el);
    });

    // 부드러운 스크롤 함수
    function scrollToPopular() {
      const popularSection = document.querySelector('.hero-section:nth-child(3)');
      if (popularSection) {
        popularSection.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
      }
    }

    // 성능 최적화를 위한 이미지 지연 로딩
    const images = document.querySelectorAll('img[data-src]');
    const imageObserver = new IntersectionObserver(function(entries) {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const img = entry.target;
          img.src = img.dataset.src;
          img.classList.remove('lazy');
          imageObserver.unobserve(img);
        }
      });
    });

    images.forEach(img => imageObserver.observe(img));

    // 자동 슬라이드 시작
    startAutoSlide();

    // 접근성 개선 - 키보드 네비게이션
    document.addEventListener('keydown', function(e) {
      if (e.key === 'ArrowLeft' && document.activeElement.closest('.slider-container')) {
        prevSlide();
      } else if (e.key === 'ArrowRight' && document.activeElement.closest('.slider-container')) {
        nextSlide();
      }
    });

    // 에러 처리
    window.addEventListener('error', function(e) {
      console.error('페이지 로딩 중 오류 발생:', e.error);
    });

  </script>
</body>
</html>