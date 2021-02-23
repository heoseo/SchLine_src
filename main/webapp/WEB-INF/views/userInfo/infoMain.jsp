<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<title>출결</title>
</head>

<script>
$(function() {
	console.log("infoMain 들어옴");
 	$.ajax({
		url : "<%=request.getContextPath() %>/user/InfoAtten.do",
		type : "POST",
		dateType : "html",
		cache: false,  
		beforeSend : function(xhr){
				xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
           },
		contentType : "application/x-www-form-urlencoded;chatset:utf-8",
		success : function(data) {
			console.log(data);
			$("#cay").html(data);
			}
	}); 
});
</script>

<body class="is-preload">

	<div id="cay">
		Display
	</div>	

</body>

</html>