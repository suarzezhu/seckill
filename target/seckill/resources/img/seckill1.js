//存放主要的交互逻辑js代码
//javascript模块化
//在js中将project里的模块进行映射
var seckill = {
    URL : {
        now : function(){
            return '/seckill/time/now';
        },
        exposer : function(seckillId){
            return '/seckill/'+seckillId+'/exposer';
        },
        execution : function(seckillId, md5){
            return '/seckill' + seckillId + '/' + md5 + '/exection';
        }
    },
    handleSecKill : function(seckillId, node){
        //处理秒杀逻辑
        //生成一个开始秒杀的按钮(在操作节点之前先隐藏节点)
        node.hide().html('<button class="btn btn-primary btn-lg" id="killBtn">开始秒杀</button>');//按钮
        //通过post请求服务器获取秒杀地址
        $.post(seckill.URL.exposer(seckillId), {}, function(result){
            //在回调函数中执行交互流程
            if(result && result['success']) {
                var exposer = result['data'];
                //判断是否开启了秒杀
                if(exposer['exposed']){
                    //开启秒杀
                    //获取秒杀地址
                    var md5 = exposer['md5'];
                    var killUrl = seckill.URL.execution(seckillId, md5);
                    console.log("killUrl:" + killUrl);

                    //绑定一次点击事件，防止用户连续点击秒杀按钮,短时间提交大量同一url请求，造成服务器阻塞
                    $('#killBtn').one('click', function(){
                        //执行秒杀请求
                        //这里的this相当于上句代码$('#killBtn')本身
                        //1:先禁用按钮（变灰）
                        $(this).addClass('disabled');
                        //2:发送秒杀请求执行秒杀
                        $.post(killUrl, {}, function(result){
                            if(result && result['success']){
                                var killResult = result['data'];
                                var state = killResult['state'];
                                var stateInfo = killResult['stateInfo'];
                                //3.显示秒杀结果
                                node.html('<span class="label label-success">' + stateInfo + '</span>');

                            }
                        });
                    });
                    node.show();
                }else{
                    //未开始秒杀(每个用户的计时可能有偏差,有的快有的慢)
                    //从服务器返回结果中获取3个时间(矫正时间)
                    var now = exposer['now'];
                    var start = exposer['start'];
                    var end = exposer['end'];
                    //矫正时间后重新计算计时逻辑
                    seckill.countdown(seckillId, now, start, end);

                }

            }else{
                console.log('result:' + result);
            }

        });

    },
    //验证手机号
    validatePhone : function(phone){
        if(phone && phone.length === 11 && !isNaN(phone)) {
            return true;
        }else{
            return false;
        }
    },
    //倒计时
    countdown : function(seckillId,nowTime,startTime, endTime){
        var seckillBox = $('#seckill-box');
        //时间判断
        if(nowTime > endTime) {
            //秒杀结束
            seckillBox.html('秒杀结束!');
        }else if(nowTime < startTime){
            //秒杀未开始,计时事件绑定(使用的是jquery的计时插件 countdown)
            //开始时间+1秒，防止用户端的计时时间偏移
            //将function作为参数进行调用
            var killTime = new Date(startTime + 1000);
            seckillBox.countdown(killTime,function(event){
                //当时间变化时，格式化输出时间
                var format = event.strftime('秒杀倒计时：%D天 %H时 %M分 %S秒');
                seckillBox.html(format);

                //倒计时结束后的回调事件
            }).on('finish.countdown', function(){
                //获取秒杀地址，控制显示逻辑，执行秒杀
                seckill.handleSecKill(seckillId, seckillBox);
            });
        }else{
            //秒杀开始
            seckill.handleSecKill(seckillId, seckillBox);
        }
    },
    detail : {
        //详情页初始化
        init : function(params) {
            //手机验证和登录，即时交互
            //规划我们的交互流程
            //在cookie中查找手机号
            var killPhone = $.cookie('killPhone');
            //验证手机号
            if(!seckill.validatePhone(killPhone)) {
                //如果没有登录，就绑定手机号
                //获取弹出层，控制它的输出
                var killPhoneModal = $('#killPhoneModal');
                console.log('inputPhone=' + inputPhone);//TODO 使用console调试
                killPhoneModal.modal({
                    show: true,//显示弹出层
                    backdrop: 'static',//禁止位置关闭(点击弹出层之外的区域的话，弹出层也不会关闭)
                    keyboard: false//关闭键盘事件(按ESC键,弹出层也不会关闭)
                });
                //给按钮绑定点击事件
                $('#killPhoneBtn').click(function () {
                    //获取输入的手机号码
                    var inputPhone = $('#killPhoneKey').val();
                    if (seckill.validatePhone(killPhone)) {
                        //电话写入cookie,并且该cookie只在指定的path下才有效
                        $.cookie('killPhone', inputPhone, {expires: 7, path: '/seckill'})
                        //刷新页面
                        window.location.reload();
                    } else {
                        //如果输入的手机号码不合法就提示错误信息
                        $('#killPhoneMessage').hide().html('<label class="label label-danger">手机号码有误!</label>').show(300);
                    }
                });
            }
            //已经登录
            //计时交互
            var startTime = params['startTime'];
            var endTime = params['endTime'];
            var seckillId = params['seckillId'];
            $.get(seckill.URL.now(), {}, function(result){
                if(result && result['success']) {
                    var nowTime = result['data'];
                    //计时服务时间判断
                    seckill.countdown(seckillId,nowTime,startTime,endTime);
                }else{
                    console.log('result:'+result);
                }
            });
        }
    }

}