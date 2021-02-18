<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>   

<!--
2021.02.02
1) ★★★인클루드 메뉴바 링크는 각자 넣어주세요!!!★★
2) ★★★각 view페이지 smail태그 안에있는 타이틀 일단 주석처리 해주세요(깔끔하게 스타일 변경)
 -->``

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
	background:#ADD8E6; 
	border-radius:5px;
}
</style>
<!-- /////////////////////Main시작////////////////////// -->
<body class="is-preload" data-spy="scroll" data-target="#myScrollspy" data-offset="1" >
	<div style="text-align: center;">
		<img src="<%=request.getContextPath() %>/resources/images/logo.png" width="400px" alt="스쿨라인 로고" />
	</div>
	<hr />
	<div id="main" style=" font-weight:bold; padding:30px">
	
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
				
				<!-- 아이디, 패스워드의 name은 security-context2의 어쩌구와 같아야한다. -->
				<p>
					아이디 : <input type="text" name="id" value="201701700" />
				</p>
				<p>
					패스워드 : <input type="password" name="pass" value="qwer1234"/>
				</p>
				
				<div>
					<button type="submit" id="loginButton" style="font-weight:bold; background:#ADD8E6;">
						로그인</button>
				</div>
			</form:form>
		</c:otherwise>
	</c:choose>




	</div>
		
	<!-- /////////////////////메인끝////////////////////// -->
		</body>
		
	<!-- 하단 인클루드 -->
	<jsp:include page="/resources/include/footer.jsp"/>

</html>