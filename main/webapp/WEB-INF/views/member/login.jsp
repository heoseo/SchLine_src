<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
	<head>
		<title></title>
<!-- 나머지 head속성은 인클루드에 있어요 -->
<!-- 상단  인클루드 : 메뉴별 페이지 이동설정 해야함★★★★★★-->
<%@ include file="/resources/include/top.jsp"%>


<body class="is-preload" >
	<div id="main">
	
	<br /><br /><br /><br />
	<c:choose>
		<c:when test="${not empty user_id }">
			${user_id}님, 하이룽~^^*
			
			<form:form method="post"
					action="${pageContext.request.contextPath }/member/logout">
					
					<input type="submit" value="로그아웃" />
			</form:form>
		</c:when>
		<c:otherwise>
			<!-- security-context2에서  login-processing-url="/loginAction" 를 안쓸땐
				default로 /login으로 지정되므로  아래와같이 value="/login"으로 한다.
<%-- 			<c:url value="/login" var="loginUrl"/> --%>
			-->
			<c:url value="/loginAction" var="loginUrl"/>
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
				
				<button type="submit" class="btn btn-danger" >
					로그인하기</button>
			</form:form>
		</c:otherwise>
	</c:choose>


	</div>
</body>

<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>