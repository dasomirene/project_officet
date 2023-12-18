<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js" type="text/javascript"></script>
<script>
$(document).ready(function() {
    loadApproverList();
    $.ajax({
        url: "${path}/checkAtt.do",
        type: "get",
        data: "worker_id=" + ${worker_id},
        dataType: "json",
        success: function(data) {
            // alert('성공!'+data.check_out+' '+data.check_in)
            if (data.check_in) {
                $('#arrvlBtn').attr("disabled", true);
            }
            if (data.check_out) {
                $('#leaveBtn').attr("disabled", true);
            }
        },
        error: function(err) {
            console.log(err);
        }
    });

    $("#regBtn").click(function () {
        if (confirm("등록하시겠습니까?")) {
            var selectedApproverId = $("#approver_List option:selected").val();
            var workerId = $("#author").val();
            var approvalType = $("#approval_type").val(); 
            var approvalMsg = $("#approval_msg").val(); 

            $.ajax({
                url: "${path}/getInsertReq.do",
                type: "post",
                data: {
                    "worker_id": workerId,
                    "approver_id": selectedApproverId,
                    "approval_type": approvalType, 
                    "approval_msg": approvalMsg, 
                },
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    alert("등록이 완료되었습니다");
                    location.reload();
                },
                error: function (err) {
                    console.log(err);
                    alert("등록이 실패하었습니다");
                },
            });
        }
    });
    function loadApproverList() {
        $.ajax({
            url: "${path}/selectApprover.do",
            type: "post",
            dataType: "json",
            success: function(data) {
                var apList = $("#approver_List");
                apList.empty();
                $.each(data, function(index, ap) {
                    apList.append("<option value='" + ap.approver_id + "'>" 
                          + ap.worker_name + "</option>");
                });
            },
            error: function(err) {
                alert("승인자 목록을 가져오는데 실패했습니다.");
                console.log(err);
            }
        });
    }
});

</script>

<title>오피셋</title>

<!-- Custom fonts for this template-->
<link href="${path}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<script src="https://kit.fontawesome.com/44ab4b04c0.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
    rel="stylesheet">

<!-- Custom styles for this template-->
<link href="${path}/resources/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body id="page-top">

<div id="wrapper">
    <%@ include file="sidebar.jsp" %>
    <div id="content-wrapper" class="d-flex flex-column">
        <div id="content">
            <%@include file="topbar.jsp" %>
            <div class="container-fluid">
                <div class="container mt-4">
                    <h2 class="mb-4">결재 요청</h2>
                    <hr>
                    <form id="insForm">
                        <div class="mb-3">
                            <label for="author" class="form-label">사원번호</label>
                            <input type="text" class="form-control" id="author" value="${worker_id}" disabled>
                        </div>
                        <div class="mb-3">
                            <label for="author" class="form-label">승인자</label>
                            <select class="form-control" id="approver_List">
                                <option value="" disabled selected>승인자를 선택하세요</option>
                            </select>

                        </div>

                        <div class="mb-3">
                            <label for="title" class="form-label">결재 유형</label>
                  <select class="form-select form-select-sm" id="approval_type">
                      <option value="">선택해주세요</option>
                      <option value="업무">업무</option>
                      <option value="휴가">휴가</option>
                      <option value="반차">반차</option>
                  </select>
                        </div>
                  <div class="mb-3">
                      <label for="title" class="form-label">결재 내용</label>
                      <textarea class="form-control ckValid" id="approval_msg" placeholder="내용 입력" required rows="5"></textarea>
                      <div class="invalid-feedback">
                          내용를 입력해주세요.
                      </div>
                  </div>
                  <button id="regBtn" type="button" class="btn btn-primary">작성</button>
                    </form>
                </div>
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
</html>