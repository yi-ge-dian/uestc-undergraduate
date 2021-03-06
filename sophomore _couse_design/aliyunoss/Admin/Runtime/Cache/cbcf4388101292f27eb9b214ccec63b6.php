<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dragon course design</title>
<link rel="stylesheet" href="__PUBLIC__/Admin/layui-v2/css/layui.css" media="all" />
<link rel="stylesheet" href="__PUBLIC__/Admin/my.css">
<link rel="shortcut icon" href="__PUBLIC__/Admin/favicon.ico">
</head>
<body>
    <form id="mainfrom" class="layui-form" style="width:80%;">


  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">file_name：</label>
    <div class="layui-input-block">
      <input type="text" name="name" class="layui-input width200 name" id="name" placeholder="Your file name will be generated automatically, you can rename it later ">
    </div>
  </div>

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">file：</label>
    <div class="layui-input-block">
        <a class="layui-btn" id="wenjian"><i class="layui-icon"></i>please choose your file you want to upload</a>
    </div>
  </div>
  <input type="hidden" id="url" name="url" value="">>
  <div class="layui-form-item layui-row layui-col-xs12">
    <div class="layui-input-block">
      <button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="add">upload</button>
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
        form.on("submit(add)",function(data){
            if($("#url").val()==""){
              layer.msg("please choose your file!!!");
              return false;
            }
            var index = top.layer.msg('data is submiting,please wait!!',{icon: 16,time:false,shade:0.8});
                $.ajax({
                      url:'/admin.php/Index/add',
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
                            layer.msg('Operation failed: server processing failed');
                        }
                });
                
                return false;
        });

        $("#reset").on("click",function(){
            layer.closeAll("iframe");
            parent.location.reload();
        });

        upload.render({
            elem: '#wenjian',
            url: '/admin.php/Upyun/OSSupload',
            accept: 'file',
            done: function(res){
                if (res.status==1) {
                    $("#name").val(res.info.savename);
                    $("#url").val(res.info.url);
                    layer.msg("Already uploaded！！！");
                }
            }
        });

})
</script>

  
</body>
</html>