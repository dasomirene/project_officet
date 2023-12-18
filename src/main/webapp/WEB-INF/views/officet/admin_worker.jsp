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
<script src="https://code.jquery.com/jquery-3.7.0.js"
	type="text/javascript"></script>
<script>
$(document).ready( function(){
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
   ////////////////////////////////
     //  -사원명 가져오기
       $("#selectTeam").on("change",function(){
         var team_name = this.value
         $.ajax({
            url:"${path}/getWorkerListByTeam2.do",
            type:'get',
            data:"team_name="+team_name,
            dataType:'json',
            success:function(workers){
            	console.log(workers);
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
       loadTeamList();
        $("#teamSelect").change(function () {
            var team_name = $(this).val();
            loadWorkerList(team_name);
        });
        
   ///////////////////////////////
   $("#detailBtn").hide()
          search()
   $("#schBtn").click(function(){
             search()
          })
    $("#regBtn").click(function(){
             $("#frm")[0].reset();
             $("#modalTitle").text("사원등록")
             $("#frm [name=worker_id]").attr("readonly",false)
                $("#workerRegBtn").show()
               $("#workerUptBtn").hide()
               $("#workerDelBtn").hide()            
          })
   $("#workerRegBtn").click(function(){
             if(confirm("사원정보를 등록하겠습니까?")){
                //alert($("#frm").serialize())
                // jobInsAjax2.do?job_id=ASS4&job_title=개발자4&min_salary=3500&max_salary=12000
                $.ajax({
                   url:"${path}/workerInsert.do",
                   type:"post",
                   data:$("#frm").serialize(),
                   dataType:"text",
                   success:function(data){
                      // 등록후 반영된 내용을 리스트하게
                      search();
                      // 폼에 있는 등록시 입력된 내용을 초기화할 때,
                      // 처리하는 form하위 요소객체 초기화
                      $("#frm")[0].reset();
                      search();
                      if(!confirm(data.replaceAll("\"", "")+"\n계속 등록하시겠습니까?")){
                         // 창을 닫게 처리 : 이벤트 강제 처리
                         $("#clsBtn").click();
                      }
                   },
                   error:function(err){
                      console.log(err)
                   }
                })                          
                      
             }
          })
          
    $("#workerUptBtn").click(function(){
             if(confirm("수정하시겠습니까?")){
                // updateJob.do?job_id=AC_MGR&job_title=Accountant&min_salary=9000&max_salary=18000
                // $("frm").serialize()   
                $.ajax({
                   url:"${path}/updateWorker.do",
                   type:"post",
                   data:$("#frm").serialize(),
                   dataType:"text",
                   success:function(data){
                      // 수정후 반영된 내용을 리스트하게
                      search();
                      if(!confirm(data.replaceAll("\"", "")+"\n계속 하시겠습니까?")){
                         // 창을 닫게 처리 : 이벤트 강제 처리
                         $("#clsBtn").click();
                      }
                   },
                   error:function(err){
                      console.log(err)
                   }
                })      
             }
          })
    
          $("#workerDelBtn").click(function(){
             if(confirm("삭제하시겠습니까?")){
                // deleteJob.do?job_id=AA_PP
                $.ajax({
                   url:"${path}/deleteWorker.do",
                   type:"post",
                   data:"worker_id="+$("#frm [name=worker_id]").val(),
                   dataType:"text",
                   success:function(data){
                      // 삭제후 반영된 내용을 리스트하게
                      search();
                      alert( data.replaceAll("\"", "") )
                      $("#clsBtn").click();
                      
                   },
                   error:function(err){
                      console.log(err)
                   }
                })                         
             }
          })          
          
       });
function loadTeamList() {
    $.ajax({
        url: "${path}/getTeamList2.do",
        type: "post",
        dataType: "json",
        success: function (data) {
            var teamSelect = $("#teamSelect");
            teamSelect.empty();
            teamSelect.append("<option value=''>전체팀</option>");
            $.each(data, function (index, team) {
                teamSelect.append("<option value='" + team.team_name + "'>" + team.team_name + "</option>");
            });
            // 페이지 로딩 시 첫 번째 팀을 선택하도록 설정
            loadWorkerList(teamSelect.val());
        },
        error: function () {
            alert("팀 목록을 가져오는데 실패했습니다.");
        }
    });
}
//팀원 선택시 나올 팀원 함수
function loadWorkerList(team_name) {
    $.ajax({
        url: "${path}/getWorkerListByTeam2.do",
        type: "post",
        data: { team_name: team_name },
        dataType: "json",
        success: function (data) {
            var workerSelect = $("#workerSelect");
            workerSelect.empty();
            workerSelect.append("<option value=''>전체사원</option>");
            // 객체나 배열로 받을떈 $.each
            $.each(data, function (index, worker) {
                workerSelect.append("<option value='" + worker.name + "'>" + worker.name + "</option>");
            });
        },
        error: function () {
            alert("팀원 목록을 가져오는데 실패했습니다.");
        }
    });
}          
    function search(){
      //alert( $("form").serialize() )
      $.ajax({
         type:"post",
         url:"${path}/workerListData.do",
         data:$("#schFrm").serialize(),
         dataType:"json",
         success:function(workers){
            //console.log(jobs)
            //job_id   job_title  min_salary max_salary
            var add = ""
               workers.forEach(function(worker){
               console.log(worker)
               add+="<tr  class='text-center' onclick='detail(\""+worker.worker_id+"\")' >"
               add+="<td>"+worker.worker_id+"</td>"
               add+="<td>"+worker.team_name+"</td>"
               add+="<td>"+worker.name+"</td>"
               add+="<td>"+worker.n_name+"</td>"
               add+="<td>"+worker.p_number+"</td>"
               add+="<td>"+worker.position_name+"</td>"
               add+="<td>"+worker.hire_date+"</td>"
               add+="<td>"+worker.sal+"</td>"
               add+="<td>"+worker.auth+"</td>"
               add+="</tr>"
            })
            console.log(add)
            $("#show").html(add);
         },
         error:function(err){
            console.log(err)
         }
      })                
   }
   function detail(worker_id){
      $("#detailBtn").click()
      $("#modalTitle").text("사원상세정보("+worker_id+")")
         $("#workerRegBtn").hide()
         $("#workerUptBtn").show()
         $("#workerDelBtn").show()  
         // ajax 처리..
         //getJob.do?job_id=AC_ACCOUNT
         /*
         success:function(job){
         $("#frm [name=job_title]").val(job.job_title);
         
         */
         $.ajax({
            url:"${path}/getWorker.do",
            type:"post",
            data:"worker_id="+worker_id,
            dataType:"json",
            success:function(worker){
             $("#frm [name=worker_id]").val(worker.worker_id);         
             $("#frm [name=team_id]").val(worker.team_id);         
             $("#frm [name=name]").val(worker.name);         
             $("#frm [name=n_name]").val(worker.n_name);
             $("#frm [name=pass]").val(worker.pass);
             $("#frm [name=p_number]").val(worker.p_number);
             $("#frm [name=position_name]").val(worker.position_name);       
             $("#frm [name=hire_dateS]").val(worker.hire_dateS);
             $("#frm [name=sal]").val(worker.sal);
             $("#frm [name=auth]").val(worker.auth);
             $("#frm [name=worker_id]").attr("worker_id",true)
            },
            error:function(err){
              console.log(err)
            }
         })
         
         
   }
   
   
   
   

</script>



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

</head>
<body id="page-top">

	<div id="wrapper">
		<%@ include file="sidebar.jsp"%>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@include file="topbar.jsp"%>
				<div class="container-fluid">
					<h2>사원관리</h2>
					<hr>
					<br>
					<div>
						<div class="container-fluid">
							<form method="post" id="schFrm" class="d-flex align-items-center">
								<!-- 팀명 select -->
								<label for="teamSelect">팀 선택:</label> <select id="teamSelect"
									name="team_name">


									<!-- Ajax로 팀 목록을 가져와서 동적으로 옵션을 채우기 위해 비워둡니다. -->
								</select>

								<!-- 사원명 select -->
								<label for="workerSelect">팀원 선택:</label> <select
									id="workerSelect" name="name">
								</select>

								<button id="schBtn" type="button" class="btn btn-primary"
									style="width: 100px;">조회</button>
								<button id="regBtn" type="button" class="btn btn-success"
									data-toggle="modal" data-target="#exampleModalCenter"
									style="width: 100px;">등록</button>
								<button id="detailBtn" type="button" class="btn btn-success"
									data-toggle="modal" data-target="#exampleModalCenter"></button>
							</form>
						</div>
						<br>
						<table class="table table-hover" style="background-color: white;">
							<thead>
								<tr class="text-center">
									<th>사원ID</th>
									<th>팀명</th>
									<th>이름</th>
									<th>닉네임</th>
									<th>전화번호</th>
									<th>직책명</th>
									<th>입사일</th>
									<th>급여</th>
									<th>권한</th>
								</tr>
							</thead>
							<tbody id="show">
								<tr class="text-center">
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
						<%@include file="footer.jsp"%>
					</div>
				</div>
			</div>
		</div>
		<!-- The Modal -->
		<div class="modal fade" id="exampleModalCenter" tabindex="-1"
			role="dialog" aria-labelledby="exampleModalCenterTitle"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modalTitle">사원 등록</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<!-- 
          -->
						<form id="frm" class="form" method="post">
							<div class="row">
								<div class="col">
									사원번호<input type="number" class="form-control"
										placeholder="사원번호 입력" name="worker_id"> <br>
								</div>
								<div class="col">
									팀ID<input type="number" class="form-control"
										placeholder=" 팀아이디입력" name="team_id"> <br>
								</div>
							</div>
							<div class="row">
								<div class="col">
									이름<input type="text" class="form-control" placeholder="이름 입력"
										name="name"> <br>
								</div>
								<div class="col">
									닉네임<input type="text" class="form-control" placeholder="닉네임 입력"
										name="n_name"> <br>
								</div>
							</div>
							<div class="row">
								<div class="col">
									비밀번호<input type="text" class="form-control"
										placeholder="비밀번호 입력" name="pass"> <br>
								</div>
								<div class="col">
									전화번호<input type="text" class="form-control"
										placeholder="전화번호 입력" name="p_number"> <br>
								</div>
							</div>
							<div class="row">
								<div class="col">
									직책명<input type="text" class="form-control" placeholder="직책명 입력"
										name="position_name"> <br>
								</div>
								<div class="col">
									입사일<input type=date class="form-control" placeholder="입사일 입력"
										name="hire_dateS"> <br>
								</div>
							</div>
							<div class="row">
								<div class="col">
									급여<input type="number" class="form-control" placeholder="급여 입력"
										name="sal"> <br>
								</div>
								<div class="col">
									권한<input type="text" class="form-control" placeholder="권한 입력"
										name="auth">

								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" id="workerRegBtn" class="btn btn-success">등록</button>
						<button type="button" id="workerUptBtn" class="btn btn-warning">수정</button>
						<button type="button" id="workerDelBtn" class="btn btn-danger">삭제</button>
						<button type="button" id="clsBtn" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
</body>

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
<style>
select {
	font-size: 16px;
	padding: 8px;
	margin-left: 3px;
	border: 1px solid #ccc;
	border-radius: 5px;
	width: 200px;
}

tr, td {
	color: black;
}
</style>
</html>