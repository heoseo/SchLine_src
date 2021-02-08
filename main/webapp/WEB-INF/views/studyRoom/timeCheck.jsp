<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>
	//부모창의 form값을 자식창으로 불러와 담아주기
	opener.document.registFrm.user_id.value = document.childFrm.user_id.value;
	opener.document.registFrm.info_nick.value = document.childFrm.info_nick.value;
	opener.document.registFrm.info_img.value = document.childFrm.info_img.value;
 	
	//폼값 전송때문에 모달로 해야할듯..ㅠ.ㅠ
 	$(function () {
 		//시간은 초단위로 전송한다.
 	 	function btn1() {//30분
			$('#study_time').val('1800');
//  	 	document.childFrm.action(); //이거하면 자식창에서 열림
// 			opener.parent.location.href="../class/studyRoomChat.do";
// 			opener.location.href="../class/studyRoomChat.do";
            window.opener.top.프레임이름.location.href="../class/studyRoomChat.do";
            window.close();
			
			self.close();
// 			opener.parent.location='http://tagin.net';
// 			window.close();
 		}
 	 	function btn2() {//1시간
			$('#study_time').val('3600');			
			opener.document.location.href="../class/studyRoomChat.do";
			self.close();

 		}
 	 	function btn3() {//2시간
			$('#study_time').val('7200');			
			opener.document.location.href="../class/studyRoomChat.do";
			self.close();
 		}
 	 	function btn4() {//3시간
			$('#study_time').val('10800');			
			opener.document.location.href="../class/studyRoomChat.do";
			self.close();
 		}
 	 	function btn5() {//6시간
			$('#study_time').val('21600');			
			opener.document.location.href="../class/studyRoomChat.do";
			self.close();
 		}
 	 	function btn6() {//12시간
			$('#study_time').val('43200');	
			opener.document.location.href="../class/studyRoomChat.do";
			self.close();
 		}
	});
</script>

<%-- <form:form id="childFrm" action="../class/studyRoomChat.do" method="post"> --%>
<%-- 	<input type="hidden" id="user_id" name="user_id" value="<%=request.getParameter("user_id") %>" /> --%>
<%-- 	<input type="hidden" id="info_nick" name="info_nick" value="<%=request.getParameter("info_nick") %>" /> --%>
<%-- 	<input type="hidden" id="info_img" name="info_img" value="<%=request.getParameter("info_img") %>" /> --%>
	<table>
		<tr>
			<td>목표 공부시간은?</td>
			<td>
			<button onclick="btn1()">30분</button>
			<button onclick="btn2()">1시간</button>
			<button onclick="btn3()">2시간</button>
			<button onclick="btn4()">3시간</button>
			<button onclick="btn5()">6시간</button>
			<button onclick="btn6()">12시간</button>
			</td>
		</tr>
	</table>
<%-- </form:form> --%>