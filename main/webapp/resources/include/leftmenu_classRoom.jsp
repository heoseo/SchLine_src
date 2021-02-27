<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 강의실 왼쪽메뉴 선택바 -->
<style>
#icon {
   font-size: 25px;
   text-align: left;
   padding-left: 5px;
}

#name {
   text-align: center;
   padding-left: 5px;
}

</style>
<div id="main" class="container-fluid">

	<div class="row content">
	<br />
		<div class="col-sm-2 sidenav">
			<br />
			<div class="list-group">
				<a href="/schline/main/class.do" class="list-group-item"> <i
					class="fas fa-chalkboard" id="icon"></i>&emsp;<span
					style="text-align: center;">코스</span>
				</a> <a href="/schline/class/time.do?subject_idx=${param.subject_idx }" class="list-group-item"> 
				<i class="fab fa-youtube"id="icon"></i>&emsp;<span style="text-align: center;"
					id="name">강의</span>

				</a> <a href="/schline/class/teamTask.do?subject_idx=${param.subject_idx }&" class="list-group-item"> <i class="fas fa-users"
					id="icon"></i>&emsp;<span style="text-align: center;">협업</span>
					
				<a href="/schline/class/grade.do?subject_idx=${param.subject_idx }" class="list-group-item">
					<i class="fas fa-file-alt" id="icon"></i>&emsp;
					<span style="text-align: center;" id="name">성적</span>
					
				</a> <a href="/schline/class/examStart.do?subject_idx=${param.subject_idx }&exam_type=2" class="list-group-item"> <i
					class="fas fa-clipboard-check" id="icon"></i>&emsp;<span
					style="text-align: center;" id="name">시험</span>
				</a> 
				
				<a href="/schline/class/taskList.do?subject_idx=${param.subject_idx }&exam_type=1" class="list-group-item"> <i class="fa fa-archive"
					id="icon"></i>&emsp;<span style="text-align: center;"
					id="name">과제함</span>
				</a>


            <div class="dropdown dropright">
               <div class="list-group-item dropdown-toggle" data-toggle="dropdown">
                  <i class="fas fa-table" id="icon"></i>&emsp;<span
                     style="text-align: center;" id="name">게시판</span>
               </div>
               <div class="dropdown-menu">
                  <a class="dropdown-item" href="/schline/penboard/list.do?subject_idx=${param.subject_idx }&board_type=red"><i class="fas fa-edit"></i>&nbsp&nbsp정정게시판</a> 
                  <a class="dropdown-item" href="/schline/penboard/list.do?subject_idx=${param.subject_idx }&board_type=blue"><i class="fas fa-question-circle"></i>&nbsp&nbsp질문게시판</a> 
               </div>
            </div>

			</div>
		</div>
      <br />
<!-- 내용입력부분. 클래스속성 건드리지말것 -->
<div class="col-sm-10">
<div class="container">