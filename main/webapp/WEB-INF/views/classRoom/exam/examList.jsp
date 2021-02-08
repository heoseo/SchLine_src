<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>

<script>
function taskWrite(subject_idx, exam_idx){
	$.ajax({
		url : "examStart.do",
		type : "post",
		beforeSend : function(xhr){
            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
           },
		data : {"subject_idx" : subject_idx, "exam_type" : 1},
		dataType : "html",
		contentType : "application/x-www-form-urlencoded;chatset:utf-8",
		success : function(Data){
			$("#taskWrite").html(Data);
		},
		error : function(e){
			alert("실패"+e);
		}
	});	
}

</script>
<!-- 아래는 c:choose문으로 인해 jsp 주석으로 처리한다. -->

<c:choose>

	<%-- 타입이 시험(2)일 경우.. (상단 및 좌측 메뉴를 제거한다..뒤로가기는 어떻게 막을까) --%>
<c:when test="${examlist[0].exam_type ne '1' }">
	<title>시험</title>
		<script src='<c:url value="/resources/assets/js/jquery.min.js"/>'></script>		
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/main.css" />
	</head>
<script>
$(function(){
	$('#examBtn').click(function(){
		var f = document.examFrm;
		var data = new FormData(f);	
		$.ajax({
			url : "examComplete.do", //요청할경로
			type : "post", //전송방식
			//contentType : "application/x-www-form-urlencoded;charset:utf-8",
			data : data,
			contentType : false,
			processData: false,
			beforeSend : function(xhr){
	            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	           },
			dataType : "json", //콜백데이터의 형식
			success : function(d){ //콜백 메소드
				if(d.examResult==0){
					//실패시
					alert('시험제출실패');
				}
				else{
					//성공시
					alert('시험완료');
					var score = d.score;
					var user_name = d.user_name;
					var subject_name = d.subject_name;
					document.getElementById("modal_head").innerHTML = subject_name;
					document.getElementById("modal_body").innerHTML =
						user_name+'님의 시험결과(주관식제외) : '+score+'점';
					$('#examModal').modal();
				}
			},
			error : function(e){//실패콜백메소드
				alert("실패"+e);
			}
		});
	});
});
</script>
	</head>
	<div id="wrapper">
		<div align="center">
			<br /><img src="<%=request.getContextPath() %>/resources/images/logo3.png" width="400px" alt="스쿨라인 로고" /><br />
		</div>
	<%-- body 시작 --%>
		<body class="is-preload">
			<div id="main" class="container-fluid">
				<div class="row content">
					<br />	
					<div class="container">
					<%-- 시험명 --%>
					<br /><p style="text-align:center; font-size:1.5em">${subject_name } 시험</p>
					<%-- 정답 체크를 위한 폼 --%>
					<form:form name="examFrm">
					<%-- 시험문제 반복 --%>
					<c:forEach items="${examlist }" var="row" varStatus="loop">
						<table>
							<tr>
								<%-- 순차적으로 문제번호 부여 --%>
								<td><b>문제 ${loop.count }</b> : ${row.question_content } &nbsp;
								<%-- 문제별 난이도 부여(추후 난이도별로 추출할 예정) --%>
								<span style="font-size:0.7em;">(난이도 : ${row.question_score })</span>
								</td>
							</tr>
							
							<%-- 객관식 문제일 경우.... --%>
							<c:if test="${row.question_type eq 1 }">
							<%-- 문항을 추출한다 --%>
							<c:forEach items="${questionlist }" var="qrow" varStatus="qloop">
							<%-- 추출한 문항중에 현재 문제번호와 동일한 인덱스를 가진 문항리스트를 선택 --%>
							<c:if test="${row.question_idx eq qrow.question_idx }">
							<tr>
								<%-- 문항 출력 --%>
								<td style="padding-left:50px;">${qrow.questionlist_num} : ${qrow.questionlist_content }</td>
							</tr>
							</c:if>
							</c:forEach>
							<%-- select 태그를 통해 객관식의 정답을 선택하게 한다... --%>
							<tr>
								<td>정답선택 : 
									<select name="choice" id="demo-category" style="width:100px; height:30px; display:inline;">
										<option value="정답1" selected>1</option>
										<option value="정답2">2</option>
										<option value="정답3">3</option>
										<option value="정답4">4</option>
										<option value="정답5">5</option>
									</select>
								</td>
							</tr>
							</c:if>
							<%-- 객관식이 아닐경우 정답을 입력할 수 있는 인풋(텍스트)태그를 부여 --%>
							<c:if test="${row.question_type ne 1 }">
								<td >정답입력 : <input type="text" name="choice" style="width:300px; height:30px; display:inline;"></td>
							</c:if>
							<%-- 정답 확인을 위한 문항별 인덱스를 히든폼에 저장 --%>
							<input type="hidden" name="questionNum" value="${row.question_idx }"/>
						</table>
					
					</c:forEach>
							<input type="hidden" name="subject_idx" value="${param.subject_idx }"/>
							<input type="hidden" name="exam_type" value="${param.exam_type }"/>
					<span> <input type="button" id="examBtn" value="제출" style="float:right;"/> </span>
					<br />
					</form:form>   
					
	<%-- 시험 종료시 모달창.. 점수 확인 후 코스리스트로 보내기--%>
	<div class="modal fade" id="examModal">
	    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
	        <div class="modal-content" style="text-align:center">
	            <div class="modal-header">
	                <h3 class="modal-title" id="modal_head"></h3>
	            </div>
	            <div class="modal-body" id="modal_body"></div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-danger" data-dismiss="modal"
	                onclick="location.href='../'">
	                	확인</button>
	            </div>
	        </div>
	    </div>
	</div>		 
</c:when> <%-- 시험문제 리스트 출력 끝 --%>



	<%-- 타입이 과제(1)이라면... --%> 
<c:otherwise>
	<title>과제</title>
	<%@ include file="/resources/include/top.jsp"%>	   
	<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/>
	
	<hr /><%-- 구분자 --%>
	<p style="text-align:center; font-size:1.2em">${subject_name } 과제</p>
		<div class="table-wrapper">
			<table class="alt" style="text-align:center">
			<c:forEach items="${examlist }" var="trow" varStatus="tloop">
				<c:if test="${trow.exam_idx ne 0 }">
				<tr>
					<td style="width:20%;">과제명</td>
					<td style="text-align:left;">과제 내용</td>	
					<td style="width:15%">마감일</td>
					<td style="width:15%">제출여부</td>
					<td style="width:10%">제출하기</td>
				</tr>
				<tr>
					<td style="width:20%;" >${trow.exam_name }</td>
					<td style="text-align:left; overflow:hidden;">${trow.exam_content }</td>	
					<td style="width:15%">${trow.exam_date }</td>
					<td style="width:15%">${check }</td>
					<td style="width:10%"><input type="button" class="button primary"
					 onclick="location.href='javascript:taskWrite(${param.subject_idx}, ${trow.exam_idx });'"
					value="제출하기" style="min-width:0"
					<c:if test="${check eq '제출' }">disabled="disabled"</c:if>>
					</td>
				</tr>
				</c:if>
			</c:forEach>
			</table>
			<%-- Ajax로 과제 제출이 붙는 영역 학생정보와, 과제정보, --%>
			<div id="taskWrite"></div>
		</div>
	</c:otherwise>
</c:choose>

 <jsp:include page="/resources/include/bottom.jsp" />
</body>

<!-- 하단 인클루트 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>