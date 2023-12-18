<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />
    
            <nav
               class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

               <!-- Sidebar Toggle (Topbar) -->
               <button id="sidebarToggleTop"
                  class="btn btn-link d-md-none rounded-circle mr-3">
                  <i class="fa fa-bars"></i>
               </button>

               <!-- Topbar Search -->
               <form
                  class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                  <div class="input-group">
                        <button id="arrvlBtn" class="btn btn-success ml-1">출근</button>
                        <button id="leaveBtn" class="btn btn-danger ml-1">퇴근</button>
                     <div class="input-group-append">
                     </div>
                  </div>
               </form>

               <!-- Topbar Navbar -->
               <ul class="navbar-nav ml-auto">
                  
                  <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                  <li class="nav-item dropdown no-arrow d-sm-none"><a
                     class="nav-link dropdown-toggle" href="#" id="searchDropdown"
                     role="button" data-toggle="dropdown" aria-haspopup="true"
                     aria-expanded="false"></i>
                  </a> <!-- Dropdown - Messages -->
                     <div
                        class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                        aria-labelledby="searchDropdown">
                        
                     </div></li>
                     <li>
                        <div class="d-flex mt-3">
                           
                        </div>
                     </li>

                  <!-- Nav Item - 알림 -->
                  <li class="nav-item dropdown no-arrow mx-1"><a
                     class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
                     role="button" data-toggle="dropdown" aria-haspopup="true"
                     aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
                        <span class="badge badge-danger badge-counter">알림개수</span>
                  </a> <!-- Dropdown - Alerts -->
                     <div
                        class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                        aria-labelledby="alertsDropdown">
                        <h6 class="dropdown-header">최신 알림</h6>
                        <a class="dropdown-item d-flex align-items-center" href="#">
                           <div class="mr-3">
                              <div class="icon-circle bg-primary">
                                 <i class="fas fa-file-alt text-white"></i>
                              </div>
                           </div>
                           <div>
                              <div class="small text-gray-500">날짜 넣기</div>
                              <span class="font-weight-bold">결재 관련 메세지 넣기</span>
                           </div>
                        </a>
                        <!-- <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 7, 2019</div>
                                        $290.29 has been deposited into your account!
                                    </div>
                                </a> -->
                        <a class="dropdown-item d-flex align-items-center" href="#">
                           <div class="mr-3">
                              <div class="icon-circle bg-danger">
                                 <i class="fas fa-exclamation-triangle text-white"></i>
                              </div>
                           </div>
                           <div>
                              <div class="small text-gray-500">날짜 넣는 공간</div>
                              결근 관련 메세지 넣기
                           </div>
                        </a> <a class="dropdown-item text-center small text-gray-500"
                           href="#">Show All Alerts</a>
                     </div></li>


                  <div class="topbar-divider d-none d-sm-block"></div>

                  <!-- Nav Item - User Information -->
                  <li class="nav-item dropdown no-arrow"><a
                     class="nav-link dropdown-toggle" href="#" id="userDropdown"
                     role="button" data-toggle="dropdown" aria-haspopup="true"
                     aria-expanded="false"> <span
                        class="mr-2 d-none d-lg-inline text-gray-600 small"> ${userInfo.n_name}
                           님 환영합니다</span> <img class="img-profile rounded-circle"
                        src="${path}/image/${userInfo.fname}">
                  </a> <!-- Dropdown - User Information -->
                     <div
                        class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                        aria-labelledby="userDropdown">
                        <a class="dropdown-item" href="${path}/profile.do"> <i
                           class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 프로필
                        </a>

                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" id="logoutBtn" > <i
                           class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                           로그아웃
                        </a>
                     </div></li>

               </ul>

            </nav>
            <!-- 출근/퇴근 버튼 -->
                  <script type="text/javascript">
                     
                     $('#arrvlBtn').click(function(){
                        if(confirm('출근하시겠습니까?')==true){
                           
                           console.log('데이터 전송!')
                           $.ajax({
                              url:'${path}/arrival.do',
                              type:'post',
                              dataType:'text',
                              data:"worker_id="+${worker_id},
                              success:function(check_in_time){
                                 console.log('시간'+check_in_time)
                                 alert(check_in_time+' 출근하셨습니다!')
                                 $('#arrvlBtn').attr("disabled",true)
                              },
                              error:function(e){
                                 alert('서버오류입니다 '+e.status)
                              }
                              
                           })
                        } 
                     })
                     // 퇴근 버튼
               $("#leaveBtn").click(function(){
                        if(confirm('퇴근하시겠습니까?')==true){
                           console.log('퇴근데이터 전송')
                           $.ajax({
                              url:'${path}/leave.do',
                              type:'get',
                              dataType:'text',
                              data:"worker_id="+${worker_id},
                              success:function(check_out_time){
                                 console.log('퇴근시간 : '+check_out_time)
                                 alert(check_out_time+' 퇴근완료하셨습니다')
                                 $('#leaveBtn').attr("disabled",true)
                              },
                              error:function(e){
                                 alert(e.status+'오류 입니다')
                              }
                           })
                        }
                     })
               // 로그아웃
               $('#logoutBtn').click(function(){
                        if(confirm('로그아웃 하시겠습니까?')){
                           $.ajax({
                                url:'${path}/logout.do',
                                type:'get',
                                dataType:'text',
                                success:function(result){
                                   console.log('결과 : '+result)
                                   alert('로그아웃 되었습니다')
                                   location.href='${path}/login.do'
                                },
                                error:function(e){
                                   alert(e.status+'오류 입니다')
                                }
                             })
                        }
                     })

                  </script>

            