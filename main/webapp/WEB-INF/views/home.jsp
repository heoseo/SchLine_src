<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   

<!--
2021.02.02
1) ★★★인클루드 메뉴바 링크는 각자 넣어주세요!!!★★
2) ★★★각 view페이지 smail태그 안에있는 타이틀 일단 주석처리 해주세요(깔끔하게 스타일 변경)
 -->

<!DOCTYPE html>
<html>
	<head>
		<title>스쿨라인 메인</title>

<%@ include file="/resources/include/top.jsp" %>
<%-- <form:form method="post" action="${pageContext.request.contextPath }" > --%>
<%-- 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
<!-- 	<input type="submit" value="로그아웃" /> -->
<%-- </form:form> --%>
<style type="text/css">
#loginButton{
	width: 100%;
	text-align: center;
	border-radius:5px;
	color: white;
	box-shadow: 2px 2px 2px;
}
#loginButton button:hover {
	background:e8e8e8;
	opacity: 0.8;
}
body{
	padding: 15%;
	padding-top: 10%;
	padding-bottom: 5%;
}
#main{
	box-shadow: 5px 5px 5px;
}
</style>
<!-- /////////////////////Main시작////////////////////// -->
<body class="is-preload" data-spy="scroll" data-target="#myScrollspy" data-offset="1" style="
padding: 5%; padding-left: 25%; padding-right: 25%; padding-top: 8%">

	<div id="main" style="border-radius: 10px; vertical-align: middle;">

		<div style="text-align: center; background:#44A9C5; 
		 padding-bottom: 10px; padding-top: 10px;" >
			<img src="<%=request.getContextPath() %>/resources/images/logo.png" width="200px" alt="스쿨라인 로고"  class="img-circle" />
		</div>
		<div style="padding: 20px 40px 10px 40px">
		<c:choose>
			<c:when test="${not empty user_id }">
				${user_id}님, 하이룽~^^*
				
				<form:form method="post"
						action="${pageContext.request.contextPath }/security2/logout">
						
						<input type="submit" value="로그아웃" />
				</form:form>
			</c:when>
			<c:otherwise>
				<!-- security-context2에서  login-processing-url="/loginAction" 를 안쓸땐
					default로 /login으로 지정되므로  아래와같이 value="/login"으로 한다.
	<%-- 			<c:url value="/login" var="loginUrl"/> --%>
				-->
				<c:url value="/login" var="loginUrl"/>
				<form:form name="loginFrm" action="${loginUrl }" method="post">
					<c:if test="${param.error != null }">
						<p>아이디와 패스워드가 잘못되었습니다.</p>
					</c:if>
					<c:if test="${param.login != null }">
						<p>로그아웃 하였습니다.</p>
					</c:if>
					
					<div>
					</div>&nbsp;
					<!-- 아이디, 패스워드의 name은 security-context2의 어쩌구와 같아야한다. -->
					<p>
						<span style="font-size: 16px;">로그인</span>
						<br />
						<span style="font-size: 0.8em; color: gray;" width="25px">아이디</span> 
						<input type="text" name="id" value="201701700">
						<span style="padding-bottom: 10px; font-size: 0.8em; color: gray; ">비밀번호</span> 
						<input type="password" name="pass" value="qwer1234">
					<div style="border-radius:5px; background:#44A9C5; color: white;" class="loginButton">				
						<button type="submit" id="loginButton" style="font-weight:bold; border: 1px solid;">
							로그인</button>
					</div>
					</p>
				</form:form>
			</c:otherwise>
		</c:choose>
		</div>
		
	</div>
		
	<!-- /////////////////////메인끝////////////////////// -->
</body>

</html>