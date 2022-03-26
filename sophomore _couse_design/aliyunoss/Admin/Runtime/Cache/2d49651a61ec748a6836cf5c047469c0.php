<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" href="__PUBLIC__/Admin/layui-v2/css/layui.css" media="all" />
<link rel="stylesheet" href="__PUBLIC__/Admin/css/public.css" media="all" />
<link rel="stylesheet" href="__PUBLIC__/Admin/css/all.css" media="all" />
</head>
<body class="childrenBody">
<form id="mainfrom" class="layui-form" style="width:80%;">
  <input type="hidden" name="id" value="<?php echo ($data["id"]); ?>">

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">账号：</label>
    <div class="layui-input-block">
      <input type="text" name="username" class="layui-input width400 username" value="<?php echo ($data["username"]); ?>" lay-verify="required" placeholder="请输入账号">
    </div>
  </div>

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">密码：</label>
    <div class="layui-input-block">
      <input type="password" name="password" class="layui-input width400 password" value="<?php echo ($data["password"]); ?>" lay-verify="required" placeholder="请输入密码">
    </div>
  </div>

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">姓名：</label>
    <div class="layui-input-block">
      <input type="text" name="name" class="layui-input width200 name" value="<?php echo ($data["name"]); ?>" lay-verify="required" placeholder="请输入姓名">
    </div>
  </div>


    <div class="layui-form-item layui-row layui-col-xs12">
      <label class="layui-form-label">所属：</label>
      <div class="layui-input-block" style="display: flex; align-items: center;">
        <select id="rid" name="rid" lay-filter="multi" disabled="disabled">
            <?php if(is_array($rolelist)): $i = 0; $__LIST__ = $rolelist;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><option value="<?php echo ($vo["id"]); ?>"  <?php if($data['rid'] == $vo['id']): ?>selected='selected'<?php endif; ?>><?php echo ($vo["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
        </select>
      </div>
    </div>
  <input type="hidden" name="rid" value="<?php echo ($data["rid"]); ?>"/>
    <div id="ke"></div>

  <div class="layui-form-item layui-row layui-col-xs12">
    <div class="layui-input-block">
      <button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="edit">立即保存</button>
      <button type="reset" id="reset" class="layui-btn layui-btn-sm layui-btn-primary">取消</button>
    </div>
  </div>

</form>

<script type="text/javascript" src="__PUBLIC__/Admin/layui-v2/layui.js"></script>
<script>
layui.use(['form','layer','layedit','laydate','upload'],function(){
    var form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
        laypage = layui.laypage,
        upload = layui.upload,
        layedit = layui.layedit,
        laydate = layui.laydate,
        $ = layui.jquery;
        
        ke(<?php echo ($data["rid"]); ?>);

        form.on("submit(edit)",function(data){
            
            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
              $.ajax({
                      url:'/admin.php/User/edit',
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

        $("#reset").on("click",function(){
            layer.closeAll("iframe");
            parent.location.reload();
        });

       form.on('select(multi)', function (data) {
         ke(data.value);
      })

  function ke(rid){
     var str = "";
        if (rid==3) {
          str+='<input type="hidden" name="bid" value="<?php echo ($data["bid"]); ?>"/>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">身份证号：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="sfz" class="layui-input width400 sfz" value="<?php echo ($data["info"]["sfz"]); ?>" lay-verify="required" placeholder="请输入身份证号">'
                  +'</div>'
                +'</div>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">司机姓名：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="kname" class="layui-input width200 kname" value="<?php echo ($data["info"]["kname"]); ?>" lay-verify="required" placeholder="请输入司机姓名">'
                  +'</div>'
                +'</div>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">性别：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="sex" class="layui-input width200 sex" value="<?php echo ($data["info"]["sex"]); ?>" lay-verify="required" placeholder="请输入性别">'
                  +'</div>'
                +'</div>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">出生时间：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="date" class="layui-input width200 date" value="<?php echo ($data["info"]["date"]); ?>" lay-verify="required" placeholder="请输入出生时间">'
                  +'</div>'
                +'</div>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">地址：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="address" class="layui-input width400 address" value="<?php echo ($data["info"]["address"]); ?>" lay-verify="required" placeholder="请输入地址">'
                  +'</div>'
                +'</div>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">联系方式：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="phone" class="layui-input width200 phone" value="<?php echo ($data["info"]["phone"]); ?>" lay-verify="required" placeholder="请输入联系方式">'
                  +'</div>'
                +'</div>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">驾驶证号：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="jiashizheng" class="layui-input width200 jiashizheng" value="<?php echo ($data["info"]["jiashizheng"]); ?>" lay-verify="required" placeholder="请输入驾驶证号">'
                  +'</div>'
                +'</div>';
        }
        if (rid==4) {
          str+='<input type="hidden" name="bid" value="<?php echo ($data["bid"]); ?>"/>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">身份证号：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="sfz" class="layui-input width400 sfz" value="<?php echo ($data["info"]["sfz"]); ?>" lay-verify="required" placeholder="请输入身份证号">'
                  +'</div>'
                +'</div>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">客户姓名：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="kname" class="layui-input width200 kname" value="<?php echo ($data["info"]["kname"]); ?>" lay-verify="required" placeholder="请输入客户姓名">'
                  +'</div>'
                +'</div>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">性别：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="sex" class="layui-input width200 sex" value="<?php echo ($data["info"]["sex"]); ?>" lay-verify="required" placeholder="请输入性别">'
                  +'</div>'
                +'</div>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">出生时间：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="date" class="layui-input width200 date" value="<?php echo ($data["info"]["date"]); ?>" lay-verify="required" placeholder="请输入出生时间">'
                  +'</div>'
                +'</div>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">地址：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="address" class="layui-input width400 address" value="<?php echo ($data["info"]["address"]); ?>" lay-verify="required" placeholder="请输入地址">'
                  +'</div>'
                +'</div>';
          str+='<div class="layui-form-item layui-row layui-col-xs12">'
                  +'<label class="layui-form-label">联系方式：</label>'
                  +'<div class="layui-input-block">'
                    +'<input type="text" name="phone" class="layui-input width200 phone" value="<?php echo ($data["info"]["phone"]); ?>" lay-verify="required" placeholder="请输入联系方式">'
                  +'</div>'
                +'</div>';
        }
        $("#ke").html(str);

                form.render();
  }


})
</script>
</body>
</html>