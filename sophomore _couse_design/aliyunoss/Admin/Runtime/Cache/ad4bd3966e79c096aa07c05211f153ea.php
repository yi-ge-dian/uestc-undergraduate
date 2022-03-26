<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改页面</title>

<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="icon" href="__PUBLIC__/Admin/logo.ico">
	<link rel="stylesheet" href="__PUBLIC__/Admin/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="__PUBLIC__/Admin/css/public.css" media="all" />
</head>
<body class="childrenBody">
<form id="mainfrom" class="layui-form layui-row">
	<div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
		<div class="layui-input-block layui-red pwdTips">新密码必须两次输入一致才能提交</div>
		<div class="layui-form-item">
			<label class="layui-form-label">账号</label>
			<div class="layui-input-block">
				<input type="text" name="username" value="<?php echo ($_SESSION['user']['username']); ?>" disabled class="layui-input layui-disabled username">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">旧密码</label>
			<div class="layui-input-block">
				<input type="password" name="password" value="" placeholder="请输入旧密码" class="layui-input password">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">新密码</label>
			<div class="layui-input-block">
				<input type="password" name="passwordl" value="" placeholder="请输入新密码" lay-verify="required|passwordl" id="passwordl" class="layui-input passwordl">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">确认密码</label>
			<div class="layui-input-block">
				<input type="password" name="passwordld" value="" placeholder="请确认密码" lay-verify="required|passwordld" id="passwordld" class="layui-input passwordld">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn" lay-submit="" lay-filter="changePwd">立即修改</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript" src="__PUBLIC__/Admin/layui/layui.js"></script>
<script>
layui.use(['form','layer','laydate','table','laytpl'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laydate = layui.laydate,
        laytpl = layui.laytpl,
        table = layui.table;

    //添加验证规则
    form.verify({
        passwordl : function(value, item){
            if(value.length < 6){
                return "密码长度不能小于6位";
            }
        },
        passwordld : function(value, item){
            if(!new RegExp($("#passwordl").val()).test(value)){
                return "两次输入密码不一致，请重新输入！";
            }
        }
    })

    form.on("submit(changePwd)",function(data){
        
        var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
            $.ajax({
                  url:'/admin.php/Index/updatePwd',
                  type:'post',           //post提交
                  dataType:"json",        //json格式
                  data:$("#mainfrom").serialize(),    
                  success:function(data){

                        if(data.status!=1){

                          layer.msg(data.info);
                          
                        }else{
                            setTimeout(function(){
                                top.layer.close(index);
                                top.layer.msg(data.info);
                                layer.closeAll("iframe");
                                //刷新父页面
                                parent.location.reload();
                            },2000);
                        }
                        
                    },
                    error:function(XmlHttpRequest,textStatus,errorThrown){
                        layer.msg('操作失败:服务器处理失败');
                    }
            });
            
        return false;
        });

    $("body").on("click",".layui-table-body.layui-table-main tbody tr td",function(){
        $(this).find(".layui-table-edit").addClass("layui-"+$(this).attr("align"));
    });

})
</script>
</body>
</html>