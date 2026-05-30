<%@ page import="cn.network.shop.category.CategoryService" %>
<%@ page import="cn.network.shop.category.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.network.shop.product.ProductService" %>
<%@ page import="cn.network.shop.product.Product" %><%-- 查找cookie中是否存有账号和密码 --%>
<%
    String nameValue="";
    String passwordValue="";
    Cookie[] cookies = request.getCookies();
    if(cookies!=null) {
        for (Cookie cookie : cookies) {
            if ("name".equals(cookie.getName())) {
                nameValue = cookie.getValue();
            }
            if ("password".equals(cookie.getName())) {
                passwordValue = cookie.getValue();
            }
        }
    }

    //读分类数据
    List<Category> categories = CategoryService.getCategories();
    request.setAttribute("categories",categories);


    //读商品数据
    Object oProducts = request.getAttribute("products");
    if(oProducts==null) {
        List<Product> products = ProductService.getProducts();
        request.setAttribute("products", products);
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>何熔</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <style>
        body {
            padding-top: 50px;
        }

        #myCarousel img {
            width: 100%;
        }

        /* 商品 */
        ul{
            list-style-type: none;
            padding: 0px;
        }
        
        .big-li{
            float: left;
            width:240px;
            padding: 10px;
            border: 1px solid #ccc;
            margin: 10px 10px 0px 0px;
        }

        .price{
            color:red;
            font-size: 30px;
            font-family: "Arial Black";
        }

        .one-line{
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .big-li>ul>li{
            margin-top: 5px;
        }
    </style>
</head>
<body>
<!-- 导航栏 -->
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#example-navbar-collapse">
                <span class="sr-only">切换导航</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.jsp"><span class="glyphicon glyphicon-shopping-cart"></span> 何熔的网上商城管理系统</a>
        </div>
        <div class="collapse navbar-collapse" id="example-navbar-collapse">
            <ul class="nav navbar-nav">
<%--                <li class="active"><a href="#">男装</a></li>--%>
<%--                <li><a href="#">女装</a></li>--%>
<%--                <li><a href="#">童装</a></li>--%>
                    <c:forEach var="category" items="${categories}">
                        <li><a href="getProductsByCategoryId?categoryId=${category.id}">${category.name}</a></li>
                    </c:forEach>
            </ul>
            <ul class="nav navbar-nav navbar-right">
            <c:choose>
                <c:when test="${user eq null}">
                        <li><a href="#"  data-toggle="modal" data-target="#registerModal"><span class="glyphicon glyphicon-user"></span> 注册</a></li>
                        <li><a href="#" data-toggle="modal" data-target="#loginModal"><span
                                class="glyphicon glyphicon-log-in"></span> 登录</a></li>
                </c:when>
                <c:otherwise>
                    <li style="margin-top: 8px;margin-right: 10px;">
                        <div class="dropdown">
                            <button type="button" class="btn dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown">${user.realName}
                                <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                <li role="presentation">
                                    <a role="menuitem" tabindex="-1" href="logout">注销</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </c:otherwise>
            </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- 轮播 -->
<div id="myCarousel" class="carousel slide">
    <!-- 轮播（Carousel）指标 -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
        <li data-target="#myCarousel" data-slide-to="3"></li>
        <li data-target="#myCarousel" data-slide-to="4"></li>
    </ol>
    <!-- 轮播（Carousel）项目 -->
    <div class="carousel-inner">
        <div class="item active">
            <img src="images/banner1.jpg" alt="First slide">
            <div class="carousel-caption">标题 1</div>
        </div>
        <div class="item">
            <img src="images/banner2.jpg" alt="Second slide">
            <div class="carousel-caption">标题 2</div>
        </div>
        <div class="item">
            <img src="images/banner3.jpg" alt="Third slide">
            <div class="carousel-caption">标题 3</div>
        </div>
        <div class="item">
            <img src="images/banner4.jpg" alt="Third slide">
            <div class="carousel-caption">标题 4</div>
        </div>
        <div class="item">
            <img src="images/banner5.jpg" alt="Third slide">
            <div class="carousel-caption">标题 5</div>
        </div>

    </div>
    <!-- 轮播（Carousel）导航 -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

<!-- 商品  -->
<div class="container">
    <form action="search" method="post">
        <label for="productName">商品名称：</label>
        <input type="text" name="productName" id="productName">
        <button type="submit" class="btn btn-success"><span class="glyphicon glyphicon-search"></span>搜索</button>
    </form>
    <ul>
        <c:forEach var="product" items="${products}">
        <li class="big-li">
            <ul>
                <li><img src="${product.image}" style="width: 200px; height:200px; object-fit: contain;" alt="${product.name}"></li>
                <li class="price">￥${product.price}</li>
                <li class="one-line">${product.name}</li>
                <li><a href="" class="btn btn-default"><span class="glyphicon glyphicon-shopping-cart"></span> 加入购物车</a></li>
            </ul>
        </li>
        </c:forEach>
    </ul>
</div>
<!-- 登录模态框（Modal） -->
<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" role="form" action="login" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">用户登录</h4>
                </div>
                <div class="modal-body">
                    <!-- 登录失败/注册成功时显示相应的信息 -->
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <label style="color: red;">
                                    ${loginErrorText}
                                </label>
                                <label style="color: green;">
                                ${registerSuccessText}
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">账号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="name" name="name" placeholder="请输入账号..." value="<%= nameValue%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="请输入密码..."  value="<%= passwordValue%>">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="rememberMe">请记住我
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">登录</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 注册模态框（Modal） -->
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal" role="form" action="register" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel1">用户注册</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">账号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="name1" name="name" placeholder="请输入账号...">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="password1" name="password"
                                   placeholder="请输入密码...">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="password2" name="password2"
                                   placeholder="请再次输入密码...">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="realName" name="realName" placeholder="请输入姓名...">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">地址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="address" name="address" placeholder="请输入地址...">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">注册</button>
                </div>
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="jquery/jquery.min.js"></script>
<!-- Bootstrap 核心 JavaScript 文件 -->
<script src="bootstrap/js/bootstrap.min.js"></script>

<!-- 调整轮播的速度 -->
<script>
    $('#myCarousel').carousel({
    interval: 1000
    })
</script>

<!-- 登录失败，弹出登录模态框 -->
<%
    if(request.getAttribute("loginErrorText")!=null){
        out.println("<script>$('#loginModal').modal('show');</script>");
    }
%>

<!-- 注册成功，弹出登录模态框 -->
<%
    if(request.getAttribute("registerSuccessText")!=null){
        out.println("<script>$('#loginModal').modal('show');</script>");
    }
%>

<!-- 对注册表单进行数据验证-->
<script>
    //页面加载完成
    $(document).ready(function () {
        //（1）账号要求4~12个字母、数字和下划线的组合。
        $("#name1").blur(function () {   //失去焦点
            if(/^\w{4,12}$/.test($("#name1").val())==false){
                alert("账号必须是4~12个字母、数字和下划线的组合");
            }
        })

         //（2）密码要求6~14个字母、数字和下划线的组合。
        $("#password1").blur(function () {   //失去焦点
            if(/^\w{4,12}$/.test($("#password1").val())==false){
                alert("密码必须是6~14个字母、数字和下划线的组合");
            }
        })

        //（4）两次输入的密码要一致。
        $("#password2").blur(function () {
            if($("#password1").val()!=$("#password2").val()){
                alert("两次输入的密码要一致");
            }
        })

        //（5）姓名至少2个汉字。
        $("#realName").blur(function () {   //失去焦点
            if(/^[\u4E00-\u9FA5]{2,}$/.test($("#realName").val())==false){
                alert("姓名至少2个汉字");
            }
        })
    })
</script>

</body>
</html>
