<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<title>공부방</title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>


<!-- 
할거정리
1. Ajax : 테마별 배경 및 음악 변경
 -->
<%
Calendar cal = Calendar.getInstance();
int month = cal.get(Calendar.MONTH) + 1;//현재월 불러오기
%>
<style>
* {
	text-align: center;
}
/* 프로필 이미지 사진 사이즈 및 모양 설정 */
.image {
	width: 200px;
	height: 200px;
	border-radius: 70%; /* 둥근 이미지 표현 */
	overflow: hidden; /*넘치는 속성부분 삭제*/
}

#profile {
	width: 100%;
	height: 100%;
	object-fit: cover; /* 이미지 비율 유지한채로 가공 */
}

tr td:first-child {
	font-weight: bold;
}

.entry {
	width: 100%;
	height: 450px;
<%-- 	background-image: url('<%=request.getContextPath()%>/resources/images/pic01.jpg'); background-size : 100% auto; --%>
	padding: 40px;
/* 	padding-left : 80px; */
	padding-top : 60px;
	text-align: center;
}
</style>

<script>
	function chatWin() {
		//히든폼에 입력된 사용자 정보를 가져오기위해 DOM객체 생성
		var id = document.getElementById("user_id");
		var name = document.getElementById("info_nick");
		var image = document.getElementById("info_img");
		if (name.value == "") {
			alert("닉네임 설정 후 입장가능합니다.");
			name.focus();
			return false;
		}
		if("${reported_count }">=10){
			alert("신고횟수 10회이상이라 입장할수 없습니다.");
		}
	}
	//프로필 수정 ajax
	$(function() {
		$.ajax({
			url : "../sudtyRoom/profileAjax.do",
			type : "post",
			data : {
				user_id : $('#user_id').val(),
				info_nick : $('#info_nick').val(),
				info_img : $('#info_img').val()
			},
			beforeSend : function(xhr){
	            xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
	           },
			dataType : "html",
			contentType : "application/x-www-form-urlencoded;charset:utf-8",
			success : function(d) {
				$('.modal-body').html(d);
			},
			error : function(e) {
				alert("오류" + e.status + ":" + e.statusText);
			}
		});
		
		//내 공부방 접속시간 불러오기		
		var myTimeAll = $('#info_time').val();
		var hour = parseInt(myTimeAll/3600);
		var min = parseInt((myTimeAll%3600)/60);
		var sec = parseInt(((myTimeAll%3600)%60)%60);
		$('#MyTimeAll').text(hour+"시간"+min+"분"+sec+"초");
	});
	
	var myTimeAll2;
	var hour2;
	var min2;
</script>
<!-- body 시작 -->
<body class="is-preload">
	<!-- 왼쪽메뉴 include -->
<%-- 	<jsp:include page="/resources/include/leftmenu_classRoom.jsp" /><!-- flag구분예정 --> --%>
<div id="main" class="container-fluid" style="text-align: center;"> 


<!-- 	<div style="text-align: center;"> -->
		<!--    		<small>공부방</small> -->
