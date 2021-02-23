<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<title></title>
		
<script>
function changeteam(){
	var user_id = document.getElementById("user_id").value;
	var team_num = document.getElementById("team_num").value;

	$.ajax({
		url : 'teamChange.do',
		type : "get",
		data : 
		{
			"id" : user_id,
			"team_num" : team_num
		},
		contentType : "text/html;charset:utf-8",
		beforeSend : function(xhr){
            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
           },
		dataType : "json",
		success : function(d){
			if(d.result==1){
				alert("변경완료");
			}
			else{
				alert("변경실패");
			}
		},
		error : function(e){
			alert('콜백실패'+e);
		}
	});
}

</script>
<!-- 나머지 head속성은 인클루드에 있어요 -->
<!-- 상단  인클루드 : 메뉴별 페이지 이동설정 해야함★★★★★★-->
<%@ include file="/resources/include/top_professor.jsp"%>


<body class="is-preload" >
	<div id="main">
	
	<h2>&nbsp;</h2>
	
<div class="table-wrapper">
	<table>
	<tr><td colspan="4" style="text-align:center; font-size: 1.2em" ><b>과제</b></td></tr>
		<tr>
			<td colspan="2"><a href="ptaskList.do" class="button primary fit">과제등록</a></td>
			<td colspan="2"><a href="taskCheck.do" class="button primary fit">과제확인</a></td>
			</tr>
	</table>
	<br />
	<table class="alt">
		<tr><td colspan="5" style="text-align:center"><b>협업 게시판</b></td></tr>
		<tr>
			<td><a href="teamList.do?team_num=1" class="button fit">협업1팀</a></td>
			<td><a href="teamList.do?team_num=2" class="button primary fit">협업2팀</a></td>
			<td><a href="teamList.do?team_num=3" class="button fit">협업3팀</a></td>
			<td><a href="teamList.do?team_num=4" class="button primary fit">협업4팀</a></td>
			<td><a href="teamList.do?team_num=5" class="button fit">협업5팀</a></td>
		</tr>
		<tr><td colspan="5" style="text-align:center"><b>팀 배정</b></td></tr>
		<tr>
			<td style="text-align:center">학생</td>
			<td>
			<select name="user_id" id="user_id" >
			<c:forEach items="${userlist }" var="urow">
				<option value="${urow.user_id }">${urow.user_name }</option>
			</c:forEach>
			</select>
			</td>
			<td style="text-align:center">팀</td>
			<td>
			<select name="team_num" id="team_num">
				<option value="1">1팀</option>
				<option value="2">2팀</option>
				<option value="3">3팀</option>
				<option value="4">4팀</option>
				<option value="5">5팀</option>
			</select>
			</td>
			<td><a onclick="changeteam();" class="button fit primary">배정</a></td>
		</tr>
	</table>
</div>
	<br />
	</div>
</body>
<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>