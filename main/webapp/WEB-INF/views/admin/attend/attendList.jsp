<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>


<head>
	<%@ include file="/resources/adminRes/include/head.jsp" %>
</head>

<body>
    <!-- Preloader -->
    <div class="preloader">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- 상단 네비 바 -->
        <%@ include file="/resources/adminRes/include/top_nav.jsp" %>
        
        <!-- 왼쪽 메뉴 -->
        <%@ include file="/resources/adminRes/include/leftMenu.jsp" %>
        
        <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
                        <h4 class="page-title">사용자 조회 </h4>
                    </div>
                </div>
                
                
                <div class="row">
                    <div class="col-sm-3">
                    	<ul class="nav navbar-top-links navbar-left m-l-20 hidden-xs">
		                    <li>
		                        <form:form role="search" class="app-search hidden-xs" style="margin-bottom : 10px;">
		                            <input name="searchSubject" type="text" placeholder="Search..." class="form-control">
		                            	 <a href="/schline/admin/attend?searchUser=${paramMap.searchSubject }"><i class="fa fa-search"></i></a>
		                        </form:form>
		                    </li>
		                </ul>
                    </div>
                    <div class="col-sm-9">
                    	<ul class="nav navbar-top-links navbar-left m-l-20 hidden-xs">
		                    <li>
		                        <form:form role="search" class="app-search hidden-xs" style="margin-bottom : 10px;" >
		                            <input name="searchUser" type="text" placeholder="Search..." class="form-control">
		                            	 <a href="/schline/admin/attend?searchUser=${paramMap.searchUser }"><i class="fa fa-search"></i></a>
		                        </form:form>
		                    </li>
		                </ul>
                    </div>
                </div>
				
                <div class="row">
                    <div class="col-sm-3">
                        <div class="white-box">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>과목명</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
											<c:when test="${empty subjectLists }">
												<tr>
													<td colspan="5" class="text-center">
													</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${subjectLists }" var="subject" 
													varStatus="loop">
													<!-- 리스트반복시작 -->
													<tr>
														<td >${subject.subject_idx}</td>
														<td><a href='javascript:window.open("/schline/admin/class/userList?subject_idx=${row.subject_idx}", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=800,height=600")'>${subject.subject_name }</a></td>
													</tr>
													<!-- 리스트반복끝 -->
												</c:forEach>
											</c:otherwise>
										</c:choose>
                                        
                                        <!-- 페이지번호 -->
									<tr >
										<td colspan="5" align="center">${pagingImg }</td>
									</tr>
                                    </tbody>
                                </table>
                                
                                
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-9">
                        <div class="white-box">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>이름</th>
											<th>1</th>
											<th>2</th>
											<th>3</th>
											<th>4</th>
											<th>5</th>
											<th>6</th>
											<th>7</th>
											<th>8</th>
											<th>9</th>
											<th>10</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
											<c:when test="${empty attendLists }">
												<tr>
													<td colspan="5" class="text-center">
													</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${attendLists }" var="attendList" 
													varStatus="loop2">
													<tr>
													<c:forEach items="${attendList }" var="attend" 
													varStatus="loop2">
														<!-- 리스트반복시작 -->
															<c:choose>
																<c:when test="${loop2.count eq 1 }">
																<td >${attend.user_id }</td>
																</c:when>
																<c:when test="${loop2.count eq 2 }">
																<td >${attend.user_name }</td>
																</c:when>
																<c:otherwise>
																<td><a href='javascript:show_pop(${attend.attendance_flag }, ${attend.attendance_idx });'>
																	${attend.attendance_flag }+${attend.attendance_idx }</a></td>
																</c:otherwise>
															</c:choose>
													</c:forEach>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
										
										<!-- The Modal -->
									    <div id="changeModal" class="modal">
									 
									      <!-- Modal content -->
									      <div class="modal-content">
								                <p style="text-align: center; line-height: 1.5;"><span style="font-size: 14pt;">출석 변경</span></p>
									            
									            <form:form name="change_flag_frm" id="change_flag_frm" role="search" class="app-search hidden-xs" >
						                
													<select name="attendance_flag" id="attendance_flag" class="form-control" style="width:120px; margin-bottom:15px;" >
													    <option value="1">O</option>
													    <option value="0">X</option>
													</select>
													
													<input type="hiddesn" id="attendance_idx" name="attendance_idx" value="" />
						                        </form:form>
									            
									            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
									                <span class="pop_bt" style="font-size: 13pt;" >
									                     닫기
									                </span>
									            </div>
									      </div>
									 
									    </div>
									        <!--End Modal-->
									 
									 
									    <script>
									      
									        function show_pop(flag, idx){
									        	if(flag == 1){
									        		$("#attendance_flag").val("1");
									        	}
									        	else if(flag==0){
									        		$("#attendance_flag").val("2");
									        	}
									        	document.getElementById("attendance_idx").value=idx;
									        	console.log("attendance_idx:"+document.getElementById("attendance_idx").value);
									        	$("#changeModal").modal("show");
									        }
									        function close_pop(flag) {
									        	
									        	var sendData  = $('#change_flag_frm').serialize();
									        	alert("sendData : " + sendData);
									        	$.ajax({
									        		url: "/schline/admin/attend/editAttend",
									        		type: "POST",
									        		dataType: "json",
									        		data: sendData ,
									        		contentType : "application/json; charset=utf-8",
									        		beforeSend : function(xhr){
									                    xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
									                   }, 
									        		success: function(result){
									        			$('#changeModal').hide();
							    						location.reload();
									        		}
						        		         });
								        	
									        	
									        };
									        
									      </script>


                                        
                                        <!-- 페이지번호 -->
									<tr >
										<td colspan="5" align="center">${pagingImg }</td>
									</tr>
                                    </tbody>
                                </table>
                                
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
            <footer class="footer text-center"> 2020 &copy; Pixel Admin brought to you by <a
                    href="https://www.wrappixel.com/">wrappixel.com</a> </footer>
        </div>
        <!-- /#page-wrapper -->
    </div>
    <!-- /#wrapper -->
    <!-- jQuery -->
<!--     <script src="resources/adminRes/plugins/bower_components/jquery/dist/jquery.min.js"></script> -->
    <!-- Bootstrap Core JavaScript -->
    
    <%@ include file="/resources/adminRes/include/bottom_script.jsp" %>
     <script type="text/javascript">
//         $(document).ready(function () {
//             $.toast({
//                 heading: 'Welcome to Pixel admin',
//                 text: 'Use the predefined ones, or specify a custom position object.',
//                 position: 'top-right',
//                 loaderBg: '#ff6849',
//                 icon: 'info',
//                 hideAfter: 3500,
//                 stack: 6
//             })
//         });
    </script>
</body>

</html>