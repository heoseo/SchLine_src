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
                
                <!-- 셀렉트 -->
                <select name="user_type" class="form-control" style="width:100px; margin-bottom:15px;">
				    <option value="professor">교수</option>
				    <option value="student">학생</option>
				    <option value="admin">관리자</option>
				</select>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="white-box">
                            <h3 class="box-title">사용자 조회</h3>
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
                                        <tr>
                                            <td>1</td>
                                            <td>Deshmukh</td>
                                            <td>Prohaska</td>
                                            <td>@Genelia</td>
                                            <td>admin</td>
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
    <script src="resources/adminRes/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- Menu Plugin JavaScript -->
    <script src="resources/adminRes/plugins/bower_components/sidebar-nav/dist/sidebar-nav.min.js"></script>
    <!--slimscroll JavaScript -->
    <script src="resources/adminRes/js/jquery.slimscroll.js"></script>
    <!--Wave Effects -->
    <script src="resources/adminRes/js/waves.js"></script>
    <!--Counter js -->
    <script src="resources/adminRes/plugins/bower_components/waypoints/lib/jquery.waypoints.js"></script>
    <script src="resources/adminRes/plugins/bower_components/counterup/jquery.counterup.min.js"></script>
    <!--Morris JavaScript -->
    <script src="resources/adminRes/plugins/bower_components/raphael/raphael-min.js"></script>
    <script src="resources/adminRes/plugins/bower_components/morrisjs/morris.js"></script>
    <!-- Custom Theme JavaScript -->
    <script src="resources/adminRes/js/custom.min.js"></script>
    <script src="resources/adminRes/js/dashboard1.js"></script>
    <script src="resources/adminRes/plugins/bower_components/toast-master/js/jquery.toast.js"></script>
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