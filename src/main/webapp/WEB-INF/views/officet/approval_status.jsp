<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<title>오피셋</title>

<!-- Custom fonts for this template-->
<link href="${path}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
   type="text/css">
<script src="https://kit.fontawesome.com/44ab4b04c0.js"
   crossorigin="anonymous"></script>
<link
   href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
   rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/resources/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<script type="text/javascript">

    $(document).ready(function () {
       $.ajax({
             url:'${path}/checkAtt.do',
             type:'get',
             dataType:'json',
             data:"worker_id="+${worker_id},
             success:function(data){
                //alert('성공!'+data.check_out+' '+data.check_in)
                if(data.check_in){
                   $('#arrvlBtn').attr("disabled",true)
                }
                if(data.check_out){
                   $('#leaveBtn').attr("disabled",true)
                }
             }
          }) 
          
 // ==========================================================================       
// 내가 결재한 리스트 - 팀원 가져오기
$("#selectRequestTeam").on("change", function () {
    var approver_team = this.value;
    var requester = "";
    var approver = "${userInfo.name}";
    $.ajax({
        url: '${path}/getApprover.do',
        type: 'get',
        data: { "requester_team": approver_team, "requester": requester, "approver": approver },
        dataType: 'json',
        success: function (data) {
            var requestSelect = $("#selectRequestName");
            requestSelect.empty();
            requestSelect.append("<option value=''>사원명</option>");
            if (Array.isArray(data)) {
                for (var i = 0; i < data.length; i++) {
                    var requesterName = data[i].requester;
                    requestSelect.append("<option value='" + requesterName + "'>" + requesterName + "</option>");
                }
            } else {
                console.log("데이터 형식이 올바르지 않습니다.");
                console.log(data); // 실제 데이터 확인
            }
        },
        error: function (e) {
            console.log(e.status + '에러 입니다');
        }
    });
});
 // ========================================================================== 
	 	$("#showRequestList").click(function(){
	 		search()
	 	})
       // "내가 결재한 리스트" 버튼 클릭 시 동작
       function search() {
          var requester = $("#selectRequestName").val();
           var selectedApproverTeam = $("#selectRequestTeam").val();
           var selectedApproverName = "${userInfo.name}"
           $.ajax({
               url: '${path}/getApproverList2.do',
               type: 'get',
               data: {
                  "requester": requester,
                   "requester_team": selectedApproverTeam,
                   "approver": selectedApproverName
               },
               dataType: 'json',
               success: function (data) {
                  console.log(data)
                   var requestTable = $("#myRequestTable tbody");
                   requestTable.empty();

                   $.each(data, function (index, request) {

                       requestTable.append("<tr><td>" + request.approval_id + "</td><td>" 
                           + request.approval_type + "</td><td>" + request.approval_msg + "</td><td>" + request.status_name + "</td><td>" + request.step_name + "</td><td>"
                           + request.approval_request_time + "</td><td>" + request.approver_team + "</td><td>" + request.approver + "</td><td>"
                           + request.requester_team + "</td><td>" + request.requester+ "</td></tr>");
                   });
               },
               error: function (e) {
                   console.log(e.status + '에러 입니다');
               }
           });
       }

//===============================================================================================       
// 내가 신청한 결재 - 팀원 가져오기
$("#selectApproverTeam").on("change", function () {
    var approver_team = this.value;
    var requester = "${userInfo.name}";
    var approver = "";
    $.ajax({
        url: '${path}/getRequest.do',
        type: 'get',
        data: { "approver_team": approver_team, "requester": requester, "approver": approver },
        dataType: 'json',
        success: function (data) {
            var approverSelect = $("#selectApproverName");
            approverSelect.empty();
            approverSelect.append("<option value=''>사원명</option>");


            if (Array.isArray(data)) {
                for (var i = 0; i < data.length; i++) {
                    var approverName = data[i].approver;
                    approverSelect.append("<option value='" + approverName + "'>" + approverName + "</option>");
                }
            } else {
                console.log("데이터 형식이 올바르지 않습니다.");
                console.log(data); // 실제 데이터 확인
            }
        },
        error: function (e) {
            console.log(e.status + '에러 입니다');
        }
    });
});
//===============================================================================================       
       // "내가 신청한 결재" 버튼 클릭 시 동작
       $("#showApproverList").click(function () {
          var requester = "${userInfo.name}";
           var selectedApproverTeam = $("#selectApproverTeam").val();
           var selectedApproverName = $("#selectApproverName").val();
           $.ajax({
               url: '${path}/getRequestList.do',
               type: 'get',
               data: {
                  "requester": requester,
                   "approver_team": selectedApproverTeam,
                   "approver": selectedApproverName
               },
               dataType: 'json',
               success: function (data) {
                  console.log(data)
                   var requestTable = $("#myApproverTable tbody");
                   requestTable.empty();

                   $.each(data, function (index, request) {

                       requestTable.append("<tr><td>" + request.approval_id + "</td><td>" 
                           + request.approval_type + "</td><td>" + request.approval_msg + "</td><td>" + request.status_name + "</td><td>" + request.step_name + "</td><td>"
                           + request.approval_request_time + "</td><td>" + request.approver_team + "</td><td>" + request.approver + "</td><td>"
                           + request.requester_team + "</td><td>" + request.requester+ "</td></tr>");
                   });
               },
               error: function (e) {
                   console.log(e.status + '에러 입니다');
               }
           });
       });
//===============================================================================================       
     });


    </script>
