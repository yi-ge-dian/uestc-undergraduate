<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>权限管理</title>
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

  <input type="hidden" class="hidden" name="method" value="edit">
  <input type="hidden" name="id" value="<?php echo ($data["id"]); ?>">

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">ID：</label>
    <div class="layui-input-block">
      <input type="text" name="id" value="<?php echo ($data["id"]); ?>" class="layui-input id" lay-verify="required" disabled="disabled" style="width:150px;" placeholder="请输入ID">
    </div>
  </div>

  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">名称：</label>
    <div class="layui-input-block">
      <input type="text" name="name" value="<?php echo ($data["name"]); ?>" class="layui-input name" lay-verify="required" style="width:150px;" placeholder="请输入名称">
    </div>
  </div>

  
  <div class="layui-form-item layui-row layui-col-xs12">
    <label class="layui-form-label">权限控制：</label>
    <div class="layui-input-inline">
      <div id="role_menu" class="demo-tree-more"></div>
      <input type="hidden" class="role_menu" name="role_menu"></input>
    </div>
  </div>


  <div class="layui-form-item layui-row layui-col-xs12">
    <div class="layui-input-block">
      <button class="layui-btn layui-btn-sm" lay-submit="" lay-filter="edit">立即保存</button>
      <button type="reset" id="reset" class="layui-btn layui-btn-sm layui-btn-primary">取消</button>
    </div>
  </div>
</form>

<script type="text/javascript" src="__PUBLIC__/Admin/layui-v2/layui.js"></script>
<script type="text/javascript">
window.onload=function(){
layui.use(['form','layer','layedit','laydate','upload','tree'],function(){
    var form = layui.form
        layer = parent.layer === undefined ? layui.layer : top.layer,
        laypage = layui.laypage,
        upload = layui.upload,
        layedit = layui.layedit,
        laydate = layui.laydate,
        tree = layui.tree,
        $ = layui.jquery;
    
    var data = [];

    $.getJSON("/admin.php/Role/getMenuList",{id:$(".id").val(),hidden:$(".hidden").val()},function(list){
      for (var i = 0; i < list.length; i++) {
        if (list[i].pid==0) {
          var l = {
            id:list[i].id,
            title:list[i].title,
            href:list[i].href,
            sort:list[i].sort,
            pid:list[i].pid,
            icon:list[i].icon,
            spread: false,
            children:digui(list,list[i].id)
          };
          data.push(l);
        }
      }
      menu_tree();
    },"json");
      

    //解析tree格式-递归算法
    function digui(list,pid){
      var res = [];
      for (var i = 0; i < list.length; i++) {
        if (pid==list[i].pid) {
          var l = {
            id:list[i].id,
            title:list[i].title,
            href:list[i].href,
            sort:list[i].sort,
            pid:list[i].pid,
            icon:list[i].icon,
            spread: false,
            checked:list[i].checked,
            children:digui(list,list[i].id)
          };
          res.push(l);
        }
      }
      return res;
    }

    //开启节点操作图标
    function menu_tree(){
        tree.render({
            elem: '#role_menu',
            data: data,
            showCheckbox: true,  //是否显示复选框
            id: 'role_menu',
            isJump: true, //是否允许点击节点时弹出新窗口跳转
            click: function(obj){}
        });
    }

        form.on("submit(edit)",function(data){
            var role_menu = tree.getChecked('role_menu');
            JSON.stringify(role_menu);
            role_menu = jiexin(role_menu);
            $(".role_menu").val(role_menu);

            var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
                $.ajax({
                      url:'/admin.php/Role/edit',
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

        function jiexin(role_menu){
            var arr = [];
            for (var i = 0; i < role_menu.length; i++) {
                arr.push(role_menu[i].id);
                for (var j = 0; j < role_menu[i].children.length; j++) {
                    arr.push(role_menu[i].children[j].id);
                }
            }
            return arr;
        }

       
})
}
</script>
</body>
</html>