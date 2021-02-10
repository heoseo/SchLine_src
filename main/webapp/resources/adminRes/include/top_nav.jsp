<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top m-b-0">
            <div class="navbar-header"> <a class="navbar-toggle hidden-sm hidden-md hidden-lg "
                    href="javascript:void(0)" data-toggle="collapse" data-target=".navbar-collapse"><i
                        class="fa fa-bars"></i></a>
                <div class="top-left-part"><a style="margin-left: 20px; margin-bottom: 10px;"class="logo" href="<%=request.getContextPath()%>"><b><img
                                src="resources/images/mini_logo.png" alt="home" /></b></a>
                </div>
                <ul class="nav navbar-top-links navbar-left m-l-20 hidden-xs">
                    <li>
                        <form role="search" class="app-search hidden-xs">
                            <input type="text" placeholder="Search..." class="form-control"> <a href=""><i
                                    class="fa fa-search"></i></a>
                        </form>
                    </li>
                </ul>
                <ul class="nav navbar-top-links navbar-right pull-right">
                    <li>
                        <a class="profile-pic" href="javascript:document.logout.submit()" style="right:10px;"> <b class="hidden-xs">로그아웃</b> </a>
                    </li>
                </ul>
            </div>
			<form:form method="post"
					action="${pageContext.request.contextPath }/member/logout" name="logout">
			</form:form>
            <!-- /.navbar-header -->
            <!-- /.navbar-top-links -->
            <!-- /.navbar-static-side -->
        </nav>