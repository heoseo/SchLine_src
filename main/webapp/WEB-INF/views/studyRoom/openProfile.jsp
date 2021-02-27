<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

	<link rel="stylesheet"
		href="<%=request.getContextPath()%>/resources/assets/css/noscript.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/assets/css/main.css" />
</head>

<style>
*{text-align: center; vertical-align: middle;}
#list {
	border-radius: 10px;
	border: solid 1px #A091B7;
	background: #F7F7F7;
}

#icon {
	text-align: left;
	padding-left: 30px;
}

#profile_img {
	width: 200px;
	height: 200px%;
	object-fit: cover; /* 이미지 비율 유지한채로 가공 */
}
</style>

	
</head>
<!-- body 시작 -->
<body class="is-preload">
<script>
// 	$(function () {
		function ajaxPro2() {
			$.ajax({
				url : "../class/checkUSer.do",
				dataType : "json",
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset:utf-8",
				beforeSend : function(xhr){
		            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
		           },
			 	data : {
			 		flag : '0',
			 		ot_nick : "${ot.info_nick }",
			 		block_check : "${block_check}"
			 		},
			 	success : function(r){
				 	if(r.check==0){//차단하기 성공시
				 		alert("차단성공");
				 	}
				 	else{alert("차단해제");}
				},
				error : function(e){
					alert("에러"+e);
				}
			});
			location.reload();
		}
// 	});
</script>
	
	
	<!-- Wrapper -->
	<div id="wrapper">
	<!-- 메인 로고 이미지 -->
	<div align="center">
	<br />
	<h2 style="font-weight: bold;"><u>프로필 보기</u></h2>
	</div>
	
<!-- 	<div align="center"> -->
		<table>
			<tr >
				<td  style="text-align: center;">
				<span class="image"> <!-- 	                    			<span class="image"> -->
					<c:choose>
						<c:when test="${ot.info_img  eq null }">
							<img id="profile_img"
								src="<%=request.getContextPath()%>/resources/profile_image/user.png"
								alt="프로필 이미지" />
						</c:when>
						<c:otherwise>
							<img id="profile_img"
								src="<%=request.getContextPath()%>/resources/profile_image/${ot.info_img }"
								alt="프로필 이미지" />
						</c:otherwise>
					</c:choose>
				</span> 
				</td>
				<tr>
					<td style="font-size: 1em;">닉네임 : ${ot.info_nick }</td>
				</tr>
				<tr style="text-align: center;">
					<td>
					<c:if test="${block_check eq 0}">
						<button class="primary ml-auto" onclick="ajaxPro2();" style="background-color: orange;" >
							차단하기
						</button>
					</c:if>
					<c:if test="${block_check eq 1}">
						<button class="primary ml-auto" onclick="ajaxPro2();" >
							차단해제
						</button>
					</c:if>
					</td>
				</tr>
		</table>
<!-- 	</div> -->
	<!-- Form -->
		<form:form method="post" action="" enctype="multipart/form-data">
			<input type="hidden" name="ot_img" value="${ot.info_img }" />
			<input type="hidden" name="ot_nick" value="${ot.info_nick }" />
			<input type="hidden" name="ot_id" value="${ot.user_id }" /><!-- 프로필 보여줄 아이디 -->
			<input type="hidden" name="user_id" value="${sessionScope.user_id }" /><!-- 로그인 회원 아이디 -->
			<input type="hidden" name="block_check" value="${block_check }"/><!-- 차단여부 확인 -->
		</form:form>
		
	
		
</body>
</html>