<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%--引入jstl--%>
<%@ include file="common/tag.jsp" %>
<!DOCTYPE html>
<%--create by zhu 2018--%>
<%--引入bootstrap头文件来创建list表--%>
<html lang="zh-CN">
<head>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
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
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading text-center">
            <h1 class="display-4">秒杀列表</h1>
        </div>
        <div class="panel-body">
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
                        <td><a class="btn btn-info" href="/seckill/${sk.seckillId}/detail" target="_blank">link</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>
<%--使用bootstrap4的轮播功能堆美化页面--%>

<div id="demo" class="carousel slide" data-ride="carousel">

    <!-- 指示符 -->
    <ul class="carousel-indicators">
        <li data-target="#demo" data-slide-to="0" class="active"></li>
        <li data-target="#demo" data-slide-to="1"></li>
        <li data-target="#demo" data-slide-to="2"></li>
    </ul>

    <!-- 轮播图片 -->
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="http://img.pconline.com.cn/images/upload/upc/tx/pc_best/1803/15/c35/78220065_1521101762347.jpg">
        </div>
        <div class="carousel-item">
            <img src="http://upload.shunwang.com/2013/1101/1383296031168.jpg">
        </div>
        <div class="carousel-item">
            <img src="https://store.storeimages.cdn-apple.com/8750/as-images.apple.com/is/image/AppleInc/aos/published/images/m/bp/mbp13/gray/mbp13-gray-select-201610_GEO_CN?wid=452&hei=420&fmt=jpeg&qlt=95&op_usm=0.5,0.5&.v=1485901251694">
        </div>
    </div>

    <!-- 左右切换按钮 -->
    <a class="carousel-control-prev" href="#demo" data-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </a>
    <a class="carousel-control-next" href="#demo" data-slide="next">
        <span class="carousel-control-next-icon"></span>
    </a>

</div>


<%--Bootstrap 中的许多组件需要依赖 JavaScript 才能运行。
具体来说，他们依赖的是 jQuery、Popper.js 以及我们自己开发的 JavaScript 插件。
具体操作就是将下列 <script> 标签放到页面底部的 </body> 标签之前。
注意顺序，jQuery 必须放在最前面，然后是 Popper.js，最后是我们自己的 JavaScript 插件。--%>
<
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</body>
</html>