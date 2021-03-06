<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>Dragon course design</title>
<link rel="stylesheet" href="__PUBLIC__/Admin/layui-v2/css/layui.css" media="all" />
<link rel="stylesheet" href="__PUBLIC__/Admin/my.css">
<link rel="shortcut icon" href="__PUBLIC__/Admin/favicon.ico">
</head>
<body>
<form id="mainfrom" class="layui-form" style="width:80%;">

  <input type="hidden" name="sname" value="<?php echo ($name); ?>">

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">file_name：</label>
    <div class="layui-input-block">
      <input type="text" name="name" class="layui-input width200 name" id="name" value="<?php echo ($name); ?>" placeholder="file_name：">
    </div>
  </div>

  <div class="layui-form-item layui-row layui-col-xs12">
    <div class="layui-input-block">
      <button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="edit">rename</button>
      <button type="reset" id="reset" class="layui-btn layui-btn-sm layui-btn-primary">cancel</button>
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
        form.on("submit(edit)",function(data){
            var index = top.layer.msg('data is submiting,please wait!!',{icon: 16,time:false,shade:0.8});
                $.ajax({
                      url:'/admin.php/Index/edit',
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
                            //layer.msg('操作失败:服务器处理失败');
                            layer.msg('Saved successfully');
                        }
                });
                
                return false;
        });

        $("#reset").on("click",function(){
            layer.closeAll("iframe");
            parent.location.reload();
        });


})
</script>
       
</body>
</html>