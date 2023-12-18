<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<script src="https://code.jquery.com/jquery-3.7.0.js"
   type="text/javascript"></script>
<title>오피셋 로그인</title>

<!-- Custom fonts for this template-->
<link href="${path}/resources/vendor/fontawesome-free/css/all.min.css"
   rel="stylesheet" type="text/css">
<link
   href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
   rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/resources/css/sb-admin-2.min.css" rel="stylesheet">
<style>
	input::-webkit-outer-spin-button,
	input::-webkit-inner-spin-button {
  	-webkit-appearance: none;
  	margin: 0;
}
</style>
<script type="text/javascript">
	$(document).ready( function(){
		
		// inputid 숫자만 입력 가능
		$('#inputid').on('keyup', function () {
		    $(this).val($(this).val().replace(/[^0-9]/g, ""));
		});
		
		// 엔터키 입력시 로그인
		$("#inputpass").keypress(function(e){
			if(e.keyCode && e.keyCode ==13){
				$("#loginBtn").click()
			}
		})
	})
	
	// 로그인 기능 유효성 확인
   	function login_check() {
      var inputid = $('#inputid').val()
      console.log('type of inputid>>>>>>'+typeof(inputid))
      var inputpass = $('#inputpass').val()
      if (inputid == "") {
         if (inputpass == "") {
            alert('사원번호와 비밀번호를 입력하세요')
         } else {
            alert('사원번호를 입력하세요')
         }
      } else if (inputpass == "") {
         alert('비밀번호를 입력하세요')
      } else {
         login();
      }
   }
	
	// 로그인 기능
   function login() {
      var worker_id = $('#inputid').val()
      var pass = $('#inputpass').val()
     	 $.ajax({
               type : "post",
               url : "${path}/loginCheck.do",
               data : "worker_id=" + worker_id + "&pass=" + pass,
               dataType : "text",
               success : function(data) {
                 // alert('돌려받은 값>>>>>' + data + '${userInfo.name}')
                  if (data == "\"false\"") {
                     alert('잘못된 사원번호 이거나, 비밀번호가 틀렸습니다')
                  } else {
                     //alert('로그인 성공 : '+data)
                     location.href = "${path}/main.do"
                  }
               },
               error : function(e) {
                  alert('서버 오류입니다' + e.status)
               }

            })
   }
	
	// 전화번호 입력 자동 하이픈
   const autoHyphen2 = (target) => {
       target.value = target.value
        .replace(/[^0-9]/g, '')
        .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3")
        .replace(/(\-{1,2})$/g, "");
   }
       
   
</script>
</head>

