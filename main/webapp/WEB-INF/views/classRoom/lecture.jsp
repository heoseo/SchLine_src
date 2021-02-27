<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>강의 페이지 </title>
<style>
        #modal {
          display: none;
          position:relative;
          width:100%;
          height:100%;
          z-index:1;
        }
        #modal button {
          display:inline-block;
          width:100px; font-size:12px; 
          margin-left:60%; margin-bottom:10px
         
        }
        
        #modal .modal_layer {
          position:fixed;
          top:0;
          left:0;
          width:100%;
          height:100%;
          background:rgba(0, 0, 0, 0.5);
          z-index:-1;
        }   
</style> 
<!-- 상단 인클루드 -->
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<%@ include file="/resources/include/top.jsp"%>


<!-- body 시작 -->
<body class="is-preload">

<!-- 왼쪽메뉴 include -->
<jsp:include page="/resources/include/leftmenu_classRoom.jsp"/><!-- flag구분예정 -->
<br />
   <div style="text-align: center;">
      <small><span id="opne_btn" style="cursor:pointer; font-size:1.2em">강의 <i class="fas fa-info-circle"></i></span></small><!-- flag구분예정-->
   </div><br />

<div id="modal">
    <div class="modal_content">
    <div>
	    <button type="button" id="close_btn">close</button> 
    </div>
	    <img src="../resources/images/videoPop.png" width="80%"  />           
    </div> 
    <div class="modal_layer">
    </div>
</div>
	<table class="table table-hover table-striped">
				<colgroup>
				<col width="40px"/>
				<col width="40px"/>
				<col width="300"/>
				<col width="100px"/>
			</colgroup>	
			<thead>
				<tr>
					<th class="text-center" style="font-weight:bold;">No</th>
					<th class="text-center" style="font-weight:bold;"></th>
					<th style="font-weight:bold; text-align: left;">제목</th>
					<th class="text-center" style="font-weight:bold;">출석인정일</th>
				</tr>
			</thead>
			<tbody>
	<c:choose>	
	<c:when test="${empty lists }">
 				<tr>
 					<td colspan="6" align="center" height="100">
 						강의영상이 없습니다.
 					</td>
 				</tr>
	</c:when>
	<c:otherwise>
		<c:forEach items="${lists }" var="row">				
				<tr>
					<td class="text-center"><!-- 가상번호 -->
						${row.rnum }. 	
					</td>
					<td class="text-right">
					<img src="../resources/images/lecture_thumbnail.png" class="media-object" style="width:40px;margin-bottom:-5px">
	
					<td class="text-left">
					<a href='javascript:void(0);' onclick="vidOpne('${row.server_saved }',${row.subject_idx },'${row.video_title }',${row.video_idx});">
					${row.video_title }</a>
					</td>
					<td class="text-center">${row.video_end }</td>
				</tr>
		</c:forEach>		
	</c:otherwise>	
</c:choose>
			</tbody>
    </table>
            
            
   <jsp:include page="/resources/include/bottom.jsp" />
</body>
<script>
    document.getElementById("opne_btn").onclick = function() {
        document.getElementById("modal").style.display="block";
    }
   
    document.getElementById("close_btn").onclick = function() {
        document.getElementById("modal").style.display="none";
    }   
</script>
<script>
function vidOpne(saved, sub ,title,vid){
	var url = "../class/play.do?title="+saved+"&sub_idx="+sub+"&name="+title+"&idx="+vid;
	var win = window.open(url, "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=700,height=600");
}

</script>
<!-- 하단 인클루드 -->
<jsp:include page="/resources/include/footer.jsp" />
</html>