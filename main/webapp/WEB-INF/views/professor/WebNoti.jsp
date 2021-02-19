<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>02Notification/01WebNoti</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>

<body>
    <h2>푸시 보내기</h2>
    
   	<form:form  action="./FCMSender.do" method="post">
   	 <input type="text" name="notiTitle" placeholder="알림 타이틀1" /> <br />
   	 <textarea name="notiBody" rows="4" cols="50" placeholder="알림 타이틀2" ></textarea> <br />
   	 <input type="submit" value="보내기" />
    </form:form>
</body>

</body>
 
</html>