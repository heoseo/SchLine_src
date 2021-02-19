<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<title>문제출제 </title>
	<!-- Scripts -->
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
			<br /><img src="<%=request.getContextPath() %>/resources/images/logo.png" width="400px" alt="스쿨라인 로고" /><br />
			</div>
<style>
testarea {height : 50px;}
</style>
<!-- body 시작 -->
<script>
$(function(){
	$('#question_type').change(function(){
		var question_type = $(this).val();
		if(question_type=='1'){
			alert('객관식을 선택했습니다. 문항을 등록해주세요');
			$('#addquestionlist').append(
				'<tr id="addedquestion"><td colspan="2">문항내용'+
			 	'<br/>'+
				'<span><textarea name="questionlist_content" placeholder="1번문항"></textarea></span>'+	
			 	'<span><textarea name="questionlist_content" placeholder="2번문항"></textarea></span>'+	
			 	'<span><textarea name="questionlist_content" placeholder="3번문항"></textarea></span>'+	
			 	'<span><textarea name="questionlist_content" placeholder="4번문항"></textarea></span>'+	
			 	'<span><textarea name="questionlist_content" placeholder="5번문항"></textarea></span>'+
			 	'</td></tr>'
			);
		}
		else{
			$('#addedquestion').html('');	
		}
	});
});

function makeQuestion(){
	var f = document.examMakeFrm
	var data = new FormData(f);
	$.ajax({
		url : "/schline/professor/examWriteAction.do",
		type : "post",
		data : data,
		contentType : false,
		processData: false,
		beforeSend : function(xhr){
            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
           },
		dataType : "json",
		success : function(d){
			if(d.result==1){
				alert("문제가 등록되었습니다.");
				$('#pexamwrite').modal('hide');
			}
			else{
				alert("문제 등록에 실패했습니다.");
			}
		},
		error : function(e){
			alert("콜백실패"+e);
		}
	});
}
</script>
<body class="is-preload">
<div id="main">	
<br />
<div class="container">
 <hr /><!-- 구분자 -->
 <div id="setquestion">
 	<div>
 	<button class="btn btn-primary" data-toggle="modal" data-target="#pexamwrite" style="width:100%">문제작성</button>
 	</div>
 	<!-- <table id="addquestion">
 	<tr><td>작성한 문제</td></tr>
 	</table> -->

 </div>

 <br />

 <!-- 시험문제 출제 모달창 -->
<div class="modal fade" id="pexamwrite">
   <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
       <div class="modal-content modal-lg" style="text-align:center">
           <div class="modal-body" id="modal_body">
           	<span style="display:block; text-align:center; font-size:1.3em;"><b>[출제 양식]</b></span><br />
	<form:form name="examMakeFrm">
	 	<h3 style="display:inline">유형&emsp;:&emsp;</h3>
	 	<select name="question_type" id="question_type" style="display:inline; width:40%">
	 		<option value="1">객관식</option>
	 		<option value="2" selected>단답형</option>
	 		<option value="3">서술형</option>
		 </select>
	 	<br /><br />
	 	<table class="alt" id="addquestionlist">
	 	<tr ><td colspan="2">문제내용</td></tr>
	 	<tr><td colspan="2"><textarea style="height:200px;" name="question_content"></textarea></td></tr>
	 	</table>
	 	<table class="alt">
	 	<tr>
	 	<td>정답</td>
	 	<td>배점</td>
	 	</tr><tr>
	 	<td><input type="text" name="answer"/></td>
	 	<td>
		 	<select name="score" id="score">
		 		<option value="2">2점</option>
		 		<option value="3">3점</option>
		 	</select>
		 </td>
	 	</tr></table>
	 	<input type="hidden" name="exam_idx" value="${exam_idx }" />
	</form:form>
           
           
           </div>
           <div class="modal-footer">
           <p><button type="button" class="btn btn-success"
               onclick="javascript:makeQuestion()">
                	문제추가</button></p>
            </div>
        </div>
    </div>
</div>	  
    
    
 <jsp:include page="/resources/include/bottom.jsp" />
</body>
</html>