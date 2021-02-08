<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>리스트페이지 </title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>


<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/><!-- flag구분예정 -->

	<hr />
   	<div style="text-align: center;">
      	<small>코스</small><!-- flag구분예정-->
   	</div>
   	<hr /><!-- 구분자 -->
   
   	<div class="row text-right" style="margin-bottom:10px; padding-right:50px;">
<form:form class="form-inline ml-auto">	
	<div class="form-group">
		<select name="searchColumn" id="searchColumn" class="form-control">
			<option value="board_title">제목</option>
			<option value="board_content">내용</option>
		</select>
	</div>
	<div class="input-group">
		<input type="text" name="searchWord"  class="form-control" placeholder="검색어를 입력하세요"/>
		<input type="hidden" value="${board_type }" name="board_type" />
		<div class="input-group-btn">
			<button type="submit" class="btn btn-default">검색<i class="glyphicon glyphicon-search"></i></button>
		</div>
	</div>
</form:form>
</div>

	<div class="table-wrapper">
		<table class="alt">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성일</th>
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
   
            
   	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>