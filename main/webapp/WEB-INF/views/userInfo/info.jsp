<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>개인정보</title>
<!-- 상단 인클루드 -->
<!-- 목록 
사용자 - 개인정보, 설정
수강 과목  - 수강친청 연결, 과목리스트, 과목당 출석여부
성적  - 과목리스트 ->과목별 성적 출력 , 전체성적
-->
<%@ include file="/resources/include/top.jsp"%>

<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->

<jsp:include page="/resources/include/leftmenu_userInfo.jsp"/><!-- flag구분예정 -->

	<table class="table table-bordered table-hover table-striped" style="text-align:center;">
	<div style="text-align: center;">
      <small style="font-size:1.2em"><i class="	fas fa-user-alt" id="icon">&nbsp&nbsp</i>개인 정보</small>
    </div>
    <hr />
    	<c:choose >	
			<c:when test="${empty lists }">
		 		<tr>
 					<td colspan="4" align="center" height="100">
 						개인정보가 없습니다.
 					</td>
 				</tr>
			</c:when>
			<c:otherwise >
				<c:forEach items="${lists }" var="row">
					<tr>
						<td>학번</td>
						<td>${row.user_id }</td>
						<td>소속</td>
						<td>${row.orga_name }</td>
					</tr>
					<tr>
						<td>성명</td>
						<td>${row.user_name }</td>
						<td>전화번호</td>
						<td>${row.phone_num }</td>
					</tr>
					<tr>
						<td colspan="1">이메일</td>
						<td colspan="3">${row.email }</td>
					</tr>
				</c:forEach>	
			</c:otherwise>	
		</c:choose>
    </table>
<!---------------------------------------------------   -->
    
    <table class="table  table-hover table-striped" >
		<div style="text-align: center;">
	    	<small>사용자 설정</small>
	    </div>

	 <%--    
	    <form:form name="writeFrm" method="post" 
			action="./notiSetting.do" >
		<tr>
			<td>공지 알림 설정</td>
			<td>
				<input type="radio" name="user_set" value="on" checked/>
				<input type="radio" name="user_set" value="off" />
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<ul class="actions">
				<li><input type="submit" value="전송하기" class="primary" /></li>
			</ul>
			</td>
		</tr>
		</form:form>
		
		<form:form name="writeFrm" method="post" 
			action="./examSetting.do" >
		<tr>
			<td>과제 알림 설정</td>
			<td>
				<input type="radio" name="user_set" value="on" checked/>
				<input type="radio" name="user_set" value="off" />
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<ul class="actions">
				<li><input type="submit" value="전송하기" class="primary" /></li>
			</ul>
			</td>
		</tr>
		</form:form> --%>

		
		<table class="alt" style="text-align:center">
		<h5>차단 유저 관리</h5>
		<c:choose>	
			<c:when test="${empty lists2 }">
 				<tr>
 					<td colspan="6" align="center" height="100px" >
 						차단된 유저가 없습니다 
 					</td>
 				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${lists2 }" var="row">
					<tr>
						<td>${row.block_nick }</td>
						<td style="width:5%">
						<a href="blockDelete.do?block_user=${row.block_user }">
						<i class="fas fa-times"></i>
						</a>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>	
		</c:choose>
		</table>
		
    </table>
    
<!-------------------------------------------------------> 
   <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>