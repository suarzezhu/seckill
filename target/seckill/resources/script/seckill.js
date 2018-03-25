//存放主要的交互逻辑js代码
//javascript模块化
//在js中将project里的模块进行映射
var seckill = {
    // 封装秒杀相关的ajax的url
    URL: {},
    // 验证手机号
    validatephone: function (phone) {
        if (phone && phone.length == 11 && !isNaN(phone)) {
            return true;
        } else {
            return false;
        }

    },
    //详情页的秒杀逻辑
    detail: {
        //详情页初始化
        init: function (params) {
            //手机验证和登陆，计时交互
            //规划我们的交互流程
            //在cookie中查找手机号
            var killPhone = $.cookie('killPhone');
            var startTime = params['startTime'];
            var endTime = params['endTime'];
            var seckillId = params['seckillId'];
            //验证手机号
            if (!seckill.validatephone(killPhone)) {
                //绑定phone
                //控制输出
                var killPhoneModal = $('#killphoneModal');
                //显示弹出层
                killPhoneModal.modal({
                    show: true,//显示弹出层
                    backrop: 'static',//禁止位置关闭
                    keyboard: false//关闭键盘事件
                });
                $('#killPhoneBtn').click(function () {
                    var intputPhone = $('killPhoneKey').val();
                    if (seckill.validatephone(intputPhone)) {
                        //电话写入cookie
                        $.cookie('killPhone', intputPhone, {expires: 7, path: '/seckill'})
                        window.location.reload();
                    } else {
                        $('#killPhoneMessagel').hide().html('<label class="label label-danger">手机号报错</label>').show(300);
                    }
                });
            }
            //已经登陆
        }
    }
}


