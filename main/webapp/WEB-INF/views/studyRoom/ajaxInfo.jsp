<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%-- <%@ include file="/resources/include/top.jsp"%> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax페이지</title>
<!-- <script -->
<!-- 	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
</head>

<!-- ajax 페이지의 바디부분 넘어갈 예정 -->
<body>

<style type="text/css">
#profile_img {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 이미지 비율 유지한채로 가공 */
}
</style>

	<script>
		var sel_file;
		//프로필 이미지 파일올리면 자동교체:)
		$(document).ready(function() {
			$("#change_img").on("change", handleImgFileSelect);
		});

		//이미지 파일 교체시
		function handleImgFileSelect(e) {
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);

			//이건 수정해야할듯!?
			filesArr.forEach(function(f) {
				if (!f.type.match("image.*")) {
					alert("확장자는 이미지 확장자만 가능합니다.");
					return;
				}
				
				sel_file = f;
				var reader = new FileReader();
				//교체한 파일 정보 불러오기
				reader.onload = function(e) {//기존 파일 속성 변경
					$("#profile_img").attr("src", e.target.result);
				}
				reader.readAsDataURL(f);
			});
		}
		$('#editBtn').click(function() {
			var fm = document.editFrm;
			var data = new FormData(fm);//폼데이터 전송
			//폼의 name값을 이용한 입력정보 체크
			if (!fm.change_nick.value) {
				alert('닉네임을 입력하세요');
				fm.change_nick.focus();
				return false;
			}
// 			if (fm.change_nick.value == fm.info_nick.value) {
// 				alert('기존 닉네임과 동일합니다');
// 				fm.change_nick.focus();
// 				return false;
// 			}
			if (fm.change_nick.value.length > 10) {
				fm.pass.value.focus();
				alert('10자리 이하로 입력하세요');
				return false;
			}
			//중복닉네임 체크 ajax
			$.ajax({
				url : "../class/editInfo.do", //요청할경로
				type : "post", //전송방식
				//contentType : "application/x-www-form-urlencoded;charset:utf-8",
				data : data,
				contentType : false,
				processData : false,
				dataType : "json", //콜백데이터의 형식
				beforeSend : function(xhr){
		            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
		           },
				/*
				콜백데이터 타입이 json이므로 별도의 파싱없이 즉시
				데이터를 읽을수 있다. 만약 json타입이 아니라면
				JSON.Parse()를 호출해야 한다.
				 */
				success : function(d) {
					// 			alert(d.nonick);
					// 			alert(d.editResult);
					if (d.result == 0) {
						$('#result_ajax').text("중복된 닉네임이 있습니다.");
// 						location.reload();
					}
					else{
						alert('프로필수정 성공')
						location.reload();
					}
// 					if (d.key == "성공") {
// 						$('#result_ajax').attr("color", "blue");//이거 맞아여..?
// 						$('#result_ajax').text("회원정보수정 성공");
// 						alert('회원정보 수정 성공');
// 						location.reload();
// 					}
				},
				error : function(e) {//실패콜백메소드
					alert("실패" + e);
				}
			});
			
			$('#myModal').on('hide', function () {
				location.reload();
			});
		});
	</script>
	
	
	<form:form method="post" name="editFrm" enctype="multipart/form-data">
		<table>
			<tr>
				<!-- 파일첨부 만들기 -->
				<td colspan="2" style="text-align: center;"><span class="image">
						<!-- 	                    			<span class="image"> --> 
						<c:choose>
							<c:when test="${info_img eq null }">
								<img id="profile_img"
									src="<%=request.getContextPath()%>/resources/profile_image/user.png"
									alt="프로필 이미지" />
							</c:when>
							<c:otherwise>
								<img id="profile_img"
									src="<%=request.getContextPath()%>/resources/profile_image/${info_img}" alt="프로필 이미지" />
							</c:otherwise>
						</c:choose> 
				</span> <input type="file" name="change_img" id="change_img" />
				 <input type="hidden" name="info_img" value="${info_img }" />
				</td>
			</tr>
			
			<tr>
				<td>닉네임</td>
				<%-- <input type="hidden" name="user_id" vale="${user_id }" /> --%>
				<input type="hidden" name="user_id" value="${user_id }" />
				<input type="hidden" name="info_nick" value="${info_nick }" />
				<%-- 	                    		<input type="hidden" name="info_nick" value="<%=request.getParameter("info_nick")%>"/> --%>
				<td><input type="text" name="change_nick" id="change_nick"
					value="<%=(request.getParameter("info_nick") == null) ? "" : request.getParameter("info_nick")%>" />
					<br />
					<span id="result_ajax" style="color: red;"></span></td>
			</tr>
		</table>

		<!-- Modal footer -->
		<div class="modal-footer" style="text-align: center;">
			<button type="button" id="editBtn">수정하기</button>
		</div>
	</form:form>

</body>
</html>