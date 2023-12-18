<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<fmt:requestEncoding value="utf-8" />


<!DOCTYPE html>
<html>

<head>
<script src="https://code.jquery.com/jquery-3.7.0.js"
   type="text/javascript"></script>
<script>
$(document).ready( function(){
	$("#attDetailSch").click(function(){
		search()
	})
   $.ajax({
      url:'${path}/checkAtt.do',
      type:'get',
      dataType:'json',
      data:"worker_id="+${worker_id},
      success:function(data){
         if(data.check_in){
            $('#arrvlBtn').attr("disabled",true)
         }
         if(data.check_out){
             $('#leaveBtn').attr("disabled",true)
          }
       }
    })

    // 7월 출결 현황
    $.ajax({
       url:'${path}/recentAttSum.do',
       type:'get',
       dataType:'json',
       data:"worker_id="+${worker_id},
       success:function(data){
          console.log("정상출근>>>>> "+data.att01)
          console.log(data.att02)
          console.log(data.att03)
          console.log(data.att04)
          console.log(data.att05)
          
          $("#att01").text(data.att01+" 일") 
          $("#att02").text(data.att02+" 일")
          $("#att03").text(data.att03+" 일")
         $("#att04").text(data.att04+ " 일")          
         $("#att05").text(data.att05+ " 일")          
         $("#att06").text(data.att06+ " 일") 
       },
       error:function(e){
          alert(e.status+" 에러 입니다")
       }
    })
    $("#attDetailSch").click()
    // 출결 검색
    function search(){
       var month=0
       var year =0
       var check_in_status=''
       var check_out_status=''
       month = $("#mtnSch").val()
       year = $("#yearSch").val()
       var check_in_status = $("#arrvlStat").val()
       var check_out_status =$("#leaveStat").val()
       console.log('uri : '+'worker_id='+${worker_id}+'&check_in_status='+check_in_status+"&check_out_status="+check_out_status+"&year="+year+"&month="+month)
       $.ajax({
          url:"${path}/attSch.do",
          contentType:"application/x-www-form-urlencoded;charset=UTF-8",
          type:'get',
          data:'worker_id='+${worker_id}+'&check_in_status='+check_in_status+"&check_out_status="+check_out_status+"&year="+year+"&month="+month,
          dataType:'json',
          success:function(data){
             var add=""
             
                $.each(data, function(index, att){
                   if(att.check_in_time==null) att.check_in_time=""
                   if(att.check_out_time==null) att.check_out_time=""
                  add+="<tr>"
                  add+="<td>"+att.today_date+"</td>"
                  add+="<td>"+att.check_in_time+"</td>"
                  add+="<td>"+att.check_in_status+"</td>"
                  add+="<td>"+att.check_out_time+"</td>"
                  add+="<td>"+att.check_out_status+"</td>"
                  add+="</tr>"
             })
                $("#attShow").html(add)
          }
       })
    }
    
    
    
}); 
   

</script>


<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>오피셋</title>

<!-- Custom fonts for this template-->
<link href="${path}/resources/vendor/fontawesome-free/css/all.min.css"
   rel="stylesheet" type="text/css">
<script src="https://kit.fontawesome.com/44ab4b04c0.js"
   crossorigin="anonymous"></script>
<link
   href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
   rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/resources/css/sb-admin-2.min.css" rel="stylesheet">


</head>

