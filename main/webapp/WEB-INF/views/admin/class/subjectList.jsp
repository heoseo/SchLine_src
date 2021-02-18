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
	               			<form:form role="search" class="app-search hidden-xs" action="/schline/admin/class">
	                
								<select name="searchColumn" class="form-control" style="width:120px; margin-bottom:15px;">
								    <c:if test="${ not empty paramMap}">
									    <option value="subject_name" <c:if test="${paramMap.searchColumn == 'subject_idx'}">selected</c:if>>과목이름</option>
									    <option value="user_name" <c:if test="${paramMap.searchColumn == 'PROFESSOR'}">selected</c:if>>교수</option>
									</c:if>
								</select>
		                            <input name="searchWord" type="text" placeholder="Search..." class="form-control">
		                            	 <a href="/schline/admin/class"><i class="fa fa-search"></i></a>
	                        </form:form>
                         </li>
	                </ul>
                    <div class="col-sm-12">
                        <div class="white-box">
                            <h3 class="box-title">사용자 조회</h3>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>과목</th>
                                            <th>담당교수</th>
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
														<td >${row.subject_idx }</td>
														<td >${row.subject_name}</td>
														<td >${row.user_name }</td>
														<!-- <td class="text-center">--</td> -->
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