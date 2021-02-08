<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- Ajax를 통해 과목정보를 가져와서 과제를 제출할 수 있도록 할것입니다! -->
<div class="table-wrapper">
<script type="text/javascript">
$(function(){
	//버튼 클릭
	$('#taskWriteBtn').click(function(){
		//폼의 빈값 체크
		var f = document.taskFrm;
		var data = new FormData(f);
		if(f.board_title.value==""){
			alert("제목을 입력하세요");
			f.board_title.focus();
			return false;
		}
		if(f.board_content.value==""){
			alert("내용을 입력하세요");
			f.board_content.focus(); 
			return false;
		}
		if(f.userfile1.value==""){
			alert("과제를 첨부하세요"); 
			return false;
		}
		
		$.ajax({
			url : "taskWriteAction.do", //요청할경로
			type : "post", //전송방식
			//contentType : "application/x-www-form-urlencoded;charset:utf-8",
			data : data,
			contentType: false,
			processData: false,
			dataType : "json", //콜백데이터의 형식
			success : function(d){ //콜백 메소드
				/*
				콜백데이터 타입이 json이므로 별도의 파싱없이 즉시
				데이터를 읽을수 있다. 만약 json타입이 아니라면
				JSON.Parse()를 호출해야 한다.
				*/
				if(d.taskResult==0){
					//실패시
					alert('과제제출실패');
				}
				else{
					//성공시
					alert('과제제출성공');
				}
				location.reload();
				//과제작성란을 닫는다	
				//document.getElementById("taskWrite").innerHTML = "";
			},
			error : function(e){//실패콜백메소드
				alert("실패"+e);
			}
		});
	});
});
</script>
	<span style="display:block; text-align:center; font-size:1.3em;"><b>[제출 양식]</b></span><br />
	<form:form name="taskFrm" method="post"  enctype="multipart/form-data">
		 
		<table class="alt" style="text-align:center;">
			<tbody>
				<tr>
					<!-- 
						4. board_flag_te값 Y면 협업, N이면 개인과제로 표시
						5. 글 작성일..붙도록...(작성시에는 필요없는데..)
						6. exam_type은 1(과제)
						7. board_file로 파일업로드 처리까지
					-->
					<td style="width:15%">과목</td>
					<td style="width:35%">${map.subject_name }</td>
					<td style="width:15%">과제명</td>
					<td>${map.exam_name }</td>
				</tr>
				<tr>
					<td style="width:15%">작성자</td>
					<td style="width:35%">${map.user_name }</td>
					<td style="width:15%">마감일</td>
					<td>${map.exam_date }</td>
				</tr>
				<tr>
					<td style="width:15%">과제내용</td>
					<td style="text-align: left;" colspan="3">${map.exam_content }</td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><input type="text" name="board_title" id="" /></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3" style="height:300px"><textarea name="board_content" style="height:100%;"></textarea></td>
				</tr>
				<tr>
					<td>파일첨부1</td>
					<td style="text-align: left;" colspan="3"><input type="file" name="userfile1" id="" /></td>
				</tr>
				<tr>
					<td>파일첨부2</td>
					<td style="text-align: left;" colspan="3"><input type="file" name="userfile2" id="" /></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td style="text-align: right;" colspan="4">
					<input type="button" id="taskWriteBtn" class="button primary fit" value="제출">
					</td>
				</tr>
			</tfoot>
		</table>
		<input type="hidden" name="exam_idx" value="${map.exam_idx }" />
		<input type="hidden" name="subject_idx" value="${map.subject_idx }" />
		<!-- 유저 아이디는 추후 세션(?)에서 가져올것 -->
		<input type="hidden" name="user_id" value="${map.user_id }" />
		<input type="hidden" name="exam_name" value="${map.exam_name }" />
	</form:form>
</div>