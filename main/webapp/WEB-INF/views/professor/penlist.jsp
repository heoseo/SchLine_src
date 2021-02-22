<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>교수 - 리스트페이지 </title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top_professor.jsp"%>


<!-- body 시작 -->
<body class="is-preload">

<div style="background: white;">
   	
	<br /><br />
   	<div style="text-align: center;"> <!-- ${viewRow.board_type  } -->
      	<small style="font-size:1.2em; font-weight:bold;">
		  <c:choose>
		   <c:when test="${board_type eq 'red'}">
		     <i class="fas fa-edit"></i>&nbsp;&nbsp;정정게시판
		   </c:when>
		   <c:otherwise>
		     <i class="fas fa-question-circle"></i>&nbsp;&nbsp;질문게시판
		   </c:otherwise>
		  </c:choose>
		</small><!-- flag구분예정-->
      
   	</div>
   

   	<div class="row text-right" style="padding-right:50px;">
<form:form class="form-inline ml-auto">	
	<div class="form-group">
		<select name="searchColumn" id="searchColumn" class="form-control" 
		style="color:#145374; font-size:18px; padding-left:10px; padding-right:10px font-weight:bold;">
			<option value="board_title">제목</option>
			<option value="board_content">내용</option>
		</select>
	</div>
	<div class="input-group">
		<input type="text" name="searchWord"  class="form-control" placeholder="검색어를 입력하세요"/>
		<input type="hidden" value="${board_type }" name="board_type" />
		<div class="input-group-btn">
			<button type="submit" class="btn btn-info" style="background:#ADD8E6; font-weight:bold;">
			<i class="fas fa-search" style="font-size:20px"></i></button>
		</div>
	</div>
</form:form>
	</div>

	<div class="table-wrapper">
		<table class="table table-bordered table-hover table-striped">
			<thead>
				<tr>
					<th style="text-align:center;">번호</th>
					<th>제목</th>
					<th style="text-align:center;">조회수</th>
					<th style="text-align:center;">작성일</th>
				</tr>
			</thead>
			<tbody>
			<c:choose>
			<c:when test="${empty listRows }">
				<tr>
					<td colspan="6" class="text-center">
						등록된 게시물이 없습니다 ^^*
					</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${listRows }" var="row" 
					varStatus="loop">
					<!-- 리스트반복시작 -->
					<tr>
						<td class="text-center">${row.virtualNum }</td>
						<td class="text-left">
							<a href="./view.do?pen_idx=${row.pen_idx}
								&nowPage=${nowPage}">${row.board_title}</a>
						</td>
						<td class="text-center">${row.hits }</td>
						<td class="text-center">${row.postdate }</td>
					</tr>
					<!-- 리스트반복끝 -->
				</c:forEach>
			</c:otherwise>
		</c:choose>	
			</tbody>
		</table>
		<table border="1" width="90%">
		<tr>
			<td align="center">
				${pagingImg }
			</td>
		</tr>
	</table>
	</div>
</div>   
            
   	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>