<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />

		<ul
			class="navbar-nav sidebar sidebar-dark accordion"
			id="accordionSidebar"
			style="background-color:#9747FF; background-image:linear-gradient">

			<!-- Sidebar - Brand -->
			<li><a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="${path}/profile.do">
					<div>
						<i class="fa-solid fa-user"></i>
					</div>
					<div class="sidebar-brand-text mx-3">
						 ${userInfo.name}님 <sup></sup>
					</div>
			</a></li>
			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->

			<li class="nav-item active"><a class="nav-link" href="${path}/main.do">
					<i class="fa-solid fa-house"></i> <span>메인</span>
			</a></li>


			<!-- Divider -->


			<hr class="sidebar-divider my-0">

			<!-- Heading -->


			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="${path}/profile.do"
				data-toggle="collapse" data-target="#collapseTwo"
				aria-expanded="true" aria-controls="collapseTwo"> <i
					class="fas fa-fw fa-address-card"></i> <span>나의정보</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">나의 정보</h6>
						<a class="collapse-item" href="${path}/profile.do">프로필</a> <a
							class="collapse-item" href="${path}/profile_edit.do">정보 수정</a>
					</div>
				</div></li>
			<hr class="sidebar-divider my-0">
			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseUtilities"
				aria-expanded="true" aria-controls="collapseUtilities"> <i
					class="fas fa-fw fa-file-signature"></i> <span>결재</span>
			</a>
				<div id="collapseUtilities" class="collapse"
					aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">결재</h6>
						<a class="collapse-item" href="${path}/approval_req.do">결재요청</a> 
						<c:if test="${userInfo.auth == 'PR' || userInfo.auth == 'ADMIN' || userInfo.auth == 'TL'}">
    					<a class="collapse-item" href="${path}/approval_app.do?worker_id=${userInfo.worker_id}">결재승인</a>
						</c:if>
						<a class="collapse-item" href="${path}/approval_status.do">결재현황</a>

					</div>
				</div></li>

			<!-- Divider -->
			<c:if test="${userInfo.auth == 'PR' || userInfo.auth == 'ADMIN'}">
			<hr class="sidebar-divider">

			<!-- 관리자 메뉴 -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseUtilities2"
				aria-expanded="true" aria-controls="collapseUtilities2"> <i
					class="fas fa-users-cog"></i> <span>관리자</span>
			</a>
				<div id="collapseUtilities2" class="collapse"
					aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">관리자</h6>
						<a class="collapse-item" href="${path}/admin_worker.do">사원관리</a> <a
							class="collapse-item" href="${path}/admin_approval.do">결재관리</a> <a
							class="collapse-item" href="${path}/admin_attendance.do">근태관리</a>

					</div>
				</div></li>
						</c:if>
			<!-- <div class="sidebar-heading">관리자</div>

			Nav Item - Pages Collapse Menu
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages"
				aria-expanded="true" aria-controls="collapsePages"> <i
					class="fas fa-fw fa-folder"></i> <span>Pages</span>
			</a>
				<div id="collapsePages" class="collapse"
					aria-labelledby="headingPages" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">Login Screens:</h6>
						<a class="collapse-item" href="login.html">Login</a> <a
							class="collapse-item" href="register.html">Register</a> <a
							class="collapse-item" href="forgot-password.html">Forgot
							Password</a>
						<div class="collapse-divider"></div>
						<h6 class="collapse-header">Other Pages:</h6>
						<a class="collapse-item" href="404.html">404 Page</a> <a
							class="collapse-item" href="blank.html">Blank Page</a> <a
							class="collapse-item" href="utilities-other.html">Other</a>
					</div>
				</div></li>

			Nav Item - Charts
			<li class="nav-item"><a class="nav-link" href="charts.html">
					<i class="fas fa-fw fa-chart-area"></i> <span>Charts</span>
			</a></li>

			Nav Item - Tables
			<li class="nav-item"><a class="nav-link" href="tables.html">
					<i class="fas fa-fw fa-table"></i> <span>Tables</span>
			</a></li> -->

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

			<!-- Sidebar Message
            <div class="sidebar-card d-none d-lg-flex">
                <img class="sidebar-card-illustration mb-2" src="img/undraw_rocket.svg" alt="...">
                <p class="text-center mb-2"><strong>SB Admin Pro</strong> is packed with premium features, components, and more!</p>
                <a class="btn btn-success btn-sm" href="https://startbootstrap.com/theme/sb-admin-pro">Upgrade to Pro!</a>
            </div>
 			-->
		</ul>
