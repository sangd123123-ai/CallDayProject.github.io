# 🏋️ CallDayProject

<div align="center">

### 💪 오늘 운동 완료! 건강한 일상을 위한 스마트 피트니스 플랫폼

<br>

![Java](https://img.shields.io/badge/Java-8+-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Spring](https://img.shields.io/badge/Spring-MVC-6DB33F?style=for-the-badge&logo=spring&logoColor=white)
![Oracle](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white)
![Maven](https://img.shields.io/badge/Maven-C71A36?style=for-the-badge&logo=apache-maven&logoColor=white)

<br>

**운동 계획부터 실행, 기록까지 한 곳에서!**

[프로젝트 소개](#-프로젝트-소개) • [주요 기능](#-주요-기능) • [기술 스택](#-기술-스택) • [팀 소개](#-역할erd소개-프레젠테이션)

</div>

---

## 📸 프로젝트 미리보기

<table>
  <tr>
    <td width="33%" align="center">
      <img src="/capture/메인화면.JPG" alt="메인화면" width="100%">
      <br>
      <strong>🏠 메인 화면</strong>
      <br>
      <sub>직관적인 UI로 모든 기능에 빠르게 접근</sub>
    </td>
    <td width="33%" align="center">
      <img src="/capture/AI식단%20추천.jpg" alt="AI식단" width="100%">
      <br>
      <strong>🤖 AI 식단 추천</strong>
      <br>
      <sub>맞춤형 AI 식단 추천</sub>
    </td>
    <td width="33%" align="center">
      <img src="/capture/관리자페이지.JPG" alt="관리자페이지" width="100%">
      <br>
      <strong>⚙️ 관리자 페이지</strong>
      <br>
      <sub>효율적인 콘텐츠 및 회원 관리</sub>
    </td>
  </tr>
</table>

---

## 📑 목차

- [✨ 프로젝트 소개](#-프로젝트-소개)
- [🎯 주요 기능](#-주요-기능)
  - [메인 & 사용자 관리](#-메인--사용자-화면)
  - [관리자 페이지](#️-관리자-페이지)
- [💻 기술 스택](#-기술-스택)
- [📊 역할/ERD/프레젠테이션](#-역할erd소개-프레젠테이션)

---

## ✨ 프로젝트 소개

<div align="center">

![프로젝트 메인](/ppt/프로젝트%20메인.JPG)

</div>

> **CallDayProject**는 운동을 시작하고 꾸준히 지속하고 싶은 모든 사람들을 위한 종합 피트니스 관리 플랫폼입니다.

### 🎯 프로젝트 목표

- 📱 **직관적인 사용자 경험**: 누구나 쉽게 사용할 수 있는 인터페이스
- 📈 **체계적인 관리**: 운동 계획, 실행, 기록을 한 곳에서
- 🤝 **커뮤니티 활성화**: 피드 공유로 동기부여 극대화
- 🤖 **AI 기반 추천**: 개인 맞춤형 식단 추천 시스템

---
# 🩺 CallDay Project (개인 포트폴리오 버전)

건강관리 웹서비스 **CallDay**는 사용자의 운동, 체중, 식단, 쇼핑 기능을 통합한 웹 헬스케어 플랫폼입니다.  
본 저장소는 5인 팀 프로젝트 중 **제가 직접 담당한 개발 파트(Main / Admin / OAuth2)** 중심으로 정리한 개인 포트폴리오 버전입니다.

---

## 📌 프로젝트 개요
- **프로젝트명:** CallDay (건강관리 웹 플랫폼)
- **진행기간:** 2025.08 ~ 2025.09
- **팀 구성:** 5인 (기획 1 / 백엔드 2 / 프론트엔드 2)
- **개발 환경:** Spring Framework + Oracle + JavaScript 기반  
- **주요 목표:** 사용자 건강 기록, 운동 정보, 쇼핑몰, 관리자 기능 통합

---

## ⚙️ 기술 스택

| 구분 | 기술 |
|------|------|
| **Frontend** | HTML5, CSS3, JavaScript, jQuery, Bootstrap5, Slick Carousel |
| **Backend** | Java, Spring Framework, Spring Security, MyBatis, JPA |
| **Database** | Oracle XE |
| **ETC** | OAuth2 (Kakao / Naver), ApexCharts, GitHub, Eclipse, SQL Developer |

---

## 👤 담당 역할

### 🏠 1. 메인 페이지 구현
- 메인 페이지 UI/UX 설계 및 반응형 레이아웃 구성  
- Bootstrap5, Slick Carousel 등을 활용한 슬라이더/배너 영역 구성  
- JavaScript로 동적 콘텐츠(운동/상품 카드) 표시 로직 구현  
- **MyBatis + JPA 병행 사용으로 데이터 호출 구조 최적화 및 성능 비교 경험**

---

### 🛠 2. 관리자 페이지 개발
- 관리자 전용 로그인 및 접근 제어 설정 (Spring Security 기반)  
- 슬라이더 관리 CRUD 기능 (이미지 업로드, 수정, 삭제)  
- 스토어 상품 관리 기능 (상품 등록, 수정, 삭제)  
- **ApexCharts를 활용한 관리자 통계 시각화 구현 (회원 수, 방문자 로그, 좋아요 통계 등)**  
- MyBatis + JPA 병행으로 DAO와 Entity 설계 및 DB 연동

---

### 🔐 3. 로그인 및 OAuth2 기능
- 일반 로그인(Spring Security + BCrypt) 구현  
- 카카오, 네이버 OAuth2 로그인 연동 및 사용자 정보 처리  
- 로그인 후 세션 관리 및 권한 부여 로직 구현  
- OAuth2 클라이언트 설정, Redirect URI 처리, 사용자 DB 연동 경험  

---

## 💬 협업 및 문제 해결 경험
- 기능 구현 방향 충돌 시, 감정적 대응 대신 **문제의 원인을 정리하고 이성적으로 조율**  
- Git을 통한 버전 관리 및 병합 충돌 해결 경험  
- 백엔드-프론트엔드 간 데이터 연동 시, RESTful 구조와 요청 흐름을 명확히 이해  
- 협업 과정에서 **“기술보다 커뮤니케이션이 프로젝트 완성의 핵심”**임을 체감

---

## 🌱 배운 점
- MyBatis와 JPA를 병행하며 SQL 중심 접근과 ORM 접근의 차이를 실무적으로 경험  
- OAuth2 및 Security 설정을 직접 구성하며 인증/인가의 흐름을 명확히 이해  
- 프론트엔드와 백엔드의 데이터 흐름을 직접 연결하며 전체 시스템 구조 설계 감각을 향상  

---

📎 **프로젝트 저장소:**  
[https://github.com/sangd123123-ai/CallDayProject.github.io](https://github.com/sangd123123-ai/CallDayProject.github.io)

> ※ 본 프로젝트는 팀 협업으로 진행되었으며, 본 저장소는 개인 포트폴리오용으로  
> **제가 직접 개발한 메인 페이지, 관리자 페이지, 로그인(OAuth2) 파트** 중심으로 구성되어 있습니다.



---

## 🎯 주요 기능

### 🏠 메인 & 사용자 화면

<details>
<summary><b>📷 스크린샷 보기</b></summary>

<br>

<table>
  <tr>
    <td width="50%">
      <img src="/capture/메인화면.JPG" alt="메인화면" width="100%">
      <p align="center"><strong>메인 화면</strong></p>
    </td>
    <td width="50%">
      <img src="/capture/인기게시물.jpg" alt="인기게시물" width="100%">
      <p align="center"><strong>인기 게시물</strong></p>
    </td>
  </tr>
  <tr>
    <td width="50%">
      <img src="/capture/로그인창.jpg" alt="로그인창" width="100%">
      <p align="center"><strong>로그인</strong></p>
    </td>
    <td width="50%">
      <img src="/capture/회원가입창.jpg" alt="회원가입" width="100%">
      <p align="center"><strong>회원가입</strong></p>
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <img src="/capture/내정보페이지.JPG" alt="내정보" width="100%">
      <p align="center"><strong>내 정보 관리</strong></p>
    </td>
  </tr>
</table>

</details>

**주요 특징**
- ✅ 간편한 회원가입 및 로그인
- ✅ 개인정보 수정 및 관리
- ✅ 실시간 인기 게시물 확인

---




### ⚙️ 관리자 페이지

<details>
<summary><b>📷 스크린샷 보기</b></summary>

<br>

<table>
  <tr>
    <td colspan="2">
      <img src="/capture/관리자페이지.JPG" alt="관리자페이지" width="100%">
      <p align="center"><strong>관리자 대시보드</strong></p>
    </td>
  </tr>
  <tr>
    <td width="50%">
      <img src="/capture/관리자_공지사항관리.JPG" alt="공지사항관리" width="100%">
      <p align="center"><strong>공지사항 관리</strong></p>
    </td>
    <td width="50%">
      <img src="/capture/관리자_운동가이드관리.JPG" alt="운동가이드관리" width="100%">
      <p align="center"><strong>운동가이드 관리</strong></p>
    </td>
  </tr>
  <tr>
    <td width="50%">
      <img src="/capture/관리자_회원관리.JPG" alt="회원관리" width="100%">
      <p align="center"><strong>회원 관리</strong></p>
    </td>
    <td width="50%">
      <img src="/capture/관리자_스토어관리.JPG" alt="스토어관리" width="100%">
      <p align="center"><strong>스토어 관리</strong></p>
    </td>
  </tr>
</table>

</details>

**주요 특징**
- 👥 회원 정보 조회 및 관리
- 📢 공지사항 작성 및 수정
- 🏋️ 운동 가이드 콘텐츠 관리
- 🛒 스토어 상품 관리

---

## 💻 기술 스택

### Backend
```
Java 8+
Spring MVC
Oracle Database
Maven
```

### Frontend
```
HTML5
CSS3
JavaScript
JSP
```

### Tools & Environment
```
Eclipse / IntelliJ IDEA
Apache Tomcat
Git & GitHub
```

---

## 📊 역할/ERD/소개 프레젠테이션

<details>
<summary><b>📊 프레젠테이션 자료 보기</b></summary>

<br>

### 👥 팀 역할 분담

<table>
  <tr>
    <td width="50%">
      <img src="/ppt/역할.JPG" alt="역할1" width="100%">
    </td>
    <td width="50%">
      <img src="/ppt/역할2.JPG" alt="역할2" width="100%">
    </td>
  </tr>
</table>

### 🗂️ 데이터베이스 ERD

<img src="/ppt/ERD.JPG" alt="ERD" width="100%">

### 📱 시스템 구성 소개

<table>
  <tr>
    <td width="50%">
      <img src="/ppt/구성%20소개%202.JPG" alt="구성2" width="100%">
    </td>
    <td width="50%">
      <img src="/ppt/구성%20소개%203.JPG" alt="구성3" width="100%">
    </td>
  </tr>
  <tr>
    <td width="50%">
      <img src="/ppt/구성%20소개%204.JPG" alt="구성4" width="100%">
    </td>
    <td width="50%">
      <img src="/ppt/구성%20소개%205.JPG" alt="구성5" width="100%">
    </td>
  </tr>
  <tr>
    <td width="50%">
      <img src="/ppt/구성%20소개%206.JPG" alt="구성6" width="100%">
    </td>
    <td width="50%">
      <img src="/ppt/구성%20소개%20끝%20평가%20및%20개선.JPG" alt="평가개선" width="100%">
    </td>
  </tr>
</table>

</details>

---

<div align="center">

### 💪 지금 바로 시작하세요!

**건강한 일상, CallDay와 함께**

<br>

Made with ❤️ by CallDayProject Team

</div>
