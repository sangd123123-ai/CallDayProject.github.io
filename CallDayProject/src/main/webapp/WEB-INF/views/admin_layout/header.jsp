<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	String cp = request.getContextPath();
	request.setCharacterEncoding("UTF-8");
%>

      <!--begin::Header-->
      <nav class="app-header navbar navbar-expand bg-body">
        <!--begin::Container-->
        <div class="container-fluid">
          <!--begin::Start Navbar Links-->
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link" data-lte-toggle="sidebar" href="#" role="button">
                <i class="bi bi-list"></i>
              </a>
            </li>
            <li class="nav-item d-none d-md-block">
              <a href="/" class="nav-link">
                <i class="bi bi-house me-1"></i>메인 페이지
              </a>
            </li>
          </ul>
          <!--end::Start Navbar Links-->
          
          <!--begin::End Navbar Links-->
          <ul class="navbar-nav ms-auto">
            <!--begin::Fullscreen Toggle-->
            <li class="nav-item">
              <a class="nav-link" href="#" data-lte-toggle="fullscreen">
                <i data-lte-icon="maximize" class="bi bi-arrows-fullscreen"></i>
                <i data-lte-icon="minimize" class="bi bi-fullscreen-exit" style="display: none"></i>
              </a>
            </li>
            <!--end::Fullscreen Toggle-->
            
            <!--begin::User Menu Dropdown-->
            <li class="nav-item dropdown user-menu">
              <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                <i class="bi bi-person-circle me-2"></i>
                <span class="d-none d-md-inline">관리자</span>
              </a>
              <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-end">
                <!--begin::User Header-->
                <li class="user-header text-bg-primary">
                  <div class="d-flex align-items-center justify-content-center flex-column">
                    <i class="bi bi-shield-check display-4 text-white mb-2"></i>
                    <p class="mb-0">
                      CallDay 관리자
                      <small class="d-block">시스템 관리</small>
                    </p>
                  </div>
                </li>
                <!--end::User Header-->
                
                <!--begin::Menu Footer-->
                <li class="user-footer">
                  <a href="#" class="btn btn-default btn-flat">설정</a>
                  <a href="/logout" class="btn btn-default btn-flat float-end">로그아웃</a>
                </li>
                <!--end::Menu Footer-->
              </ul>
            </li>
            <!--end::User Menu Dropdown-->
          </ul>
          <!--end::End Navbar Links-->
        </div>
        <!--end::Container-->
      </nav>
      <!--end::Header-->