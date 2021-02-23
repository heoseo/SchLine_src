<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>코스 페이지 </title>
</head>
<style>
 h5 {
 	text-align: left;
 }
 #yes{
 	background: #d9ecf2;
    opacity: 0.9;
    font-weight:bold;
    border-radius: 15px; 
    border:solid 0.5px white;  
 }
 #no{
 	background: #ff4646;
   	opacity: 0.9;
   	color: white;
   	font-weight:bold;  
    border-radius: 15px; 
   	border: solid 0.5px white;
 }
#space{
	background: white;
	border: solid 0.5px white;
	padding: 2px;
}
#yes:hover{
	background: #d9ecf2;
    opacity: 0.5;
    font-weight:bold;
    border-radius: 15px; 
    border:solid 0.5px white; 
}
#no:hover{
	background: #ff4646;
   	opacity: 0.5;
   	color: white;
   	font-weight:bold;  
    border-radius: 15px; 
   	border: solid 0.5px white;
}
 
 a:hover
</style>
<!-- body 시작 -->   
<body class="is-preload">

	<div id="main">
	    <hr />
		<c:forEach items="${lists }" var="row">		
			<div class="container">
				<div class="container">
					<div class="container">
						<h5><a href="../class/grade.do?subject_idx=${row.subject_idx }">
						<i class="fas fa-check" id="sub"></i>${row.subject_name }</a></h5>
						<table class="table table-hover" style="font-size:5px; text-align:center;">
								<c:choose>	
									<c:when test="${row.rnum==1 }">
						 			
										<tr>
											<c:forEach items="${atten1 }" var="row2">
												<c:if test="${row2.attendance_flag==2 }">
													<td id="yes" style="margin-right: 30px;">
													${row2.rnum }강 O
													</td>
													<td id="space"></td>
													</c:if>
													<c:if test="${row2.attendance_flag!=2 }">
													<td id="no">
													${row2.rnum }강 X
													</td>
													<td id="space"></td>
													</c:if>	
											</c:forEach>		
										</tr>
									</c:when>
									<c:when test="${row.rnum==2 }">
										<tr>
											<c:forEach items="${atten2 }" var="row3">
												<c:if test="${row3.attendance_flag==2 }">
												<td id="yes" style="margin-right: 30px;">
													${row3.rnum }강 O
												</td>
												<td id="space"></td>
												</c:if>
												<c:if test="${row3.attendance_flag!=2 }">
												<td id="no">
													${row3.rnum }강 X
												</td>
												<td id="space"></td>
												</c:if>	
											</c:forEach>		
										</tr>
									</c:when>
									<c:when test="${row.rnum==3 }">

										<tr>
											<c:forEach items="${atten3 }" var="row4">
												<c:if test="${row4.attendance_flag==2 }">
												<td id="yes" style="margin-right: 30px;">
													${row4.rnum }강 O
												</td>
												<td id="space"></td>
												</c:if>
												<c:if test="${row4.attendance_flag!=2 }">
												<td id="no">
													${row4.rnum }강 X
												</td>
												<td id="space"></td>
												</c:if>	
											</c:forEach>		
										</tr>
									</c:when>
									<c:when test="${row.rnum==4 }">
										<tr>
											<c:forEach items="${atten4 }" var="row5">
												<c:if test="${row5.attendance_flag==2 }">
												<td id="yes" style="margin-right: 30px;">
													${row5.rnum }강 O
												</td>
												<td id="space"></td>
												</c:if>
												<c:if test="${row5.attendance_flag!=2 }">
												<td id="no">
													${row5.rnum }강 X
												</td>
												<td id="space"></td>
												</c:if>	
											</c:forEach>		
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<c:forEach items="${atten5 }" var="row6">
											
												<c:if test="${row6.attendance_flag==2 }">
												<td id="yes" style="margin-right: 30px;">
													${row6.rnum }강 O
												</td>
												<td id="space"></td>
												</c:if>
												<c:if test="${row6.attendance_flag!=2 }">
												<td id="no">
													${row6.rnum }강 X
												</td>
												<td id="space"></td>
												</c:if>											
									
											</c:forEach>		
										</tr>
									</c:otherwise>
								</c:choose>
							
						</table>
					</div>
				</div>
			</div>
		</c:forEach>
		
		
   </div>
   
</body>

</html>