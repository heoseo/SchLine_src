<%@page import="schline.PenBbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@  taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<title>상세보기 교수-펜게시판</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top_professor.jsp"%>


<!-- body 시작 -->
<body class="is-preload">

	<hr />
   	<div style="text-align: center;">
      	<small>${viewRow.board_type  } 게시판</small><!-- flag구분예정-->
   	</div>
   	<hr /><!-- 구분자 -->
   

<div class="container">
	
	<table border=1 width=800>
	<colgroup>
		<col width="10%"/>
		<col width="10%"/>
		<col width="15%"/>
		<col width="25"/>
		<col width="15%"/>
		<col width="25"/>
	</colgroup>
	<tr>
		<td>NO.${viewRow.pen_idx }</td>
		<td>		
			
		</td>
		<td>작성일 &nbsp;</td>
		<td>		
			${viewRow.postdate }
		</td>
		<td>조회수</td>
		<td>		
			${viewRow.hits }
		</td>
	</tr>
	<tr>
		<td>제목</td>
		<td colspan="5">		
			${viewRow.board_title }
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td  colspan="5" style="height:150px;">
			${viewRow.board_content }
		</td>	
	</tr>
	<tr>
		<td colspan="6" align="center">	
		<c:set value="${viewRow.user_id}" var="p_user"/>
		<c:set value="${user_id }" var="s_user"/>

		<c:if test="${p_user eq s_user }">
		<button type="button" 
			onclick="location.href='./editOrdel.do?pen_idx=${viewRow.pen_idx}&mode=edit&nowPage=${nowPage }';">
			수정하기</button>
		<button type="button" 
			onclick="location.href='./editOrdel.do?pen_idx=${viewRow.pen_idx}&mode=delete&nowPage=${nowPage }&board_type=${viewRow.board_type }';">
			삭제하기</button>		
		</c:if>
         <c:if test="${p_user ne s_user }">
      		<button type="button" 
			onclick="location.href='./reply.do?pen_idx=${viewRow.pen_idx}&nowPage=${nowPage }';">
			답변글달기</button>
			</c:if>
		<button type="button"      
			onclick="location.href='./penlist.do?nowPage=${param.nowPage}&board_type=${viewRow.board_type }';">리스트보기</button>
		
			</td>
		</tr>

	</table>	
</div>
   <script>
   
   
   
   </script>
   
            
   	<jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>