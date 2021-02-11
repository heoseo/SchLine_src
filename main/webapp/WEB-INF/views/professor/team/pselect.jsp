<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<title></title>
<!-- 나머지 head속성은 인클루드에 있어요 -->
<!-- 상단  인클루드 : 메뉴별 페이지 이동설정 해야함★★★★★★-->
<%@ include file="/resources/include/top.jsp"%>


<body class="is-preload" >
	<div id="main">
	
	<h2>.</h2>
	
<div class="table-wrapper">
	<table>
	<tr><td colspan="5" style="text-align:center">과제</td></tr>
		<tr>
			<td colspan="5"><a href="#" class="button primary fit">과제관리</a></td>
		</tr>
		<tr><td colspan="5"><br /></td></tr><tr><td colspan="5"></td></tr>
		<tr><td colspan="5" style="text-align:center">협업 게시판</td></tr>
		<tr>
			<td><a href="teamList.do?team_num=1" class="button fit">협업1팀</a></td>
			<td><a href="teamList.do?team_num=2" class="button primary fit">협업2팀</a></td>
			<td><a href="teamList.do?team_num=3" class="button fit">협업3팀</a></td>
			<td><a href="teamList.do?team_num=4" class="button primary fit">협업4팀</a></td>
			<td><a href="teamList.do?team_num=5" class="button fit">협업5팀</a></td>
		</tr>
	</table>
</div>
	</div>
</body>
<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>