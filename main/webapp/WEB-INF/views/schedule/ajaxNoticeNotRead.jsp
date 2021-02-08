<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ajaxAllBoard.jsp -->
<style>
#category {
}
#selectSapn {
	border: solid;
	width: 10px;
}
#searchDiv {
	border: solid;
	font-size: 0px;
}
#listDate {text-align: right;}
</style>

<!-- 읽은 공지사항 리스트 출력하기 -->
<c:forEach items="${Noticelists }" var="row">
			
		<table style="height: 10px;">
			<tr id="listTr">
				<td id="contentTd">
					<div id="listTitle">
						공지제목 : ${row.board_title }
					</div>
					<div id="listContent">
						내용 : ${row.board_content }
					</div>
					<div id="listDate">
						게시일 : ${row.board_postdate }
					</div>
				</td>
			</tr>
		</table>
			
</c:forEach>
<!-- 읽은 공지사항 리스트 끝. -->	
	
		<!-- 방명록 반복 부분 e -->
		<ul class="pagination justify-content-center">
			${pagingImg }
		</ul>