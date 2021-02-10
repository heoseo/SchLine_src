<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>02Notification/01WebNoti</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="icon"  href="<%=request.getContextPath() %>/resources/images/minicon.png"  type="image">
</head>
<body>
<div class="container">
   <h2>Web Notification01</h2>
   <button onclick="calculate();">버튼을 누르면 1초후에
       WebNotification이 뜹니다</button>
       

   
   <script type="text/javascript">
   //HTML문서가 로드되었을때 Notification를 통해 권한을 확인한다.
   window.onload = function () {
      if(window.Notification){
         Notification.requestPermission();
      }
      else{
         alert("웹노티를 지원하지 않습니다");
      }
   }
   //notify()를 1초 후에 딱 한번 호출한다.
   function calculate() {
      setTimeout(function () { notify(); }, 30000);
   }
   
   /*
   해당 함수가 호출되면 작업표시줄 우측 하단에 알림을 표시한다.
   */
   function notify() {
      if(Notification.permission !== 'granted'){
         alert('웹노티를 지원하지 않습니다');
      }
      else{
         /*
         Notification객체를 생성하여 제목, 내용과 아이콘을 설정한다.
         */
         var notification = new Notification(
            'Title 입니다.',
            {
            	icon: 'https://opgg-com-image.akamaized.net/attach/images/20201218144300.41303.gif',  	
               body: '여긴내용입니다. 클릭하면 KOSMO로 이동합니다.',
         });
         //알림창을 클릭했을때 이동할 URL을 이벤트 핸들러에 등록한다.
         notification.onclick= function () {
            window.open('http://www.ikosmo.co.kr');
         };
      }
   }
   </script>
   <ul>
          <li>웹노티 Browser compatibility -> https://developer.mozilla.org/ko/docs/Web/API/notification</li>
          <li>Chrome, Firefox지원됨. IE지원안됨</li>
   </ul>
</div>
</body>
</html>