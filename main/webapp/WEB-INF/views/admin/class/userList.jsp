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
    <div id="wrapper">
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
	               			<form:form role="search" class="app-search hidden-xs">
								<input type="hidden" value=${subject_idx }/>		                            
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
                                            <th>ID</th>
                                            <th>이름</th>
                                            <th>연락처</th>
                                            <th>이메일</th>
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
														<td >${row.virtualNum }</td>
														<td >${row.user_id}</td>
														<td >${row.user_name }</td>
														<td >${row.phone_num }</td>
														<td >${row.email }</td>
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