<body id="page-top">

   <!-- Page Wrapper -->
   <div id="wrapper">

      <!-- 사이드바 -->
      <%@ include file="sidebar.jsp"%>

      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">

         <!-- Main Content -->
         <div id="content">

            <!-- 상위바 -->
            <%@include file="topbar.jsp"%>
            <!-- 상단바 끝 -->

            <!-- 메인 페이지 내용 -->
            <div class="container-fluid">

               <!-- 오늘 날짜 구하기 -->
               <c:set var="now" value="<%=new java.util.Date() %>"/>
                     <c:set var="today_date"><fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일" /></c:set>
                     <c:set var="this_month"><fmt:formatDate value="${now}" pattern="MM월"/></c:set>
               
               <div
                  class="d-sm-flex align-items-center justify-content-between">
                  <h1 class="h3 ml-3 text-grey" ><c:out value="${this_month}"/> 출결 현황</h1>
               </div>
               <hr class="mb-4 ml-3 mr-3" >
               <!-- 근태 리스트  -->
               <div class="row m-2">

                  <!-- 출근 -->
                  <div class="col-xl-2 col-md-6 mb-4">
                     <div class="card border-left-primary shadow h-100 py-2">
                        <div class="card-body">
                           <div class="row no-gutters align-items-center">
                              <div class="col mr-2">
                                 <div
                                    class="text-l font-weight-bold text-primary text-uppercase mb-1">
                                    출근</div>
                                 <div class="h5 mb-0 font-weight-bold text-gray-800" id="att01">17(출근일수)</div>
                              </div>
                              <div class="col-auto">
                                 <i class="fas fa-face-smile fa-2x text-gray-300"></i>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>


                  <!-- 결근 -->
                  <div class="col-xl-2 col-md-6 mb-4">
                     <div class="card border-left-danger shadow h-100 py-2">
                        <div class="card-body">
                           <div class="row no-gutters align-items-center">
                              <div class="col mr-2">
                                 <div
                                    class="text-l font-weight-bold text-danger text-uppercase mb-1">
                                    결근</div>
                                 <div class="h5 mb-0 font-weight-bold text-gray-800" id="att02">2(결근일수)</div>
                              </div>
                              <div class="col-auto">
                                 <i class="fas fa-face-sad-tear fa-2x text-gray-300"></i>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>

                  <div class="col-xl-2 col-md-6 mb-4">
                     <div class="card border-left-warning shadow h-100 py-2">
                        <div class="card-body">
                           <div class="row no-gutters align-items-center">
                              <div class="col mr-2">
                                 <div
                                    class="text-l font-weight-bold text-warning text-uppercase mb-1">
                                    지각</div>
                                 <div class="h5 mb-0 font-weight-bold text-gray-800" id="att03">2(지각일수)</div>
                              </div>
                              <div class="col-auto">
                                 <i class="fas fa-face-sad-cry fa-2x text-gray-300"></i>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>

                  <!-- 휴가(총일수 대비 퍼센트) -->
                  <div class="col-xl-2 col-md-6 mb-4">
                     <div class="card border-left-info shadow h-100 py-2">
                        <div class="card-body">
                           <div class="row no-gutters align-items-center">
                              <div class="col mr-2">
                                 <div
                                    class="text-l font-weight-bold text-info text-uppercase mb-1">휴가
                                 </div>
                                 <div class="row no-gutters align-items-center">
                                    <div class="col-auto">
                                       <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" id="att04"></div>
                                    </div>
                                    <!-- <div class="col">
                                       <div class="progress progress-sm mr-2">
                                          <div class="progress-bar bg-info" role="progressbar"
                                             style="width: 50%" aria-valuenow="50" aria-valuemin="0"
                                             aria-valuemax="100"></div>
                                       </div>
                                    </div> -->
                                 </div>
                              </div>
                              <div class="col-auto">
                                 <i class="fas fa-umbrella-beach fa-2x text-gray-300"></i>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>

                  <!-- 병가 -->
                  <div class="col-xl-2 col-md-6 mb-4">
                     <div class="card border-left-info shadow h-100 py-2">
                        <div class="card-body">
                           <div class="row no-gutters align-items-center">
                              <div class="col mr-2">
                                 <div
                                    class="text-l font-weight-bold text-info text-uppercase mb-1">병가
                                 </div>
                                 <div class="row no-gutters align-items-center">
                                    <div class="col-auto">
                                       <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800" id="att05">50%</div>
                                    </div>
                                    <!-- <div class="col">
                                       <div class="progress progress-sm mr-2">
                                          <div class="progress-bar bg-info" role="progressbar"
                                             style="width: 50%" aria-valuenow="50" aria-valuemin="0"
                                             aria-valuemax="100"></div>
                                       </div>
                                    </div> -->
                                 </div>
                              </div>
                              <div class="col-auto">
                                 <i class="fas fa-syringe fa-2x text-gray-300"></i>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>

                  <!--조퇴-->
                  <div class="col-xl-2 col-md-6 mb-4">
                     <div class="card border-left-success shadow h-100 py-2">
                        <div class="card-body">
                           <div class="row no-gutters align-items-center">
                              <div class="col mr-2">
                                 <div
                                    class="text-l font-weight-bold text-success text-uppercase mb-1">
                                    조퇴</div>
                                 <div class="h5 mb-0 font-weight-bold text-gray-800" id="att06"></div>
                              </div>
                              <div class="col-auto">
                                 <i class="fas fa-face-surprise fa-2x text-gray-300"></i>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>


               <!-- 테이블 -->
               <div class="container-fluid">


                  <div class="table-responsive">
                     <h2 class="h3 text-grey">나의 출결 리스트</h2>
                     <hr>
                     <div class="container-fluid mb-3 d-flex justify-content-between ">
                        <p class="mt-3">오늘은 <c:out value="${today_date}"/> 입니다</p>
                        <div class="ml-3 mb-3 mt-1 d-flex justify-content-between">
                        
                           <select id="yearSch">
                              <option selected value=0>년도</option>
                              <option value="2022">2022년</option>
                              <option value="2023">2023년</option>
                           </select>
                           <select id="mtnSch" class="form-select ml-3 ">
                              <option selected value=0>월</option>
                              <option value="1">1월</option>
                              <option value="2">2월</option>
                              <option value="3">3월</option>
                              <option value="4">4월</option>
                              <option value="5">5월</option>
                              <option value="6">6월</option>
                              <option value="7">7월</option>
                              <option value="8">8월</option>
                              <option value="9">9월</option>
                              <option value="10">10월</option>
                              <option value="11">11월</option>
                              <option value="12">12월</option>
                           </select>
                           <select id="arrvlStat" class="form-select ml-3" aria-label=".form-select-lg example">
                              <option selected value="">출근상태</option>
                              <option value="정상출근">정상출근</option>
                              <option value="지각">지각</option>
                              <option value="휴가">휴가</option>
                              <option value="결근">결근</option>
                              <option value="병가">병가</option>
                           </select>
                           <select id="leaveStat" class="form-select ml-3" aria-label=".form-select-lg example">
                              <option selected value="">퇴근상태</option>
                              <option value="정상퇴근">정상퇴근</option>
                              <option value="조퇴">조퇴</option>
                              <option value="휴가">휴가</option>
                              <option value="결근">결근</option>
                              <option value="병가">병가</option>
                           </select>
                           <button id="attDetailSch" class="btn btn-warning " style="width:100px;height:40px; margin-left:15px;">검색</button>
                           
                        </div>
                     </div>
                     <table class="table table-hover text-center">
                        <thead>
                           <tr>
                              <th>날짜</th>
                              <th>출근시간</th>
                              <th>출근상태</th>
                              <th>퇴근시간</th>
                              <th>퇴근상태</th>
                           </tr>
                        </thead>
                        <tbody id="attShow">
                           
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>

            <!-- End of Main Content -->

            <!-- Footer -->
            <%@include file="footer.jsp"%>
            <!-- End of Footer -->

         </div>
         <!-- End of Content Wrapper -->

      </div>
      <!-- End of Page Wrapper -->
   </div>
   <!-- Scroll to Top Button-->
   <a class="scroll-to-top rounded" href="#page-top"> <i
      class="fas fa-angle-up"></i>
   </a>

   <!-- Logout Modal   data-toggle="modal" data-target="#attModal"-->
   <div class="modal fade" id="attModal" tabindex="-1" role="dialog"
      aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
               <button class="close" type="button" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">×</span>
               </button>
            </div>
            <div class="modal-body">퇴근하기 전 모든 마무리를 했는지 확인해보세요!</div>
            <div class="modal-footer">
               <button class="btn btn-secondary" type="button"
                  data-dismiss="modal">취소</button>
               <a class="btn btn-primary" href="login.html">로그아웃</a>
            </div>
         </div>
      </div>
   </div>

   <!-- Bootstrap core JavaScript-->
   <script src="${path}/resources/vendor/jquery/jquery.min.js"></script>
   <script
      src="${path}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

   <!-- Core plugin JavaScript-->
   <script
      src="${path}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

   <!-- Custom scripts for all pages-->
   <script src="${path}/resources/js/sb-admin-2.min.js"></script>



   <!-- Page level custom scripts -->

   <script src="${path}/resources/js/demo/datatables-demo.js"></script>
   <script
      src="${path}/resources/vendor/datatables/jquery.dataTables.min.js"></script>
   <script
      src="${path}/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

   <!-- Page level custom scripts -->
   <script src="${path}/resources/js/demo/datatables-demo.js"></script>
</body>

</html>