<!-- 	</div> -->
	<hr />
	<!-- 구분자 -->

	<!-- 
	   랭킹 쿼리문 받아오기
	   캘린더 달력활용 년, 달 받아와서 '202101%'로 쿼리 찾아주고
	   그달에 맞는 랭킹 합산해주기
    -->
	<!-- 페이지 레이아웃 구분 클래스 생성 -->
	<br />
	<div class="container">
	<div class="row">
		<div class="col-sm-5">
			<form:form action="../class/studyRoomChat.do" method="post"
				onsubmit="return chatWin();">
				<!-- 사진안에 글씨작성 -->
				<div class="entry" class="image">
					<br />
					<b>온라인 도서관</b><br /><br />
					 대학친구들과 함께 공부하는 느낌<br />
					 입장하시겠습니까 ?<br /><br />
					<br />
					<div align="center">
						<button>입장하기</button>
						<!-- 	 			<a href="../class/studyRoomChat.do"><button>입장하기</button></a> -->
					</div>
				</div>
				<input type="hidden" id="user_id" name="user_id" value="${sessionScope.user_id }" />
				<input type="hidden" id="info_nick" name="info_nick" value="${info_nick }" />
				<input type="hidden" id="info_img" name="info_img" value="${info_img}" />
			</form:form>
		</div>
		
		
		<div class="col-sm-4">
			<!-- 프로필 -->
			<table style="font-size: 0.8em">
				<tr>
					<!--    		<td><b>프로필</b></td> -->
					<td style="font-weight: bold;" colspan="3">내 프로필</td>
				</tr>
				<tr>
					<td colspan="3"><span class="image"> <c:choose>
								<c:when test="${info_img eq null }">
									<img id="profile"
										src="<%=request.getContextPath()%>/resources/profile_image/user.png"
										alt="프로필 이미지" />
								</c:when>
								<c:otherwise>
									<img id="profile"
										src="<%=request.getContextPath()%>/resources/profile_image/${info_img}" alt="프로필 이미지" />
								</c:otherwise>
							</c:choose>
					</span> <br /> <span style="font-weight: lighter;">닉네임 :&nbsp; ${info_nick } <!-- 				<input type="hidden" name="info_img" /> -->
							<!-- 				<input type="text" id="user_id" value="lave"/> --> <!-- 				<input type="text" id="info_nick" value="라부" /> -->
					</span> <br />
						<button id="editGo" style="margin-top: 10px;" data-toggle="modal"
							data-target="#myModal">수정</button> <!-- Modal 시작 -->
						<div class="modal fade" id="myModal">
							<div
								class="modal-dialog modal-dialog-centered modal-dialog modal-dialog-scrollable">
								<div class="modal-content">
									<div class="modal-header" style="text-align: center;">
										<h4 class="modal-title" style="font-weight: bold;">프로필 수정</h4>
										<button type="button" class="close" data-dismiss="modal">&times;</button>
									</div>
									<!-- Modal body -->
									<div class="modal-body">
										<!-- 여기에 ajax 진행 -->
									</div>
								</div>
							</div></td>
				</tr>
				<tr>
					<td>총 출석일</td>
					<td>
						<c:if test="${info_atten eq null}">
							0
						</c:if>
						<c:if test="${info_atten ne null}">
							 ${info_atten }
						</c:if>
					</td>
				</tr>
				<tr>
					<td>랭킹</td>
					<c:forEach items="${LankList }" var="rank" varStatus="status">
						<c:if test="${rank.user_id eq user_id}">
							<!-- index는 0부터, count는 1부터 시작 -->
							<td>${status.count }</td>
						</c:if>
					</c:forEach>				
				</tr>
				<!-- 신고횟수 -->
				<input type="hidden" name="reported_count" id="reported_count"
				value="${reported_count }" />
				
				<tr>
					<td>누적시간</td>
					<input type="hidden" id="info_time" value="${info_time }" />
					<td id="MyTimeAll"></td>
				</tr>
				<!-- 내 랭킹 불러오기 DAO 필요 -->
			</table>
			<br />

		</div>
		
		
		
		
		
		<div class="col-sm-3">
			<table style="font-size: 0.8em">
				<tr>
<%-- 					<td colspan="3"><%=month%>월 랭킹</td> --%>
					<td colspan="3">랭킹</td>
				</tr>
				<tr style="font-weight: bold;">
					<td>등수</td>
					<td>닉네임</td>
					<td>시간(s)</td>
				</tr>
				<!-- 등수 랭킹 매기기. 10위 까지만 나오도록! -->
				<c:forEach items="${LankList }" var="co" varStatus="status">
				<!-- 작동안함 -->
				<script>
				//랭킹시간
// 				myTimeAll2 = "${rank.info_time }";
// 				hour2 = parseInt(myTimeAll2/3600);
// 				min2 = parseInt((myTimeAll2%3600)/60);
// 				$('#other_time').text(hour2+"시간"+min2+"분");
				</script>
				
					<tr>
						<!-- index는 0부터, count는 1부터 시작 -->
						<td>${status.count }</td>
						<!-- 등수매기기 -->
						<td>${co.info_nick }</td>
						<td><span id="other_time">
							${co.info_time }</span></td>
							<!-- 신고값 히든폼 -->
					</tr>
				</c:forEach>
			</table>
		</div>

		
	</div>

</div>
</div>
<!-- </div> -->
<!-- </div> -->
<%-- 	<jsp:include page="/resources/include/bottom.jsp" /> --%>
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>