<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%--引入jstl--%>
<%@ include file="common/tag.jsp" %>
<!DOCTYPE html>
<%--create by zhu 2018--%>
<%--引入bootstrap头文件来创建list表--%>
<html lang="zh-CN">
<head>
    <link href="https://cdn.bootcss.com/open-iconic/1.1.1/font/css/open-iconic-bootstrap.css" rel="stylesheet">
    <%--<link rel="stylesheet" type="text/css" href="css/jquery.countdown-2.2.0.css"/>--%>
    <title>秒杀详情页面</title>
    <%@include file="common/head.jsp" %>
</head>
<body>
<%--页面显示层--%>
<div class="container">
    <%--展示倒计时,bootstrap4废弃了wells、thumbnails和panels，使用cards代替--%>
    <div class="card  text-center">
        <div class="card-header">
            <h1>${seckill.name}</h1>

        </div>
        <div class="card-body">
            <h2 class="card-tile">
                <%--这里使用openiconic，bootstrap4不支持自带图标展示time图标 图标属性，图标名字图标可见性--%>
                <span class="oi oi-clock" title="icon time" aria-hidden="true"></span>
                <%--展示倒计时,bootstrap4废弃了wells、thumbnails和panels，使用cards代替--%>

            </h2>
            <div id="seckill-box"></div>
        </div>
    </div>
</div>
<%--登陆弹出层--%>
<div id="killPhoneModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title text-center">
                    <%--电话的图标实现了--%>
                    <span class="oi oi-phone"></span>秒杀电话
                </h3>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-xs-8 col-xs-offset-2">
                        <input type="text" name="killPhone" id="killPhoneKey"
                               placeholder="填手机号(●'◡'●)" class="form-control"/>
                    </div>
                </div>
            </div>
            <%--验证信息--%>
            <div class="modal-footer">
                <%--图标配置--%>
                <span id="killPhoneMessage" class="oi"></span>
                <button type="button" id="killPhoneBtn" class="btn btn-success">
                    <%--电话图标也实现了--%>
                    <span class="oi oi-phone"></span>
                </button>
                提交
            </div>
        </div>
    </div>
</div>
</body>
<%--&lt;%&ndash;jquery的文件，一般在bootstrap前使用&ndash;%&gt;--%>
<%--<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>--%>
<%--<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->--%>
<%--<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"--%>
<%--integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"--%>
<%--crossorigin="anonymous"></script>--%>

<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
<%--jquery倒计时的插件--%>
<script src="https://cdn.bootcss.com/jquery.countdown/2.2.0/jquery.countdown.js"></script>
<script src="/resources/script/seckill.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        //使用el表达式传入参数
        seckill.detail.init({
            seckillId:${seckill.seckillId},
            startTime:${seckill.startTime.time},//毫秒
            endTime:${seckill.endTime.time}
        });
    });
</script>
</html>