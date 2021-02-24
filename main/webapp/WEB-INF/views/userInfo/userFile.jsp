<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>코스 페이지 </title>
<!-- 상단 인클루드 -->
<!-- 목록 
사용자 - 개인정보, 설정
수강 과목  - 수강친청 연결, 과목리스트, 과목당 출석여부
성적  - 과목리스트 ->과목별 성적 출력 , 전체성적
-->
<%@ include file="/resources/include/top.jsp"%>


<!-- body 시작 -->
<body class="is-preload">
<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_userInfo.jsp"/><!-- flag구분예정 -->

	<div class="table-wrapper">
		<div style="text-align:center;">
	      <small style="font-size:1.2em; padding-left: 30px;">
	      <i class="fas fa-folder" id="icon">&nbsp&nbsp</i>
	      제출 파일</small>
	    </div>
	    <hr />
		<table class="table table-bordered table-hover table-striped"
		style="font-size:15px;">
			<tr>
				<td style="text-align:center;">No</td>
				<td style="text-align:center;">과목명</td>
				<td style="text-align:center;">제목</td>
				<td style="text-align:center;">작성자</td>
				<td style="text-align:center;">다운로드</td>
			</tr>
			<c:choose>	
				<c:when test="${empty lists }">
	 				<tr>
	 					<td colspan="6" align="center" height="100">
	 						제출한 파일이 없습니다. 
	 					</td>
	 				</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${lists }" var="row">
						<tr>
							<td style="width:8%; text-align:center;">${row.virtualNum }</td>
							<td style="width:10%; text-align:center;">${row.subject_name }</td>
							<td style="text-align:left; padding-left: 20px;">
							<c:if test="${row.board_type eq 'team'}">
							<a href="/schline/class/teamTask.do?subject_idx=${row.subject_idx}">
							${row.board_title }
							</a>
							</c:if>
							<c:if test="${row.board_type eq 'exam'}">
							<a href="/schline/class/taskList.do?subject_idx=${row.subject_idx}&exam_type=${row.exam_type}">
							${row.board_title }
							</a>
							</c:if>
							</td>
							<td style="width:15%; text-align:center;">${row.user_name }</td>
							<td style="width:15%; text-align:center;">
						<c:if test="${not empty row.board_file }">
							<a href="userDownload.do?board_file=${row.board_file }"  style="text-align: center;"><!-- 다운로드 추가 필요 -->
								<i class="fas fa-download"></i>
							</a>
						</c:if>	
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>	
			</c:choose>
		</table>
		
	</div>
 <jsp:include page="/resources/include/bottom.jsp" />
</body>


<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>