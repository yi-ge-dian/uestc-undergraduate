<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <#include "../common/include_css.ftl"/>
    <title>欢迎登录${siteName!""}交易平台</title>
    <link rel="stylesheet" href="/admin/js/jconfirm/jquery-confirm.min.css">
    <link href="/admin/css/bootstrap.min.css" rel="stylesheet">
    <link href="/admin/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="/admin/css/style.min.css" rel="stylesheet">
</head>
<body>
<body>
<!-- sign in -->
<div class="sign section--full-bg" style="background-image: url(/home/img/login-bg.png);background-size: cover;">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="sign__content">
                    <!-- authorization form -->
                    <form action="login" id="logForm" method="post" class="sign__form">
                        <a href="/home/index/index" class="sign__logo">
                            <h1 style="color: #2ba99d">易 货</h1>
                        </a>
                        <div class="sign__group" >
                            <input  type="text" class="sign__input" id="sn" name="sn" placeholder="请输入学号" tips="请填写学号">
                        </div>

                        <div class="sign__group">
                            <input type="password" class="sign__input" id="password" name="password" placeholder="请输入密码" tips="请填写密码">
                        </div>


                        <button class="sign__btn" type="button" id="submit-btn">登录</button>

                        <span class="sign__text">没有帐户? <a href="./signup">注册</a></span>

                    </form>
                    <!-- end authorization form -->
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end sign in -->

<#include "../common/include_js.ftl"/>

<script src="/admin/js/jconfirm/jquery-confirm.min.js"></script>
<script src="/admin/js/common.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        /*$("#sn").blur(function(){
            $.ajax({
                type:"POST",
                url:"check_sn",
                data:"sn=" + $("#sn").val(),
                dataType: 'json',
                success:function(res){
                    if(res.data === true){
                        showWarningMsg('!');
                        return false;
                    }
                    else{
                    }
                }
            });
        });
        */
        $("#submit-btn").click(function(){
            //var sqq = /^\d{12}$/;
            //if(sqq.test($('#user-sn').val()) == false)
            if(!checkForm("logForm")){
                return;
            }
            var sn = $("#sn").val();
            var password = $("#password").val();
            $.ajax({
                url:'/home/index/login',
                type:'POST',
                data:{sn:sn,password:password},
                dataType:'json',
                success:function(data){
                    if(data.code == 0){
                        window.location.href = 'index';
                    }else{
                        showErrorMsg(data.msg);
                    }
                },
                error:function(data){
                    showErrorMsg('网络错误!');
                }
            });
        });
    });
</script>
</body>
</html>