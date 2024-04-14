<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>云借阅-图书管理系统</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/webbase.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/setlogin.css"/>
    <%--<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pages-login-manage.css"/>--%>
    <script type="text/javascript" src="/js/jquery-3.7.1.js"></script>
</head>
<body>
<div class="loginmanage">
    <div class="py-container">
        <h4 class="manage-title" style="font-weight: lighter">图书管理系统</h4>
        <div class="loginform">
            <ul class="sui-nav nav-tabs tab-wraped">
                <li class="active">
                    <h3>用户登录</h3>
                </li>
                <h3>
                    <a href="http://localhost:8080/ssmanno/admin/register.html" style="font-weight: lighter">没有账号？点击注册</a>
                </h3>
            </ul>


            <div class="tab-content tab-wraped">
                <%--登录提示信息--%>
                <span style="color: red" class="custom-font-size">${msg}</span>
                <div id="profile" class="tab-pane  active">

                    <form id="loginform" class="sui-form" action="${pageContext.request.contextPath}/login" method="post">

                        <div class="input-prepend" ><span class="add-on loginname">用户名</span>
                            <input type="text" placeholder="企业邮箱" class="span2 input-xfat" name="email">
                        </div>

                        <div class="input-prepend"><span class="add-on loginpwd">密码</span>
                            <input type="password" placeholder="请输入密码" class="span2 input-xfat" name="password">
                        </div>

                        <div class="logined">
                            <%--
                            javascript:document:loginform.submit(); 这是一个js代码片段，用于表单提交，提交一个名为loginform的表单
                            --%>
                            <a class="sui-btn btn-block btn-xlarge btn-danger"
                               href='javascript:document:loginform.submit();' target="_self">登&nbsp;&nbsp;录</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    /**
     * 登录超时 展示区跳出iframe
     * 这段代码的主要目的是防止网页被其他网站通过iframe等方式嵌套，从而提高网站的安全性。
     * 当检测到网页被嵌套时，它会强制将最顶层的窗口重定向到一个登录页面，从而打破这种嵌套。
     */
    var _topWin = window;
    while (_topWin != _topWin.parent.window) {
        _topWin = _topWin.parent.window;
    }
    if (window != _topWin)
        _topWin.document.location.href = '${pageContext.request.contextPath}/admin/login.jsp';

</script>
</html>