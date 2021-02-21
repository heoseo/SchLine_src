<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
	<head>
		<title>님,강의 수정페이지</title>
<!-- 나머지 head속성은 인클루드에 있어요 -->
<!-- 상단  인클루드 : 메뉴별 페이지 이동설정 해야함★★★★★★-->
<%@ include file="/resources/include/top_professor.jsp"%>
  <script src = "https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
  <script src ="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>  


<body class="is-preload" >
	<div id="main">	
	<br />
	<br />
	<div class="container">
	    <form:form name="fileFrm" method="post" action="videoupload.do?${_csrf.parameterName}=${_csrf.token}" 
               enctype="multipart/form-data">
   	
	<table class="table table-bordered table-hover table-striped">	
   	 <colgroup>
   		 <col width="40%" />
   		 <col width="*" />   		 
   	 </colgroup>
   	 <tr>
   		 <th>제목</th>
   		 <td colspan="2">
           <input type = "text" name = "title" />  
		</td>	 
   	 </tr>
   	 <tr>
   		 <th>출석인정일 선택</th>
   		 <td colspan="2">		
   		 <input type="hidden" name="subject_idx" value="${subject_idx }" />
           <input type = "date" name = "end_date" style="border:none;">  
		</td>	 
   	 </tr>
   	 <tr>
   		 <th>강의영상 불러오기</th>
   		 <td>
   			 <input type="file" name="userfile1" />
   		 </td>   		 			
   	 </tr>
   	 <tr>
   		 <td colspan="2" style="text-align:left;">
   			 <button type="submit" class="btn btn-dark">업로드</button>
   		 </td>   		 
   	 </tr>
    </table>
    </form:form>
	</div>
	</div>
</body>
    
<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />

</html>