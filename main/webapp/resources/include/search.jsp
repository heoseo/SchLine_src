<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 


<!-- //////검색부분 : 필요한분 쓰세요///////// -->
<div class="row text-right" style="margin-bottom:10px; padding-right:50px;">
<form class="form-inline ml-auto">	
	<div class="form-group">
		<select name="searchColumn" id="searchColumn" class="form-control">
			<option value="title">제목</option>
			<option value="name">작성자</option>
			<option value="content">내용</option>
		</select>
	</div>
	<div class="input-group">
		<input type="text" name="searchWord"  class="form-control" placeholder="검색어를 입력하세요"/>
		<div class="input-group-btn">
			<button type="submit" class="btn btn-default">검색<i class="glyphicon glyphicon-search"></i></button>
		</div>
	</div>
</form>
</div>
<!-- ////////검색 끝////////// -->