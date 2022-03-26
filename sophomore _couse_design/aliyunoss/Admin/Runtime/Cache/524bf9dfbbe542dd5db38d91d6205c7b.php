<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>界面管理</title>
<link rel="stylesheet" href="__PUBLIC__/Admin/layui-v2/css/layui.css" media="all" />
<script type="text/javascript" src="__PUBLIC__/Admin/layui-v2/layui.js"></script>
</head>
<body class="childrenBody">
    <blockquote class="layui-elem-quote quoteBox">
      	<a class="layui-btn layui-btn-normal add">新增</a>
	</blockquote>
	
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
	  <legend>界面节点</legend>
	</fieldset>
	 
	<div id="menu" class="demo-tree"></div>

<script type="text/javascript">
layui.use(['form','tree','layer','laytpl','util'],function(){
    var form = layui.form,
        tree = layui.tree,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        util = layui.util;
        form.render();
    
    var data = [];

    

    $.getJSON("/admin.php/Menu/getList",function(list){
      for (var i = 0; i < list.length; i++) {
        if (list[i].pid==0) {
          var l = {
            id:list[i].id,
            title:list[i].title,
            href:list[i].href,
            sort:list[i].sort,
            pid:list[i].pid,
            icon:list[i].icon,
            spread: true,
            children:jiexi(list,list[i].id)
          };
          data.push(l);
        }
      }

      menu_tree();

    },"json");
      

    //解析tree格式-递归算法
    function jiexi(list,pid){
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
            spread: true,
            children:jiexi(list,list[i].id)
          };
          res.push(l);
        }
      }
      return res;
    }

    //开启节点操作图标
    function menu_tree(){
      tree.render({
          elem: '#menu',
          data: data,
          onlyIconControl: true,
          click: function(obj){
            var Data = obj.data;
            edit(Data);
          }
      });
    }

    $(".add").on("click",function(){
        add();
    });

    function add(){
        var index = layui.layer.open({
            title : "添加页面",
            type : 2,
            area: ['1200px','600px'],
            content : "add.html",
            success : function(layero, index){
                form.render();
                setTimeout(function(){
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            },
        })
    }

    function edit(data){
        var index = layui.layer.open({
            title : "修改页面",
            type : 2,
            area: ['1200px','600px'],
            content : "edit.html?id="+data.id,
            success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                body.find(".icon").val(data.icon);
                form.render();
                setTimeout(function(){
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)
            },
        })
    }

})
</script>
</body>
</html>