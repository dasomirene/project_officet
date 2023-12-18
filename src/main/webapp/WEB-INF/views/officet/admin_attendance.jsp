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
<script src = "https://code.jquery.com/jquery-3.7.0.js" type="text/javascript"></script>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready( function(){
   
   
   
   // 출퇴근 버튼
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
   
   // 팀명 가져오기   
    $.ajax({
        url: "${path}/getTeamList.do",
        type: "post",
        dataType: "json",
        success: function (data) {
            var teamSelect = $("#teamSelect");
            teamSelect.empty();
            teamSelect.append("<option value=''>팀명</option>");
            $.each(data, function (index, team) {
                teamSelect.append("<option value='" + team.team_name + "'>" + team.team_name + "</option>");
            });

            /* loadWorkerList(); */
        },
        error: function () {
            alert("팀 목록을 가져오는데 실패했습니다.");
        }
    });
     
   // 팀원명 가져오기
       $("#teamSelect").on("change",function(){
         var team_name = this.value
         $.ajax({
            url:"${path}/getTeamWorker.do",
            type:'get',
            data:"team_name="+team_name,
            dataType:'json',
            success:function(workers){
               $("#selectWorker").empty()
               $("#selectWorker").append("<option value=''>사원명</option>")
               for(var i in workers){
                  $("#selectWorker").append(
                        "<option value="+workers[i]+">"+workers[i]+"</option>")
               }
            },
            error:function(e){
               console.log(e.status+'에러 입니다')
            }
         })
      })
      
      $("#attSch").click(function(){
         search()
      })
      
      $("#attReg").click(function(){
         $('#attModal').modal('show');
         $("#modalFrm")[0].reset();
         $("#modalTitle").text("근태 등록")
         $("#uptBtn").hide()
         $("#regBtn").show()
      })
      
      
      
      // 검색 및 조회
      function search(){
         var team_name = $("#teamSelect").val()
         var name = $("#selectWorker").val()
         var check_in_status = $("#check_in_status").val()
         var check_out_status = $("#check_out_status").val()
         var attObj = {"team_name":team_name, "name":name,
                     "check_in_status":check_in_status, "check_out_status":check_out_status}
         console.log("검색탭 데이터 >>>>"+team_name)
         console.log("검색탭 데이터 >>>>"+name)
         console.log("검색탭 데이터 >>>>"+check_in_status)
         console.log("검색탭 데이터 >>>>"+check_out_status)
         console.log("json 데이터 >>>>>>"+JSON.stringify(attObj))
         $.ajax({
            url:"${path}/admin_attendance_sch.do",
            type:"get",
            data :"team_name="+team_name+"&name="+name+"&check_in_status="
                  +check_in_status+"&check_out_status="+check_out_status,
            contentType: "application/json; charset:UTF-8",
            dataType:"json",
            success:function(data){
               var add=""
                  $.each(data, function(index, att){
                     if(att.check_in_time==null) att.check_in_time=""
                        if(att.check_out_time==null) att.check_out_time=""
                          add+="<tr onclick='attDetail("+att.attendance_id+")'>"
                          add+="<td>"+att.attendance_id+"</td>"
                          add+="<td>"+att.name+"</td>"
                          add+="<td>"+att.team_name+"</td>"
                          add+="<td>"+att.today_date+"</td>"
                          add+="<td>"+att.check_in_time+"</td>"
                          add+="<td>"+att.check_in_status+"</td>"
                          add+="<td>"+att.check_out_time+"</td>"
                          add+="<td>"+att.check_out_status+"</td>"
                          add+="</tr>"                       
               })
               $("#attShow").html(add)
            },
            error:function(e){
               alert(e.status+"상태 에러입니다")
            }
         })
      }
   
   
       $("#attSch").click()
   
   

   
   
   
});
// 디테일 더블클릭 로딩
function attDetail(attendance_id){
   $("#attReg").click()
   $("#modalTitle").text("결재 정보 수정")
   $("#uptBtn").show()
   $("#regBtn").hide()
   $.ajax({
       url:"${path}/admin_attendance_detail.do",
       type:"post",
       data:"attendance_id="+attendance_id,
       dataType:"json",
       success:function(att){
          $("#modalFrm [name=attendance_id]").val(att.attendance_id);
          $("#modalFrm [name=attendance_id]").attr("readonly",true);
          $("#modalFrm [name=today_date]").val(att.today_date);         
          $("#modalFrm [name=today_date]").attr("readonly",true);         
          $("#modalFrm [name=team_name]").val(att.team_name);         
          $("#modalFrm [name=team_name]").attr("readonly",true);      
          $("#modalFrm [name=name]").val(att.name);
          $("#modalFrm [name=name]").attr("readonly",true);
          $("#modalFrm [name=check_in_time]").val(att.check_in_time)
          $("#modalFrm [name=check_in_time]").attr("readonly",true);
          $("#modalFrm [name=check_in_status]").val(att.check_in_status)
          $("#modalFrm [name=check_out_time]").val(att.check_out_time)
          $("#modalFrm [name=check_out_time]").attr("readonly",true);
          $("#modalFrm [name=check_out_status]").val(att.check_out_status)
       },
       error:function(err){
          console.log(err)
       }
    })
}
</script>
</head>
<body id="page-top">

   <div id="wrapper">
      <%@ include file="sidebar.jsp"%>
      <div id="content-wrapper" class="d-flex flex-column">
         <div id="content">
            <%@include file="topbar.jsp"%>
            <div class="container-fluid">
               <h2>근태관리</h2>
               <hr>
               <br>
               <form id="schFrm" method="post" >
               <div>
                  <select id="teamSelect" name="team_name">
                     <option value=''>팀원명</option>
                  </select>
                  <select id="selectWorker" name="name">
                      <option value=''>사원명</option>
                  </select>
                  <select id="check_in_status" name="check_in_status">
                     <option value="">출근상태</option>
                     <option value="정상출근" >정상출근</option>
                     <option value="지각">지각</option>
                     <option value="결근">결근</option>
                     <option value="병가">병가</option>
                     <option value="휴가">휴가</option>
                  </select>
                  <select id="check_out_status" name="check_out_status">
                     <option value="">퇴근상태</option>
                     <option value="정상퇴근">정상퇴근</option>
                     <option value="조퇴">조퇴</option>
                     <option value="결근">결근</option>
                     <option value="병가">병가</option>
                     <option value="휴가">휴가</option>
                  </select>
                  <button id="attSch" type="button" class="btn btn-warning ml-2">조회</button>
                  <button id="attReg" type="button" class="btn btn-success ml-2">등록</button>
               </div>
               
               </form>
               <br>
               <table class="table table-hover text-center" style="background-color: white;">
                  <thead>
                     <tr >
                        <th>출결ID</th>
                        <th>사원명</th>
                        <th>팀명</th>
                        <th>날짜</th>
                        <th>출근시간</th>
                        <th>출근상태</th>
                        <th>퇴근시간</th>
                        <th>퇴근상태</th>
                     </tr>
                  </thead>
                  <tbody class="modal-trigger" id="attShow">
                     <tr>
                        <td>출결ID</td>
                        <td>사원명</td>
                        <td>팀명</td>
                        <td>날짜</td>
                        <td>출근시간</td>
                        <td>출근상태</td>
                        <td>퇴근시간</td>
                        <td>퇴근상태</td>
                     </tr>
                  </tbody>
               </table>
               <%@include file="footer.jsp"%>
            </div>
         </div>
      </div>
   </div>
   <!-- The Modal -->
   <div class="modal fade" id="attModal">
      <div class="modal-dialog">
         <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
               <h4 class="modal-title" id="modalTitle">근태 수정</h4>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
               <form id="modalFrm" >
                  <div class="modal-body">
                     <div class="mb-3 mt-3">
                        <div class=" row d-flex flex-direction-column justify-content-center">
                              <input name="attendance_id"  id="attendance_id" class="col-sm-4 form-control mt-2 ml-2" type="text" placeholder="출결ID"/>
                              <input name="today_date" class="col-sm-4 form-control mt-2 ml-2" type="text" placeholder="날짜"><br>
                              <input name="team_name"  class="col-sm-4 form-control mt-2 ml-2" type="text" placeholder="팀명">
                              <input name="name"  class="col-sm-4 form-control mt-2 ml-2" type="text" placeholder="사원명">
                              <input name="check_in_time"  class="col-sm-4 form-control mt-2 ml-2" type="text" placeholder="출근시간">
                              <input name="check_in_status"  class="col-sm-4 form-control mt-2 ml-2" type="text" placeholder="출근상태">
                              <input name="check_out_time"  class="col-sm-4 form-control mt-2 ml-2" type="text" placeholder="퇴근시간">
                              <input name="check_out_status"  class="col-sm-4 form-control mt-2 ml-2" type="text" placeholder="퇴근상태">
                        </div>
                     </div>
                  </div>
               </form>
            </div>
   
            <!-- Modal footer -->
            <div class="modal-footer">
               <button id="uptBtn" type="button" class="btn btn-success"
                  >수정</button>
               <button id="regBtn" type="button" class="btn btn-primary"
                  >등록</button>
               
            </div>
         </div>
      </div>
   </div>
      <script>
         /* $(document).ready(function() {
            $('.modal-trigger').on('dblclick', function() {
               $('#attModal').modal('show');
            });
         }); */
         $("#uptBtn").click(function() {
            if (confirm("수정하시겠습니까?")) {
               alert("수정이 완료되었습니다");
            }
         });
      </script>
</body>

<!-- Bootstrap core JavaScript-->
<script src="${path}/resources/vendor/jquery/jquery.min.js"></script>
<script   src="${path}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script   src="${path}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="${path}/resources/js/sb-admin-2.min.js"></script>



<!-- Page level custom scripts -->

<script src="${path}/resources/js/demo/datatables-demo.js"></script>

<script   src="${path}/resources/vendor/datatables/jquery.dataTables.min.js"></script>
<script   src="${path}/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="${path}/resources/js/demo/datatables-demo.js"></script>
<style>
select {
   font-size: 16px;
   padding: 8px;
   margin-left: 3px;
   border: 1px solid #ccc;
   border-radius: 5px;
   width: 200px;
}
tr,td{color:b}
</style>
</html>