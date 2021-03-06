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
																<td>
																<a href='javascript:void(0);' onclick='show_pop(${attend.attendance_flag }, "${attend.attendance_idx }");'>
																	<c:if test="${attend.attendance_flag eq 0 or attend.attendance_flag eq 1 }">X</c:if>
																	<c:if test="${attend.attendance_flag eq 2 }">O</c:if>
																</a>
																</td>
																</c:otherwise>
															</c:choose>
													</c:forEach>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
										
										<!-- The Modal -->
										  <div class="modal" id="changeModal">
										    <div class="modal-dialog">
										      <div class="modal-content">
										      
										      	<p style="text-align: center; line-height: 1.5;"><span style="font-size: 14pt;">출석 변경</span></p>
									            
						                
						                						<select name="attendance_flag" id="attendance_flag" class="form-control" style="width:120px; margin-bottom:15px;" >
																    <option value="2">O</option>
																    <option value="0">X</option>
																</select>
													          <button type="button" class="btn btn-danger" data-dismiss="modal" onClick="close_pop();">Close</button>
													
													
													<input type="hidden" id="attendance_idx" name="attendance_idx" value="" />
										        
										        
										      </div>
										    </div>
										  </div>
										
									 
									 
									    <script>
									      
									        function show_pop(flag, idx){
									        	if(flag == 2){
									        		$("#attendance_flag").val("2");
									        	}
									        	else if(flag==0){
									        		$("#attendance_flag").val("0");
									        	}
									        	document.getElementById("attendance_idx").value=idx;
									        	console.log("attendance_idx:"+document.getElementById("attendance_idx").value);
									        	$("#changeModal").modal("show");
									        }
									        function close_pop(flag) {
									        	
									        	var attendance_flag = document.getElementById("attendance_flag").value;
									        	var attendance_idx = document.getElementById("attendance_idx").value;
									        	
									        	$.ajax({
									        		url: "/schline/admin/attend/editAttend",
									        	    type:"post",
									        	    data : {
									        	   		attendance_flag : attendance_flag,
									        	    	attendance_idx : attendance_idx
									        		},
									        	    beforeSend : function(xhr){
									        	    	xhr.setRequestHeader( "${_csrf.headerName}", "${_csrf.token}" );
									        	    },
									        	    success: function(data){ 
									        	    }
									        	});
							        	    	$('#changeModal').hide();
								    			location.reload();
									        	
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
</body>

</html>