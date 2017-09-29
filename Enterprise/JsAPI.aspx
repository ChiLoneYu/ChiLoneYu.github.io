<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JsAPI.aspx.cs" Inherits="Enterprise_JsAPI" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>利用jsapi实现免登</title>
    <script type="text/javascript" src="https://g.alicdn.com/dingding/dingtalk-pc-api/2.7.0/index.js" ></script>
    <script type="text/javascript">

        var _config = {
            appId: '<%=appId%>',
            corpId: '<%=corpId%>',
            timeStamp: '<%=timestamp%>',
            nonce: '<%=nonceStr%>',
            signature: '<%=signature%>'
        };
        

        
        DingTalkPC.config({
            appId: _config.appId,
            corpId: _config.corpId,
            timeStamp: _config.timeStamp,
            nonceStr: _config.nonce,
            signature: _config.signature,
            jsApiList: ['runtime.info',
                'biz.contact.choose',
                'device.notification.confirm',
                'device.notification.alert',
                'device.notification.prompt',
                'biz.ding.post',
            'runtime.permission.requestAuthCode',
            'device.geolocation.get',
            'biz.ding.post',
            'biz.contact.complexChoose']
        });



        DingTalkPC.ready(function () {
            DingTalkPC.runtime.info({
                onSuccess: function (info) {
                    alert("ok:" + JSON.stringify(info));
                },
                Error: function (err) {
                    alert("error:" + JSON.stringify(err));
                }
            });
            //获取免登授权码 -- 注销获取免登服务，可以测试jsapi的一些方法
            DingTalkPC.runtime.permission.requestAuthCode({
                corpId: _config.corpId,
                onSuccess: function (result) {
                    location.href="ServerApi.aspx?code=" + result["code"];
                },
                onFail: function (err) { }

            });



            //这里写一个简单的jsapi的弹用，其它api的调用请参照钉钉开发文档-客户端开发文档
            DingTalkPC.device.notification.alert({
                message: "测试弹窗",
                title: "提示",//可传空
                buttonName: "收到",
                onSuccess: function () {
                    /*回调*/
                },
                onFail: function (err) { }
            });

            DingTalkPC.error(function (err) {
                /*{
                    errorCode: 1001, //错误码
                    errorMessage: '', //错误信息
                }*/
                alert("免登陆失败:" + JSON.stringify(err));
            });


        });
    </script>


</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
