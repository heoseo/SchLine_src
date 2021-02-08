<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>공부방 </title>
<!-- 상단 인클루드 -->
<%@ include file="/resources/include/top.jsp"%>

<%
Calendar cal = Calendar.getInstance();
int month = cal.get(Calendar.MONTH)+1;//현재월 불러오기
%>
<style>
*{text-align: center;}
/* 프로필 이미지 사진 사이즈 및 모양 설정 */
.image{width: 100%; height: 100%; border-radius: 70%; /* 둥근 이미지 표현 */ overflow: hidden; /*넘치는 속성부분 삭제*/}
#profile{width: 100%; height: 100%; object-fit: cover; /* 이미지 비율 유지한채로 가공 */}
tr td:first-child {font-weight: bold;}
.entry{width: 100%; height: 85%; background-image: url('<%=request.getContextPath() %>/resources/images/pic07.jpg');
		padding: 25px; }
</style>

<script>
function chatWin() {
	//히든폼에 입력된 사용자 정보를 가져오기위해 DOM객체 생성
	var id = document.getElementById("user_id");
	var name = document.getElementById("info_nick");
	var image = document.getElementById("info_img");
	if(name.value==""){
		alert("닉네임 설정 후 입장가능합니다.");
		name.focus();
		return false;
	}
// 	alert("목표공부 시간은?");
	//모달창 띄워서 목표 공부시간 입력할수 있도록 하기(나중에하장 ㅎㅎㅎ...)
	//채팅창으로 이동
// 	location.href="../class/studyRoomChat.do?user_id="+id+"&info_nick="+name+"&info_img="+image;
// 	location.href="../class/studyRoomChat.do";
}
</script>
<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/><!-- flag구분예정 -->
   <div style="text-align: center;">
<!--    		<small>공부방</small> -->
   </div>
   <hr /><!-- 구분자 -->
   
   
   
   <!-- 
	   랭킹 쿼리문 받아오기
	   캘린더 달력활용 년, 달 받아와서 '202101%'로 쿼리 찾아주고
	   그달에 맞는 랭킹 합산해주기
    -->
   
<!-- 페이지 레이아웃 구분 클래스 생성 -->      
<div class="row">
   <div class="col-sm-5">
	<form action="../class/studyRoomChat.do" method="post" onsubmit="return chatWin();">
		<input type="hidden" name="user_id" value="lave"/>
		<input type="hidden" name="info_nick" value="라부"/>
		<input type="hidden" name="info_img" value="<%=request.getContextPath() %>/resources/profile_image/user.png"/>
   		<!-- 사진안에 글씨작성 -->
   		<div class="entry" class="image" style="text-align: left;"><br />
	 		비대면 시대 <br />
	 		함께 공부하는 기분을 낼 수 있는 학생 소통공간입니다. <br />
	 		백색소음과 시간대별로 바뀌는 배경화면, <br />
	 		매달 공부시간을 합산한 랭킹이 공부의욕을 북돋아줄거예요!<br /><br />
	 		<b>우리 함께 공부해요!</b> <br /><br />
	 		<div align="center">
	 			<button>입장하기</button>
<!-- 	 			<a href="../class/studyRoomChat.do"><button>입장하기</button></a> -->
	 		</div>
   		</div>
   	 </form>
   		
   </div>
   <div class="col-sm-3">

   	<table>
   	<tr>
   		<td colspan="2"><%=month %>월 랭킹</td>
   	</tr>
   		<tr>
   			<td>등수</td>
   			<td>닉네임</td>
   		</tr>
   		<tr>
   			<td></td>
   			<td></td>
   		</tr>
   	</table>
   </div>
   
   <div class="col-sm-2">
   <table>
   	<tr>
<!--    		<td><b>프로필</b></td> -->
   		<td style="font-weight: bold;" colspan="2">내 프로필</td>
   	</tr>
   	<tr>
   	<td colspan="2">
	   	<span class="image">
	        <img id="profile" src="<%=request.getContextPath() %>/resources/profile_image/user.png" alt="프로필 이미지" />
	     </span>
	     <br />
	     

			<span style="font-weight: lighter;">닉네임 :&nbsp;
				<input type="hidden" name="info_img" />
				<input type="text" id="user_id" value="lave"/>
				<input type="text" id="info_nick" value="라부" />
				
				</span>
		    <br /><button style="margin-top: 10px;">수정</button>
	</td>
	</tr>
   	<tr><td>누적시간</td><td>100시간</td></tr>
   	<tr><td>랭킹</td><td>1등</td></tr>
   </table>
      <br />
   </div>
</div>

            
   <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>