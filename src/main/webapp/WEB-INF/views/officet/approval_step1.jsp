<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />
   <tbody class="modal-trigger">
      <c:forEach var="approval1" items="${approvalInfo1}">
      <tr class="rowId">
      <td>${approval1.approval_id}</td>
      <td>${approval1.team_name}</td>
      <td>${approval1.worker_name}</td>
      <td>${approval1.approver_name}</td>
      <td>${approval1.step_name} </td>
      <td>
          <fmt:formatDate type="both" 
         dateStyle="short"
         timeStyle="short"
         value="${approval1.approval_request_time}"/>
     </td> 
      <td>               
      <c:choose>
       <c:when test="${approval1.approval_status eq 0}">
           보류
       </c:when>
       <c:when test="${approval1.approval_status eq 1}">
           승인
       </c:when>
       <c:when test="${approval1.approval_status eq 2}">
           반려
       </c:when>
       <c:otherwise>
           잘못된 값입니다.
       </c:otherwise>
      </c:choose>
      </td>
      <td>${approval1.approval_type}</td>
      <td>${approval1.approval_msg}</td>
      </tr>
      </c:forEach>        
   </tbody>
</table>