<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
   <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
      
<!--       <!-- 추가한 부트부분 -->
<!--       <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> -->
      
<!--         <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
        
      <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/main.css" />
      <noscript><link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/noscript.css" /></noscript>
   </head>
<!-- 강의실 왼쪽메뉴 선택바 -->
<style>
#icon {
   font-size: 20px;
   text-align: left;
}

#hover {
   color: black;
   background: #F7F7F7; 
   text-decoration: underline;
}



.list-group-item.active {
    z-index: 2;
    color: #fff;
    background-color: #a7c3ca;
    border-color: #a7c3ca;
}
</style>
<script>
$(function(){
      if(location.pathname.indexOf('totalTask') != -1) {
      $('#totalTask').addClass('active');
      }
      else if(location.pathname.indexOf('main/class') != -1) {
      $('#mainclass').addClass('active');
      }
   })
</script>
<div id="main" class="container-fluid">
<br />
   <div class="row content">
   <br />
      <div class="col-sm-2 sidenav">
         <div class="list-group">
             <a href="/schline/main/class.do" class="list-group-item" id="mainclass">
                <i class="fas fa-chalkboard" id="icon">&nbsp&nbsp</i>
               <span style="text-align: center;">코스</span>
            </a>
            <a href="/schline/class/totalTask.do" class="list-group-item" id="totalTask">
               <i class="fa fa-archive" id="icon">&nbsp&nbsp</i>
               <!-- 기존거★ -->
<!--                   <span style="text-align: center;">종합과제함</span> -->
               <!-- 드롭다운 테스트 -->
               <span style="text-align: center;">종합과제함</span>
            </a>
         </div>
      </div>
      <br />
<!-- 내용입력부분. 클래스속성 건드리지말것 -->
<div class="col-lg-10">
<div class="container">
   