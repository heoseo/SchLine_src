<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!--<!-- 상단 인클루드 -->

      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

         <!-- JS파일이 부트스트랩보다 위에 있어야 min.js에러가 안남 -->
         
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
         <link rel="icon"  href="<%=request.getContextPath() %>/resources/images/minicon.png"  type="image">
                  
   
      <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/main.css" />
      <noscript><link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/noscript.css" /></noscript>
   </head>
   
   <!-- 기존 바디 위치 -->

<%

if(session.getAttribute("user_id") != null){
   
   if(!request.getRequestURI().contains("accessDenied")){
   
%>
               <!-- 글 안적을거같으니 일단 주석처리 -->
<!--                <p>Just another free, fully responsive site template<br /> -->
<!--                   built by <a href="https://twitter.com/ajlkn">@ajlkn</a> for <a href="https://html5up.net">HTML5 UP</a>.</p> -->
<!--                </header> -->



   <!-- Wrapper -->
   <div id="wrapper">
   <!-- 상단영역 줄이기 위해 헤더속성 제거 -->
<!-- 네비바 드롭다운 hover 적용 -->
<style>
/*    nav ul li.dropdown:hover > ul.dropdown-menu {display:block; margin:0;} */
   nav ul li.dropdown:hover > div.dropdown-menu {display:block; margin:0;}
  ul > li.active > a { background-color: #3163C9;}
/*  ul > li.active > a { background-color: #ADD8E6;} */
 .nav-item.active .category-txt{ color:white;}
</style>


<script>
$(function(){
/*    var sBtn = $("ul > li");    //  ul > li 이를 sBtn으로 칭한다. (클릭이벤트는 li에 적용 된다.)
   sBtn.find("a").click(function(){   // sBtn에 속해 있는  a 찾아 클릭 하면.
      sBtn.removeClass("active");     // sBtn 속에 (active) 클래스를 삭제 한다.
       $(this).parent().addClass("active"); // 클릭한 a에 (active)클래스를 넣는다.
   }) */
   if(location.pathname.indexOf('class') != -1) {
   $('#classRoom').addClass('active');
   }
   else if(location.pathname.indexOf('schedule') != -1) {
   $('#schedule').addClass('active');
   }
   else if(location.pathname.indexOf('studyRoom') != -1) {
   $('#studyRoom').addClass('active');
   }
   else if(location.pathname.indexOf('user') != -1) {
   $('#user').addClass('active');
   }
})
</script>


<%
//    if(!request.getRequestURI().contains("accessDenied")){
%>
      <!-- Nav -->
      <nav id="nav">

         <ul>
            <li class="nav-item" style="margin-right:50px;">
               <a href="/schline/"><!-- ★★이미지클릭시 home으로 가기. home요청명 적기 -->
                  <img src="<%=request.getContextPath() %>/resources/images/logo.png" width="200px" alt="스쿨라인 로고" />
               </a>
            </li>
               <li class="nav-item" id="classRoom">
               <a href="/schline/main/class.do">
               <span class="category-txt">강의실</span>
               </a>
            </li>
            
             <li class="nav-item" id="schedule">
               <a href="<%=request.getContextPath() %>/schedule/alertList.do?type=allBoard" >
               <span class="category-txt">일정</span>
               </a>
            </li>
            
            <li class="nav-item" id="studyRoom"><a href="<%=request.getContextPath() %>/studyRoom/studyRoom.do">
               <span class="category-txt">공부방</span>
               </a></li>
            <li class="nav-item" id="user"><a href="/schline/user/userinfo.do"><i class="fas fa-user-circle" style="font-size:25px;">
               &nbsp;</i><%=session.getAttribute("user_name") %></a></li>
            <li><a href="javascript:document.logout.submit()">
            <i class="fas fa-sign-out-alt" style="font-size:25px;">&nbsp;</i>
            	<span class="category-txt">로그아웃</span>
            	</a></li>
         </ul>
      </nav>
      
      <form:form method="post"
            action="${pageContext.request.contextPath }/member/logout" name="logout">
      </form:form>
         </ul>
      </nav>
      <br /><br />
         
<%
   }
}
%>      