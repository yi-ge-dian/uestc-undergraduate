<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <#include "../common/include_css.ftl"/>
    <title>欢迎注册${siteName!""}交易平台</title>
    <link href="/admin/css/bootstrap.min.css" rel="stylesheet">
    <link href="/admin/css/materialdesignicons.min.css" rel="stylesheet">
    <link href="/admin/css/style.min.css" rel="stylesheet">
    <!--对话框-->
    <link rel="stylesheet" href="/admin/js/jconfirm/jquery-confirm.min.css">
</head>
<body>
<body>

<!-- sign up -->
<div class="sign section--full-bg" style="background-image: url(/home/img/login-bg.png);background-size: cover;">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="sign__content">
                    <!-- registration form  action="register" -->
                    <form id="regForm"  method= "post" class="sign__form">
                        <a href="#" class="sign__logo">
                            <h1 style="color: #2ba99d">易 货</h1>
                        </a>

                        <div class="sign__group">
                            <input type="text" class="sign__input required" id="sn" name="sn" placeholder="请输入学号" tips="请填写学号">
                        </div>

                        <div class="sign__group">
                            <input type="password" class="sign__input required" id="password" name="password" placeholder="请输入密码" tips="请填写密码">
                        </div>

                        <div class="sign__group">
                            <input type="password" class="sign__input required" id="password2" name="password2"  placeholder="请重复密码" tips="请再次填写密码">
                        </div>

                        <button class="sign__btn" type="button" id="submit-btn">注册</button>

                        <span class="sign__text">已有账户? <a href="./login">登录</a></span>
                    </form>
                    <!-- registration form -->
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end sign up -->
<#include "../common/include_js.ftl"/>
<script src="/admin/js/jconfirm/jquery-confirm.min.js"></script>
<script src="/admin/js/common.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $("#sn").blur(function(){
            $.ajax({
               type:"POST",
               url:"check_sn",
               data:"sn=" + $("#sn").val(),
               dataType: 'json',
               success:function(res){
                   if(res.data === false){
                       showWarningMsg('用户名已存在!');
                       return false;
                   }
                   else{

                   }
               }
            });
        });

        $("#submit-btn").click(function(){
            //var sqq = /^\d{12}$/;
            //if(sqq.test($('#user-sn').val()) == false)
            if(!checkForm("regForm")){
                return;
            }
            if($('#password2').val() !== $('#password').val()){
                $('#password2').focus();
                showWarningMsg("两次密码不一致");
                return;
            }
            var sn = $("#sn").val();
            var password = $("#password").val();
            $.ajax({
                url:'/home/index/register',
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