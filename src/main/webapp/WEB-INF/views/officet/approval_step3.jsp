<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8" />
<c:set var="path" value="${pageContext.request.contextPath}" />
   <tbody class="modal-trigger">
      <c:forEach var="approval3" items="${approvalInfo3}">
      <tr class="rowId">
      <td>${approval3.approval_id}</td>
      <td>${approval3.team_name}</td>
      <td>${approval3.worker_name}</td>
      <td>${approval3.approver_name}</td>
      <td>               
      <c:choose>
       <c:when test="${approval3.approval_step eq 0}">
           1차 결재
       </c:when>
       <c:when test="${approval3.approval_step eq 1}">
           2차 결재
       </c:when>
       <c:when test="${approval3.approval_step eq 2}">
           완료
       </c:when>
       <c:otherwise>
           잘못된 값입니다.
       </c:otherwise>
      </c:choose>
      </td>            
      <td><fmt:formatDate type="both" 
         dateStyle="short"
         timeStyle="short"
         value="${approval3.approval_request_time}"/>
     </td>
      <td>               
      <c:choose>
       <c:when test="${approval3.approval_status eq 0}">
           보류
       </c:when>
       <c:when test="${approval3.approval_status eq 1}">
           승인
       </c:when>
       <c:when test="${approval3.approval_status eq 2}">
           반려
       </c:when>
       <c:otherwise>
           잘못된 값입니다.
       </c:otherwise>
      </c:choose>
      </td>
      </tr>
      </c:forEach>            
   </tbody>
</table>