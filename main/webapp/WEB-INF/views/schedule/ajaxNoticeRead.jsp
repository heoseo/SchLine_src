<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ajaxNoticeRead.jsp -->

<!-- 읽은 공지사항 리스트 출력하기 -->
<c:forEach items="${ajaxNoticeRead }" var="row">
			
			<table style="height: 10px;">
				<tr id="listTr">
					<td id="contentTd">
						<div id="listTitle">
							글확인여부 : ${row.CHECK_FLAG }
						</div>
						<div id="listTitle">
							공지제목 : ${row.TITLE }
						</div>
						<div id="listContent">
							내용 : ${row.CONTENT }
						</div>
						<div id="listDate">
							게시일 : ${row.POSTDATE }
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