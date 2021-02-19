<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
	<title>통합과제함</title>
	<%@ include file="/resources/include/top.jsp"%>	   
	<jsp:include page="/resources/include/leftmenu_classRoomMain.jsp"/>
	
	<hr /><%-- 구분자 --%>
	<p style="text-align:center; font-size:1.2em">종합과제함</p>
		<div class="table-wrapper">
			<table class="alt" style="text-align:center">
				
				<tr>
					<td style="width:15%">과목</td>
					<td style="width:20%;">과제명</td>
					<td style="text-align:left;">과제 내용</td>	
					<td style="width:15%">마감일</td>
					<td style="width:10%">과제함이동</td>
				</tr>
			<c:forEach items="${examlist }" var="trow" varStatus="tloop">
				<tr>
					<td style="width:10%;" >${trow.subject_name }</td>
					<td style="width:20%;" >${trow.exam_name }</td>
					<td style="text-align:left; overflow:hidden;">${trow.exam_content }</td>	
					<td style="width:15%">${trow.exam_date }</td>
					<td style="width:10%">
					<a href="/schline/class/taskList.do?subject_idx=${trow.subject_idx}&exam_type=1" class="button primary">
					이동하기
					</td>
				</tr>
				
			</c:forEach>
			</table>
		</div>

 <jsp:include page="/resources/include/bottom.jsp" />
</body>

<!-- 하단 인클루트 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>