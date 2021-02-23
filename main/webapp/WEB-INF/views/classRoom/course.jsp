<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>코스 페이지 </title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>
<style type="text/css">
#content{
 	border-radius:5px;
 	padding-bottom: 0px;
 	padding-left: 0px;
 	padding-bottom: 0px;
}
.media-body{
 	cursor: pointer;
 	padding-top: 30xp;
 	border-radius:5px;
}
.media-body:hover{
 	background-color:#ADD8E6;
/*  	background-color:#8ac4d0; */
  	opacity: 0.8;
  	color: white;
}
a:hover {
	text-decoration: none;
}
.td{
	border: solid 1px #e8e8e8; 
	border-radius: 10px;
}
.td:hover{
  color: white;
}
</style>

<!-- body 시작 --> 
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoomMain.jsp"/><!-- flag구분예정 -->
	<!-- 제목 -->
   <div  style="text-align:center;">
		<small style="font-size:1.2em">코스</small><!-- flag구분예정-->
   </div>
   <hr /><!-- 구분자 -->

		<div class="mb-2" style="text-align:center;">	
			<table>
			<%
				int newLine = 0;
			
			%>
<c:forEach items="${lists }" var="row" varStatus="loop">	
				<%
					if (newLine == 0) {
					out.print("<tr>");
				}
				newLine++;
				%>
				<td class="td">
				<a href="../class/time.do?subject_idx=${row.subject_idx }">
					<div class="media-body">

								<img alt="책아이콘" src="<%=request.getContextPath() %>/resources/images/icon_online.png" 
								width="70px;">
								<div>
									${row.subject_name }
								</div>	
								<div style="text-align:right; font-size:14px">
									${row.user_name }&emsp;
								</div>
					</div>
				</a>	
				</td>
			<%
				if (newLine == 2) {
				out.print("</tr>");
				newLine = 0;
			}
			%>
</c:forEach>		 
			</table>	
		</div>		
			
	

   
   
 </body>           
            
   <jsp:include page="/resources/include/bottom.jsp" />



<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>