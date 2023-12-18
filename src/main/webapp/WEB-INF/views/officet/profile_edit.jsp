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
<script src = "https://code.jquery.com/jquery-3.7.0.js" type="text/javascript"></script>
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
<script type="text/javascript">
   function edit_check(){
      var n_name = $('#n_name').val()
      var p_number = $('#p_number').val()
      var region = $('#region').val()
      if(n_name ==""){
         alert("닉네임을 입력하세요.")
         $('#n_name').focus();
      }else if(p_number ==""){
         alert("전화번호를 입력하세요.")  
         $('#p_number').focus();
      }else if(region==""){
         alert("지역을 입력하세요.")
         $('#region').focus();
      }else{
         edit();
      }
   }
   function edit(){
	    var formData = new FormData($('#frm')[0]);
	    
	    $.ajax({
	      type: "POST",
	      url: "${path}/try/profile_edit.do",
	      data: formData,
	      processData: false,
	      contentType: false,
	      success: function (msg) {
	        // 서버에서 반환한 응답을 처리
	        if (msg == "Y") {
	          alert("사원정보 수정이 완료되었습니다.");
	          location.href = "${path}/profile.do";
	        } else {
	          alert("수정 실패");
	        }
	      },
	      error: function (err) {
	        console.log(err);
	        alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
	      }
	    })
   }
</script>
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
   
});
</script>
</head>
<body id="page-top">

   <div id="wrapper">
      <%@ include file="sidebar.jsp" %>
      <div id="content-wrapper" class="d-flex flex-column">
         <div id="content">
            <%@include file="topbar.jsp" %>
            <div class="container-fluid">
            
            <h2 class="mr-auto ml-md-3 my-2 my-md-0 mw-100 pb-3">프로필 수정</h2>
            <div class="container mt-3">
                  <div class="card d-none d-sm-block" style="width:300px">
                  <img class="card-img" src="${path}/image/${worker.fname}" alt="Card image" style="width:100%">
                  <div class="card-body d-none d-sm-inline-block">
                     <h4 class="card-title">${worker.name} (${worker.position_name})</h4>
                  </div>
                  </div>
                  <form id="frm" method="post" enctype="multipart/form-data">
                  <input type="file" class="form-control me-2" id="report" placeholder="파일선택" value="${param.report}" name="report" multiple="multiple">
                  <div class="d-none d-sm-block mr-auto ml-md-3 my-2 my-md-0 mw-100" style="width:400px">
                     <div class="card-body">
                        <input type="hidden" id="worker_id" name="worker_id" value="${worker.worker_id}"/>
                        <p class="card-text">📛닉네임 :<input type="text" id="n_name" name="n_name" class="card-text" value="${worker.n_name}"/></p>
                        <p class="card-text">🚩소속팀 :<input type="text" id="team_name" class="card-text" value="${worker.team_name}" readonly/></p>
                        <p class="card-text">📞전화번호 :<input type="text" name="p_number" id="p_number" class="card-text" value="${worker.p_number}"/></p>
                        <p class="card-text">📅입사일 :<input type="text" id="hire_date" class="card-text" value="${worker.hire_dateS}" readonly/></p>
                        <p class="card-text">💲급여 :<input type="text" id="sal" class="card-text" value="${worker.sal}만원" readonly/></p>
                        <p class="card-text">📍지역 : <input type="text" name="region" id="region" class="card-text" value="${worker.region}"/></p>
                        <button type="submit" onclick="edit_check()" href="profile_edit.do" class="btn btn-primary">수정 완료 ✔</button>
                     </div>
                  </div>
                  </form>
            </div>
            <%@include file="footer.jsp" %>
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