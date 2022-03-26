<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>界面管理</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" href="__PUBLIC__/Admin/layui-v2/css/layui.css" media="all" />
<link rel="stylesheet" href="__PUBLIC__/Admin/css/public.css" media="all" />
</head>

<body class="childrenBody">
<form id="mainfrom" class="layui-form" style="width:80%;">

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">父模块：</label>
    <div class="layui-input-inline">
      <select class="pid" name="pid">
        <option value="0">无</option>
        <?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><option value="<?php echo ($vo["id"]); ?>"><?php echo ($vo["title"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
      </select>
    </div>
  </div>

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">名称：</label>
    <div class="layui-input-block">
      <input type="text" name="title" class="layui-input title" lay-verify="required" placeholder="请输入名称" style="width: 200px;">
    </div>
  </div>

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">跳转链接：</label>
    <div class="layui-input-block">
      <input type="text" name="href" class="layui-input href" placeholder="请输入跳转链接" style="width: 400px;">
    </div>
  </div>

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">图标：</label>
    <div class="layui-input-block">
      <input type="text" name="icon" class="layui-input icon" lay-verify="required" placeholder="请输入图标" style="width: 200px;">
    </div>
  </div>

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">是否点开：</label>
    <div class="layui-input-inline">
      <select class="spread" name="spread">
        <option value="0">否</option>
        <option value="1">是</option>
      </select>
    </div>
  </div>

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">排序：</label>
    <div class="layui-input-block">
      <input type="number" name="sort" class="layui-input sort" value="0" style="width: 200px;">
      <label>排序数字越小0，越靠前</label>
    </div>
  </div>


  <div class="layui-form-item layui-row layui-col-xs12">
    <div id="tab" class="layui-input-block">
      <button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="add">立即保存</button>
      <button type="reset" id="reset" class="layui-btn layui-btn-sm layui-btn-primary">取消</button>
    </div>
  </div>
</form>

<script type="text/javascript" src="__PUBLIC__/Admin/layui-v2/layui.js"></script>
<script type="text/javascript">
window.onload=function(){
layui.use(['form','layer','layedit','laydate','upload'],function(){
    var form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
        laypage = layui.laypage,
        upload = layui.upload,
        layedit = layui.layedit,
        laydate = layui.laydate,
        $ = layui.jquery;

        form.on("submit(add)",function(data){
          var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
              $.ajax({
                    url:'/admin.php/Menu/add',
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
            //刷新父页面
            parent.location.reload();
        });

})
}
</script>
</body>
</html>