<body id="page-top">

   <div id="wrapper">
      <%@ include file="sidebar.jsp"%>
      <div id="content-wrapper" class="d-flex flex-column">
         <div id="content">
            <%@include file="topbar.jsp"%>
            <div class="container-fluid">
               <div class="mb-3">
                  <h2>결재현황</h2>
               </div>
               <div class="card mb-4 mt-3">
                  <!-- ========================================================================= -->
                  <div class="card mb-3">
                     <div class="card-header text-dark">
                        <h5>내가 결재한 리스트</h5>
                     </div>
                     <div class="card-body">
                        <div class="row">
                           <div class="col-2">
                              <label for="selectRequestTeam">결재자 부서명:</label> <select
                                 id="selectRequestTeam" class="custom-select">
                                 <option value="">부서명</option>
                                 <option value="HQ">HQ</option>
                                 <option value="SALES">SALES</option>
                                 <option value="MANAGE">MANAGE</option>
                                 <option value="PLAN">PLAN</option>
                                 <option value="TECH">TECH</option>
                                 <option value="PROD">PROD</option>
                              </select>
                           </div>
                           <div class="col-2">
                              <label>결재자:</label> <select id="selectRequestName"
                                 class="custom-select">
                                 <option value="">사원명</option>
                              </select>
                           </div>
                           <div class="col-2">
                              <button id="showRequestList" class="btn btn-primary">조회</button>
                           </div>
                        </div>
                        <table id="myRequestTable" class="table table-hover mt-3">
                           <thead>
                              <tr>
                                 <th>번호</th>
                                 <th>결재유형</th>
                                 <th>결재내용</th>
                                 <th>결재단계</th>
                                 <th>결재상태</th>
                                 <th>결재등록일</th>
                                 <th>승인자팀명</th>
                                 <th>승인자명</th>
                                 <th>결재자명</th>
                                 <th>결재자팀명</th>
                              </tr>
                           </thead>
                           <tbody>
                           </tbody>
                        </table>
                     </div>
                  </div>
                  <!-- ========================================================================= -->
                  <div class="card mb-3">
                     <div class="card-header text-dark">
                        <h5>내가 신청한 결재</h5>
                     </div>
                     <div class="card-body">
                        <div class="row">
                           <div class="col-2">
                              <label for="selectApproverTeam">승인자 부서명:</label> <select
                                 id="selectApproverTeam" class="custom-select">
                                 <option value="">부서명</option>
                                 <option value="HQ">HQ</option>
                                 <option value="SALES">SALES</option>
                                 <option value="MANAGE">MANAGE</option>
                                 <option value="PLAN">PLAN</option>
                                 <option value="TECH">TECH</option>
                                 <option value="PROD">PROD</option>
                              </select>
                           </div>
                           <div class="col-2">
                              <label>승인자명:</label> <select id="selectApproverName"
                                 class="custom-select">
                                 <option value="">사원명</option>
                              </select>
                           </div>
                           <div class="col-2">
                              <button id="showApproverList" class="btn btn-primary">조회</button>
                           </div>
                        </div>
                        <table id="myApproverTable" class="table table-hover mt-3">
                           <thead>
                              <tr>
                                 <th>번호</th>
                                 <th>결재유형</th>
                                 <th>결재내용</th>
                                 <th>결재단계</th>
                                 <th>결재상태</th>
                                 <th>결재등록일</th>
                                 <th>승인자팀명</th>
                                 <th>승인자명</th>
                                 <th>결재자명</th>
                                 <th>결재자팀명</th>
                              </tr>
                           </thead>
                           <tbody>
                           </tbody>
                        </table>
                     </div>
                  </div>
                  <!-- ========================================================================= -->
               </div>
               <%@include file="footer.jsp"%>
            </div>

         </div>

      </div>
</body>
   <!-- Bootstrap core JavaScript-->
   <script src="${path}/resources/vendor/jquery/jquery.min.js"></script>
   <script src="${path}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
   
   <!-- Core plugin JavaScript-->
   <script src="${path}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

   <!-- Custom scripts for all pages-->
   <script src="${path}/resources/js/sb-admin-2.min.js"></script>



   <!-- Page level custom scripts -->

   <script src="${path}/resources/js/demo/datatables-demo.js"></script>
   
      <script src="${path}/resources/vendor/datatables/jquery.dataTables.min.js"></script>
   <script src="${path}/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

   <!-- Page level custom scripts -->
   <script src="${path}/resources/js/demo/datatables-demo.js"></script>
</html>