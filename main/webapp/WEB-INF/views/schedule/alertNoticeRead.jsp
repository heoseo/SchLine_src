<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	
	<!-- 추가한 부트부분 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	

	<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/main.css" />
	<noscript><link rel="stylesheet" href="<%=request.getContextPath() %>/resources/assets/css/noscript.css" /></noscript>
</head>

<style>
#list {
	border-radius: 10px;
    border: solid 1px #A091B7; 
    background: #F7F7F7;
}
#icon {
	text-align: left;
	padding-left: 30px;
}
</style>
<!-- 스타일태그 끝. -->

<!-- 스크립트코드시작 -->
<script>


</script>
</head>
<!-- body 시작 -->
<body class="is-preload">	

	<!-- Wrapper -->
	<div id="wrapper">
		<!-- 메인 로고 이미지 -->
		<div align="center">
		<br />
			<a href="#"><!-- ★★이미지클릭시 home으로 가기. home요청명 적기 -->
				<img src="<%=request.getContextPath() %>/resources/images/logo3.png" width="400px" alt="스쿨라인 로고" />
			</a>
		<br />
		</div>
	<!--
		<hr />
		<div style="text-align: center;">
	 	    <small>알림</small>flag구분예정
	 	</div> 
	-->
	<!-- Form -->
	<form methods="post" action="#" enctype="multipart/form-data"
	id="taskSubmit" onsubmit="return checkTaskFrm()" >
		<section>
			<pre>
				<code>
					<h2 style="font-weight: bold;">화학 3주차 과제</h2>
					<button type="button" class="button primary" id="btnSubmit">제출하기</button>
				</code>
			</pre>
			<h2 style="font-weight: bold;">과제 제출하기</h2>
			
			
			
			<div class="row gtr-uniform">
				<div class="col-12">
					<input type="text" name="name" id="name" value="" placeholder="이름" />
				</div>
				
				<div class="col-4 col-12-xsmall">
					<input type="email" name="email1" id="email1" value="" placeholder="이메일1" />
				</div>
				<span style="font-weight: bold; padding-top: 30px">@</span>
				<div class="col-4 col-12-xsmall">
					<input type="email" name="email2" id="email2" value="" placeholder="이메일2" />
				</div>
				<div class="col-3 col-12-xsmall">
					<select name="select_email" id="select_email" onchange="email(this.value);">
						<option selected="" value="no">선택해주세요</option>
						<option value="직접입력" >직접입력</option>
						<option value="dreamwiz.com" >dreamwiz.com</option>
						<option value="empal.com" >empal.com</option>
						<option value="empas.com" >empas.com</option>
						<option value="freechal.com" >freechal.com</option>
						<option value="hanafos.com" >hanafos.com</option>
						<option value="hanmail.net" >hanmail.net</option>
						<option value="hotmail.com" >hotmail.com</option>
						<option value="intizen.com" >intizen.com</option>
						<option value="korea.com" >korea.com</option>
						<option value="kornet.net" >kornet.net</option>
						<option value="msn.co.kr" >msn.co.kr</option>
						<option value="nate.com" >nate.com</option>
						<option value="naver.com" >naver.com</option>
						<option value="netian.com" >netian.com</option>
						<option value="orgio.co.kr" >orgio.co.kr</option>
						<option value="paran.com" >paran.com</option>
						<option value="sayclub.com" >sayclub.com</option>
						<option value="yahoo.co.kr" >yahoo.co.kr</option>
						<option value="yahoo.com" >yahoo.com</option>
					</select>
				</div>
				
				<div class="col-4 col-12-xsmall">
					<input type="text" name="demo-" id="demo-" value="" placeholder="학번" />
				</div>
				<div class="col-4 col-12-xsmall">
					<input type="text" name="demo-" id="demo-" value="" placeholder="과목명" />
				</div>
				<div class="col-4 col-12-xsmall">
					<input type="email" name="demo-" id="demo-" value="" placeholder="과제명" />
				</div>
				

				<div class="col-12">
					<textarea name="demo-message" id="demo-message" placeholder="과제설명" rows="6"></textarea>
				</div>
				
				<div class="col-6 col-12-xsmall">
					<input type="file" name="attachedfile1" id="demo-"></input>
				</div>
				<div class="col-6 col-12-xsmall">
					<input type="file" name="attachedfile2" id="demo-"></input>
				</div>
				
				<div class="col-6 col-12-xsmall">
					<input type="file" name="attachedfile3" id="demo-"></input>
				</div>
				<div class="col-6 col-12-xsmall">
					<input type="file" name="attachedfile4" id="demo-"></input>
				</div>
				
				<div class="col-12">
					<ul class="actions">
						<li><input type="submit" value="제출하기" class="primary" /></li>
						<li><input type="reset" value="리셋" /></li>
					</ul>
				</div>
			</div>
		</section>
		</form>

</body>
</html>