<body style="background-color: #9747FF">

   <div class="container">

      <!-- Outer Row -->
      <div class="row justify-content-center">

         <div class="col-xl-10 col-lg-12 col-md-9">

            <div class="card o-hidden border-0 shadow-lg my-5">
               <div class="card-body p-0">
                  <!-- Nested Row within Card Body -->
                  <div class="row">
                     <div class="col-lg-6 d-none d-lg-block"
                        style="diplay: flex; background-color: #9747FF">
                        <img src="${path}/resources/img/officet_logo.png"
                           style="width: 100%; margin-top: 15px;" />
                     </div>
                     <div class="col-lg-6">
                        <div class="p-5">
                           <div class="text-center"></div>
                           <form class="user" method="post">
                              <div class="form-group">
                                 <input type="number" class="form-control form-control-user"
                                    id="inputid" placeholder="사원번호 입력">
                              </div>
                              <div class="form-group">
                                 <input type="password" class="form-control form-control-user"
                                    id="inputpass" placeholder="비밀번호">
                              </div>
                              <div class="form-group"></div>
                              <button type="button" onclick="login_check()"
                                 class="btn btn-primary btn-user btn-block" id="loginBtn">
                                 로그인</button>

                           </form>
                           <hr>
                           <div class="text-center">
                              <a class="small" data-toggle="modal" data-target="#findWorkerIdModal">사원번호
                                 찾기</a>

                           </div>
                           <div class="text-center">
                              <a class="small" data-toggle="modal" data-target="#resetPassModal">비밀번호 재설정</a>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>

         </div>

      </div>

   </div>
   <script type="text/javascript">
    $(document).ready(function(){
       $("#uptPass2").hide()
       $("#uptPass").click(function(){
          var p_number = $("#p_number").val();
          var p_numberS= p_number.split("-").join('');
          //var p_numberS = p_nArr.join('');
          var worker_id = $("#worker_id").val();
          $.ajax({
            url:"${path}/checkWorker.do",
            type:"post",
            data:"worker_id="+worker_id+"&p_number="+p_numberS,
            dataType:"json",
            success:function(w){
               console.log(w)
               if(w=="N"){
                  console.log(worker_id)
                  console.log(p_number)
                  console.log(p_numberS)
                  alert("입력된 정보와 일치하는 사원이 없습니다.")
               }else{
                  alert("회원 인증이 필요합니다.")
                  auth(w)
               }
            },
            error:function(err){
               console.log(err)
            }
          })
          
       })
       function auth(id){
          var ranStr = Math.random().toString(36).substring(2, 12);
          var ans = prompt("다음 인증번호를 입력하세요: " + ranStr)
          if(ans==ranStr){
             alert("비밀번호를 재설정합니다.")
             $("#worker_id").hide()
             $("#p_number").hide()
             $("#uptPass").hide()
             $("#newPass").show()
             $("#newPass").attr("type","password")
             $("#rePass").show()
             $("#rePass").attr("type","password")
             $("#uptPass2").show()
          }else{
             alert("인증번호가 일치하지 않습니다.")
            auth();
          }
       }
       $("#uptPass2").click(function(){
         var newPass = $("#newPass").val()
         var rePass = $("#rePass").val()
         if(newPass == rePass){
            $.ajax({
               url:"${path}/uptPass.do",
               type:"post",
               data:$("#uptPassForm").serialize(),
               dataType:"json",
               success:function(w){
                  console.log(w)
                  if(w=="success"){
                     alert("비밀번호가 변경되었습니다.")
                     document.getElementById('closeUptModal').click();
                     $("#worker_id").show()
                      $("#p_number").show()
                      $("#uptPass").show()
                      $("#newPass").hide()
                      $("#newPass").attr("type","hidden")
                      $("#rePass").hide()
                      $("#rePass").attr("type","hidden")
                      $("#uptPass2").hide()
                  }else{
                     alert("비밀번호 변경 실패")
                  }
               },
               error:function(err){
                  console.log(err)
               }
            })
         }else{
            alert("비밀번호가 일치하지 않습니다.")
            $("#newPass").val("").focus()
            $("#rePass").val("")
         }
       })
   });
    
    </script>
   <!-- 모달창  -->
   <div class="modal fade" id="resetPassModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">비밀번호 재설정</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <form  id="uptPassForm" class="form" method="post">
                <div class="modal-body">
                   <input type="text" id="worker_id" name="worker_id" class="form-control form-control-user"
                      placeholder="사원번호 입력"/>
                   <input type="text" id="p_number" name="p_number" class="form-control form-control-user mt-3"
                      placeholder="전화번호 입력" maxlength="13" oninput="autoHyphen2(this)"/>
                   <input type="hidden" id="newPass" name="pass" class="form-control form-control-user mt-3"
                      placeholder="비밀번호 입력"/>
                   <input type="hidden" id="rePass" class="form-control form-control-user mt-3"
                      placeholder="비밀번호 재입력"/>
                </div>
                </form>
                <div class="modal-footer">
                    <button id="closeUptModal" class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <button  id="uptPass" type="button" class="btn btn-primary" href="login.html">찾기</button>
                    <button  id="uptPass2" type="button" class="btn btn-primary" href="login.html">비밀번호 재설정</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    $(document).ready(function(){
       $("#findId").click(function(){
          $.ajax({
            url:"${path}/findId.do",
            type:"post",
            data:$("#findIdForm").serialize(),
            dataType:"json",
            success:function(id){
               console.log(id)
               if(id==""){
                  alert("입력된 정보와 일치하는 사원 id가 없습니다.")
               }else{
                  alert("회원 인증이 필요합니다.")
                  auth(id)
               }
            },
            error:function(err){
               console.log(err)
            }
          })
          
       })
       function auth(id){
          var ranStr = Math.random().toString(36).substring(2, 12);
          var ans = prompt("다음 인증번호를 입력하세요: " + ranStr)
          if(ans==ranStr){
             alert("사원id: " + id)
             $("#inputid").val(id)
             document.getElementById('closeFindModal').click();
          }else{
             alert("인증번호가 일치하지 않습니다.")
            auth();
          }
       }
   });
    
    </script>
    <div class="modal fade" id="findWorkerIdModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">사원번호 찾기</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
               <form  id="findIdForm"   class="form"  method="post">
                    <div class="row">
                     <div class="col">         
                       이름<input type="text" class="form-control" 
                          placeholder="이름 입력" id="name" name="name">
                          <br>
                     </div>
                     <div class="col">
                       전화번호<input type="text" class="form-control"
                           placeholder=" 전화번호 입력" id="p_number" name="p_number">
                           <br>
                     </div>
                    </div>
                </form>
            </div>
                <div class="modal-footer">
                    <button id= "closeFindModal" class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                    <button id="findId" type="button" class="btn btn-primary">찾기</button>
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

</body>

</html>