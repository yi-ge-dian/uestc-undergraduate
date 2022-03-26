<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<!-- saved from url=(0044)https://www.layui.com/admin/pro/#/user/login -->
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title><?php echo ($_SESSION['system']['name']); ?>后台系统</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">

  <link rel="icon" href="/favicon.ico">
  <link rel="stylesheet" href="__PUBLIC__/Admin/layui-v2/css/layui.css" media="all">
  <link rel="stylesheet" href="__PUBLIC__/Admin/css/admin.css" media="all">
  <link rel="stylesheet" href="__PUBLIC__/Admin/css/login.css" media="all">

</head>
<body layadmin-themealias="default" class="layui-layout-body">
  <form id="mainForm" method="post">
    <div id="LAY_app" class="layadmin-tabspage-none">
      <div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">

        <div class="layadmin-user-login-main">

          <div class="layadmin-user-login-box layadmin-user-login-header">
            <h2><?php echo ($_SESSION['system']['name']); ?>管理系统</h2>
          </div>

          <div class="layadmin-user-login-box layadmin-user-login-body layui-form">

            <div class="layui-form-item">
              <label class="layadmin-user-login-icon layui-icon layui-icon-username"></label>
              <input type="text" name="username" lay-verify="required" placeholder="账号" class="layui-input">
            </div>

            <div class="layui-form-item">
              <label class="layadmin-user-login-icon layui-icon layui-icon-password"></label>
              <input type="password" name="password" lay-verify="required" placeholder="密码" class="layui-input" >
            </div>

            <div class="layui-form-item">
              <button type="submit" class="layui-btn layui-btn-fluid" lay-filter="manager" lay-submit>登录</button>
            </div>

          </div>
        </div>
    
        <div class="layui-trans layadmin-user-login-footer">
          <p><a href="<?php echo ($_SESSION['system']['footer_url']); ?>" target="_blank"><?php echo ($_SESSION['system']['footer']); ?></a></p>
        </div>
      </div>
    </div>
</form>

<script type="text/javascript" src="__PUBLIC__/Admin/js/jquery.min.js"></script>
<script type="text/javascript" src="__PUBLIC__/Admin/js/jquery.form.js"></script>
<script type="text/javascript" src="__PUBLIC__/Admin/layui/layui.js"></script>
<script type="text/javascript" src="__PUBLIC__/Admin/js/cache.js"></script>
<script type="text/javascript">
  layui.use(['form','layer','jquery'],function(){
      var form = layui.form,
          layer = parent.layer === undefined ? layui.layer : top.layer
          $ = layui.jquery;


      //登录按钮
      form.on("submit(manager)",function(data){
        var f = $(this);
          f.text("登录中...").attr("disabled","disabled").addClass("layui-disabled");
            $('#mainForm').ajaxForm({
                url:"/admin.php/Login/manager",
                type:'post',           //post提交
                dataType:"json",        //json格式
                data:{},    //如果需要提交附加参数，视情况添加
                clearForm: true,        //成功提交后，清除所有表单元素的值
                resetForm: true,        //成功提交后，重置所有表单元素的值
                cache:false,
                async:false,          //同步返回
                success:function(data){

                      if(data.status!=1){

                        layer.msg(data.info);

                      }else{
                        layer.msg(data.info,{icon:1,time: 1000,offset:'t'},function(){
                            window.location.href = data.url;
                        });
                      }
                      f.text("登录").removeAttr("disabled").removeClass("layui-disabled");
                    //服务器端返回处理逻辑
                  },
                  error:function(XmlHttpRequest,textStatus,errorThrown){
                    layer.msg('操作失败:服务器处理失败');
              f.text("登录").removeAttr("disabled").removeClass("layui-disabled");
                  }
            }).submit();
          return false;
      })

      //表单输入效果
      $(".loginBody .input-item").click(function(e){
          e.stopPropagation();
          $(this).addClass("layui-input-focus").find(".layui-input").focus();
      })
      $(".loginBody .layui-form-item .layui-input").focus(function(){
          $(this).parent().addClass("layui-input-focus");
      })
      $(".loginBody .layui-form-item .layui-input").blur(function(){
          $(this).parent().removeClass("layui-input-focus");
          if($(this).val() != ''){
              $(this).parent().addClass("layui-input-active");
          }else{
              $(this).parent().removeClass("layui-input-active");
          }
      })
  })
</script>

</body>
</html>