<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	String cp = request.getContextPath();
	request.setCharacterEncoding("UTF-8");
	
	// 현재 페이지 경로 가져오기
	String currentPage = request.getRequestURI();
	String pageName = currentPage.substring(currentPage.lastIndexOf("/") + 1);
	if(pageName.contains(".")) {
		pageName = pageName.substring(0, pageName.lastIndexOf("."));
	}
%>
<style>
  .sidebar-brand {
    height: 5.5rem !important; 
  }
</style>
      <!--begin::Sidebar-->
      <aside class="app-sidebar bg-body-secondary shadow" data-bs-theme="dark">
		  <!--begin::Sidebar Brand-->
		  <div class="sidebar-brand" style=" margin-top: 20px;">
		    <!--begin::Brand Link-->
			  <a href="<%=cp%>/admin/dashboard" class="brand-link d-flex flex-column text-center">
				  <div class="brand-text fw-bold">콜데이 프로젝트</div>
				  <div class="brand-text small text-secondary">관리자 페이지</div>
			  </a>
		    <!--end::Brand Link-->
		  </div>
		  <!--end::Sidebar Brand-->
		  
        <!--begin::Sidebar Wrapper-->
        <div class="sidebar-wrapper">
          <nav class="mt-2">
            <!--begin::Sidebar Menu-->
            <ul
              class="nav sidebar-menu flex-column"
              data-lte-toggle="treeview"
              role="navigation"
              aria-label="Main navigation"
              data-accordion="false"
              id="navigation">
              
              <!-- 대시보드 -->
              <li class="nav-item">
                <a href="<%=cp%>/admin/dashboard" class="nav-link <%= pageName.equals("dashboard") ? "active" : "" %>">
                  <i class="nav-icon bi bi-speedometer"></i>
                  <p>대시보드</p>
                </a>
              </li>
              
              <!-- 회원관리 -->
              <li class="nav-item">
                <a href="<%=cp%>/admin/users" class="nav-link <%= pageName.equals("users") ? "active" : "" %>">
                  <i class="nav-icon bi bi-people"></i>
                  <p>회원관리</p>
                </a>
              </li>
              
              <!-- 공지사항 관리 -->
              <li class="nav-item">
                <a href="<%=cp%>/admin/mainslider" class="nav-link <%= pageName.equals("mainslider") ? "active" : "" %>">
                  <i class="nav-icon bi bi-megaphone"></i>
                  <p>공지사항 관리</p>
                </a>
              </li>
              
              <!-- 스토어 관리 -->
              <li class="nav-item">
                <a href="<%=cp%>/admin/mainstore" class="nav-link <%= pageName.equals("mainstore") ? "active" : "" %>">
                  <i class="nav-icon bi bi-shop"></i>
                  <p>스토어 관리</p>
                </a>
              </li>
              
              <!-- 운동 가이드 관리 -->
              <li class="nav-item">
                <a href="<%=cp%>/admin/admin_exercise" class="nav-link <%= pageName.equals("admin_exercise") ? "active" : "" %>">
                  <i class="nav-icon bi bi-heart-pulse"></i>
                  <p>운동 가이드 관리</p>
                </a>
              </li>

            </ul>
            <!--end::Sidebar Menu-->
          </nav>
        </div>
        <!--end::Sidebar Wrapper-->
      </aside>
      <!--end::Sidebar-->