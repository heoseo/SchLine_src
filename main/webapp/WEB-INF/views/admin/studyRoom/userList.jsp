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
	                <ul class="nav navbar-top-links navbar-left m-l-20 hidden-xs">
	                    <li>
	               			<form:form role="search" class="app-search hidden-xs" style="margin-bottom:10px;" >
	                
		                            <input name="searchWord" type="text" placeholder="Search..." class="form-control">
		                            	 <a href="/schline/admin/userList?searchColumn=${paramMap.searchColumn }&searchWord=${paramMap.searchWord}"><i class="fa fa-search"></i></a>
	                        </form:form>
                         </li>
	                </ul>
                    <div class="col-sm-12">
                        <div class="white-box">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>이름</th>
                                            <th>닉네임</th>
                                            <th>누적시간</th>
                                            <th>신고 횟수</th>
                                            <th>블랙리스트</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
											<c:when test="${empty listRows }">
												<tr>
													<td colspan="5" class="text-center">
														등록된 게시물이 없습니다 ^^*
													</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${listRows }" var="row" 
													varStatus="loop">
													<!-- 리스트반복시작 -->
													<tr>
														<td >${row.user_id }</td>
														<td >${row.user_name}</td>
														<td >${row.info_nick }</td>
														<td >${row.info_time }</td>
			                                            <td><a href="">${row.reported_count }</a></td>
														<td >
															<c:if test="${row.reported_count >= 10 }">
															<a href='javascript:void(0);' onclick='show_pop("${row.user_id }");'>
															O
															</a>
															</c:if>
														</td>
														<!-- <td class="text-center">--</td> -->
													</tr>
													<!-- 리스트반복끝 -->
												</c:forEach>
											</c:otherwise>
										</c:choose>
                                        
                                        <!-- The Modal -->
									    <div id="changeModal" class="modal">
									 
									      <!-- Modal content -->
									      <div class="modal-content">
								                <p style="text-align: center; line-height: 1.5;"><span style="font-size: 14pt;">차단 해제하시겠습니까?</span></p>
									            
									            <form:form name="change_flag_frm" id="change_flag_frm" role="search" class="app-search hidden-xs" >
						                
													<input type="hidden" id="user_id" name="user_id" value="" />
						                        </form:form>
									            
									            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="yes();">
									                <span class="pop_bt" style="font-size: 13pt;" >
									                     예
									                </span>
									            </div>
									            <div style="cursor:pointer;background-color:#DDDDDD;text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="no();">
									                <span class="pop_bt" style="font-size: 13pt;" >
									                     아니오
									                </span>
									            </div>
									      </div>
									 
									    </div>
									        <!--End Modal-->
									 
									 
									    <script>
									      
									        function show_pop(user_id){
									        	document.getElementById("user_id").value=user_id;
									        	$("#changeModal").modal("show");
									        }
									        function yes(flag) {
									        	
									        	var user_id = document.getElementById("user_id").value;
									        	
									        	$.ajax({
									        		url: "/schline/admin/studyRoom/editBlackList",
									        	    type:"post",
									        	    data : {
									        	    	user_id : user_id
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
									        function no(flag) {
									        	$('#changeModal').hide();
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