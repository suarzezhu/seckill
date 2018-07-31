<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%--引入jstl--%>
<%@ include file="common/tag.jsp" %>
<!DOCTYPE html>
<%--create by zhu 2018--%>
<%--引入bootstrap头文件来创建list表--%>
<html lang="zh-CN">
<head>
    <link href="https://cdn.bootcss.com/open-iconic/1.1.1/font/css/open-iconic-bootstrap.css" rel="stylesheet">
    <title>秒杀列表页</title>
    <%--静态包含以一个servlet输出，动态包含每个jsp都需要servlet，--%>
    <%@include file="common/head.jsp" %>
    <style>
        /* Make the image fully responsive */
        .carousel-inner img {
            /*width: 100%;*/
            /*height: 100%;*/
            /*针对图片元素的居中*/
            margin: 0 auto;
            display: block;
        }
    </style>
</head>

<body>

    <header>
        <!-- Fixed navbar -->
        <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
            <a class="navbar-brand" href="#">suarzezhu</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse"
                    aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a id="shouye" class="nav-link" href="#">首页 <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a id="login" class="nav-link" href="#">登陆</a>
                    </li>
                    <li class="nav-item">
                        <a id="join" class="nav-link " href="#">加入我们</a>
                    </li>
                    <li class="nav-item">
                        <a id="detail" class="nav-link" href="#">找点乐子</a>
                    </li>
                </ul>
                <form class="form-inline mt-2 mt-md-0">
                    <input class="form-control mr-sm-2" type="text" placeholder="想找点什么(●'◡'●)" aria-label="Search">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                </form>
            </div>
        </nav>
    </header>
    <%--padding-top是为了离导航栏具有一定的距离使文本 不被覆盖--%>

    <div class="container" style="padding-top:70px">
        <%--<div class="panel panel-default">--%>
        <%--<div class="card-header text-center">--%>
        <%--<h1 class="display-4">秒杀列表</h1>--%>
        <%--</div>--%>
        <%--悬停状态的表格table-hover--%>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>名称</th>
                <th>库存</th>
                <th>开始时间</th>
                <th>结束时间</th>
                <th>创建时间</th>
                <th>详情页</th>
            </tr>
            </thead>
            <tbody>
            <%--这里的c就是引用了tag里的代码--%>
            <c:forEach items="${list}" var="sk">
                <tr>
                    <td>${sk.name}</td>
                    <td>${sk.number}</td>
                    <td><fmt:formatDate value="${sk.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td><fmt:formatDate value="${sk.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td><fmt:formatDate value="${sk.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td><a class="btn btn-info" href="/seckill/${sk.seckillId}/detail" target="_blank">开始秒杀</a></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <%--使用bootstrap4的轮播功能堆美化页面和慕课网上的视频效果存在冲突，以后进行修改，先以bootstrap3为标准--%>
        <div id="seckill" class="carousel slide" data-ride="carousel">
            <!-- 指示符 -->
            <ul class="carousel-indicators">
                <li data-target="#seckill" data-slide-to="0" class="active"></li>
                <li data-target="#seckill" data-slide-to="1"></li>
                <li data-target="#seckill" data-slide-to="2"></li>
            </ul>
            <!-- 轮播图片 -->
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="/resources/img/ipad.jpg">
                </div>
                <div class="carousel-item">
                    <img src="/resources/img/iphonex.jpg">
                </div>
                <div class="carousel-item">
                    <img src="/resources/img/mac.jpg">
                </div>
            </div>
            <!-- 左右切换按钮 -->
            <a class="carousel-control-prev" href="#seckill" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            </a>
            <a class="carousel-control-next" href="#seckill" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
            </a>
        </div>
            <%--网页脚底--%>
            <footer class="pt-4 my-md-5 pt-md-5 border-top">
                <div class="row">
                    <div class="col-12 col-md">
                        <img class="mb-2" src="https://getbootstrap.com/assets/brand/bootstrap-solid.svg" alt="" width="24" height="24">
                        <small class="d-block mb-3 text-muted">© 2017-2018</small>
                    </div>
                    <div class="col-6 col-md">
                        <h5>我们是自己的英雄</h5>
                        <ul class="list-unstyled text-small">
                            <li><a class="text-muted" href="#">蜘蛛侠</a></li>
                            <li><a class="text-muted" href="#">钢铁侠</a></li>
                            <li><a class="text-muted" href="#">蝙蝠侠</a></li>
                            <li><a class="text-muted" href="#">黑豹</a></li>
                            <li><a class="text-muted" href="#">死侍</a></li>
                            <li><a class="text-muted" href="#">金刚狼</a></li>
                        </ul>
                    </div>
                    <div class="col-6 col-md">
                        <h5>去哪里找我们</h5>
                        <ul class="list-unstyled text-small">
                            <li><a class="text-muted" href="#">大理</a></li>
                            <li><a class="text-muted" href="#">成都</a></li>
                            <li><a class="text-muted" href="#">北京</a></li>
                            <li><a class="text-muted" href="#">上海</a></li>
                        </ul>
                    </div>
                    <div class="col-6 col-md">
                        <h5>视频福利</h5>
                        <ul class="list-unstyled text-small">
                            <li><a class="text-muted" href="#">Asian</a></li>
                            <li><a class="text-muted" href="#">Italiana</a></li>
                            <li><a class="text-muted" href="#">America</a></li>
                            <li><a class="text-muted" href="#">France</a></li>
                        </ul>
                    </div>
                </div>
            </footer>
    </div>

</body>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</html>