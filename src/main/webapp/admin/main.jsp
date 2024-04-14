<%--
  Created by IntelliJ IDEA.
  User: lovinyq
  Date: 2024/4/4
  Time: 15:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminLTE.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/_all-skins.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery.min.js">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/bootstrap.js">
    <script src="${pageContext.request.contextPath}/js/axios-0.18.0.js"></script>
    <script type="text/javascript">
        function SetIFrameHeight() {
            var iframeid = document.getElementById("iframe");
            if (document.getElementById) {
                /*设置 内容展示区的高度等于页面可视区的高度*/
                iframeid.height = document.documentElement.clientHeight;
            }
        }
    </script>
</head>


<body class="hold-transition skin-blue-light sidebar-mini">
<div class="wrapper">
    <!-- 页面头部 -->
    <header class="main-header">
        <!-- Logo -->
        <a href="${pageContext.request.contextPath}/admin/main.jsp" class="logo">
            <span class="logo-lg"><b>云借阅-图书管理系统</b></span>
        </a>
        <!-- 头部导航 -->
        <nav class="navbar navbar-static-top">
            <div class="navbar-custom-menu">
                <ul style="list-style-type: none" class="nav navbar-nav">
                    <li style="list-style-type: none; " class="dropdown user user-menu">
                        <a>
                            <img src="${pageContext.request.contextPath}/img/user.jpg" class="user-image" alt="User Image">
                            <span class="hidden-xs">${user_session.name}</span>
                        </a>
                    </li>
                    <li class="dropdown user user-menu" style="display: none">
                        <a href="${pageContext.request.contextPath}/logout">
                            <span class="hidden-xs">注销</span>
                        </a>
                    </li>

                </ul>
            </div>
        </nav>
    </header>

    <!-- 导航侧栏 -->
    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- /.search form -->
            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu">
                <li >
                    <a href="main.jsp">
                        <i class="fa fa-dashboard"></i>
                        <span style="font-size: 20px; font-weight: lighter">首页</span>
                    </a>
                </li>
                <li >
                    <%--target 属性用于指定链接目标打开的位置--%>
                    <a href="${pageContext.request.contextPath}/admin/books.jsp" target="iframe">
                        <span style="font-size: 20px ; font-weight: lighter">图书借阅</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/searchBorrowed" target="iframe">
                        <i class="fa fa-circle-o"></i>
                        <span style="font-size: 20px; font-weight: lighter">当前借阅</span>
                    </a>
                </li>
                <li >
                    <a href="${pageContext.request.contextPath}/admin/record.jsp" target="iframe">
                        <i class="fa fa-circle-o"></i>
                        <span style="font-size: 20px; font-weight: lighter">借阅记录</span>
                    </a>
                </li>
                <li >
                    <a href="${pageContext.request.contextPath}/logout" target="iframe">
                        <i class="fa fa-circle-o"></i>
                        <span style="font-size: 20px; font-weight: lighter">注销</span>
                    </a>
                </li>
            </ul>
        </section>
    </aside>

    <!-- 导航侧栏 /-->
    <!-- 内容展示区域 -->
    <%--<%--<iframe> 标签在 HTML 中用于在当前 HTML 文档中嵌入另一个文档。--%>--%>
    <div class="content-wrapper">
        <iframe width="100%" id="iframe" name="iframe" onload="SetIFrameHeight()"
                frameborder="0" src="${pageContext.request.contextPath}/selectNewBooks"></iframe>
    </div>
</div>
</body>



</html>
