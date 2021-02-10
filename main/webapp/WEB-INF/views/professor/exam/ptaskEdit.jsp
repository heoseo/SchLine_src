<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

<script src='<c:url value="/resources/assets/js/jquery.min.js"/>'></script>
<script src='<c:url value="/resources/assets/js/jquery.scrollex.min.js"/>'></script>
<script src='<c:url value="/resources/assets/js/jquery.scrolly.min.js"/>'></script>
<script src='<c:url value="/resources/assets/js/browser.min.js"/>'></script>
<script src='<c:url value="/resources/assets/js/breakpoints.min.js"/>'></script>
<script src='<c:url value="/resources/assets/js/util.js"/>'></script>
<script src='<c:url value="/resources/assets/js/main.js"/>'></script>

<!-- 드롭다운용 부트 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
				

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/main.css" />
<noscript><link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/noscript.css" /></noscript>
</head>

<div id="wrapper">
	<div align="center">
	<br /> 
	<img src="<%=request.getContextPath() %>/resources/images/logo3.png" width="400px" alt="스쿨라인 로고" />

	</div>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />

<!-- Ajax를 통해 과목정보를 가져와서 과제를 제출할 수 있도록 할것입니다! -->

<script type="text/javascript">
$(function () {
	$('#datetimepicker1').datetimepicker({
		format: 'L'}); 
		$('#datetimepicker2').datetimepicker({
			format: 'L', useCurrent: false 
	}); 
	$("#datetimepicker1").on("change.datetimepicker", 
		function (e) {
			$('#datetimepicker2').datetimepicker('minDate', e.date);
	}); 
	$("#datetimepicker2").on("change.datetimepicker", 
		function (e) {
			$('#datetimepicker1').datetimepicker('maxDate', e.date);
	});
});
function maketask(){
	var task_name = document.getElementById("task_name").value;
	var task_date = document.getElementById("task_date").value;
	var task_scoring = document.getElementById("task_scoring").value;
	var task_content = document.getElementById("task_content").value;
	if(task_name==""){
		alert("과제명을 입력하세요");
		return false;
	}
	if(task_date==""){
		alert("마감일을 선택하세요");
		return false;
	}
	if(task_scoring==""){
		alert("배점을 입력하세요");
		return false;
	}
	if(task_content==""){
		alert("내용을 입력하세요");
		return false;
	}
	var c = confirm("과제를 수정 하시겠습니까?");
	if(c){
		var f = document.ptaskEditFrm;
		var data = new FormData(f);
		$.ajax({
			url : '/schline/professor/ptaskEditAction.do',
			type : 'post',
			data : data,
			contentType : false,
			processData: false,
			beforeSend : function(xhr){
	            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	        },
	       	dataType : "json",
	       	success : function(d){
	       		alert('수정되었습니다');
				self.close();
				
			},
			error : function(e){
				alert("ajax실패"+e);
				console.log(e);
			}
		});
	}
}
</script>
<style>
textarea { height : 200px; }
</style>
<!-- body 시작 -->
<body class="is-preload">
<div class="table-wrapper">
<div id="main">	
<div class="container">
 	<form:form name="ptaskEditFrm">

 	<table class="alt text-center">
 	<tr>
 	<td rowspan="2" style="vertical-align:middle; width:10%;">과제<br />등록</td>
 	<td>과제명</td>
 	<td style="width:20%">종료일</td>
 	<td style="width:15%">과제배점</td>
 	<td rowspan="3" style="vertical-align:middle; width:10%"><button class="btn btn-primary" 
 	onclick="maketask();" style="min-width:0; height:50%;">과제<br/>수정</button></td></tr>
 	<tr>
 	<td><input type="text" name="exam_name" id="task_name" value="${dto.exam_name }"></td>
 	<td>
 	<div class="input-group date" id="datetimepicker1" data-target-input="nearest">
 	<input type="text" name="exam_date" id="task_date"
 		 class="form-control datetimepicker-input" data-target="#datetimepicker1">
 	<div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker"> 
 	<div class="input-group-text"><i class="fa fa-calendar"></i></div> </div> </div>
 	
 	</td>
 	<td style="width:10%"><input type="number" name="exam_scoring" id="task_scoring"
 		value="${dto.exam_scoring }" style="width:100%"/></td>
 	</tr>
 	<tr>
 	<td style="vertical-align:middle;">과제<br/>내용</td>
 	<td colspan="3"><textarea name="exam_content" id="task_content" style="height:200px;">${dto.exam_content }</textarea></td>
 	</tr>
 	</table>
	<input type="hidden" name="exam_idx" value="${dto.exam_idx }" />
 	</form:form>
 </div>
 
			</div>
		</div>
	</div>
 
</body>
</html>