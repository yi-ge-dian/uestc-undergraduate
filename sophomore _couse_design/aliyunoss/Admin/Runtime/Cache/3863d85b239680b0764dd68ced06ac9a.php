<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>车辆管理</title>
<link rel="stylesheet" href="__PUBLIC__/Admin/layui-v2/css/layui.css" media="all" />
<link rel="stylesheet" href="__PUBLIC__/Admin/css/all.css" media="all" />
</head>
<body>
    <blockquote class="layui-elem-quote quoteBox">
            <a class="layui-btn layui-btn-normal add">新增</a>
    </blockquote>

    <table id="CarList" lay-filter="CarList"></table>

    <script type="text/html" id="CarListBar">
        <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
        <a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">删除</a>
    </script>


<script type="text/javascript" src="__PUBLIC__/Admin/layui-v2/layui.js"></script>
<script type="text/javascript">
layui.use(['form','layer','table','laytpl','util'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table,
        savetag = null,
        util = layui.util;

    //列表
    var tableIns = table.render({
        elem: '#CarList',
        url : '/admin.php/Car/getList',
        cellMinWidth : 95,
        page : true,
        height : "full-125",
        limit : 20,
        limits : [10,15,20,25],
        id : "CarListTable",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: 'ID', width:100, align:"center"},
            {field: 'name', title: '名称', minWidth:100, align:'center'},
            {field: 'chepai', title: '车牌号', minWidth:100, align:'center'},
            {field: 'classify', title: '车辆类型', minWidth:100, align:'center'},
            {field: 'money', title: '价格', minWidth:100, align:'center'},
            {field: 'paytime', title: '购买时间', minWidth:100, align:'center'},
            {title: '操作', maxWidth:200, templet:'#CarListBar',fixed:"right",align:"center"}
        ]]
    });

    $(".add").on("click",function(){
        add();
    });


    function add(){
        var index = layui.layer.open({
            title : "添加页面",
            type : 2,
            content : "add.html",
            success : function(layero, index){
                form.render();
                setTimeout(function(){
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)

                layui.layer.full(index);
                window.sessionStorage.setItem("index",index);
                //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
                $(window).on("resize",function(){
                    layui.layer.full(window.sessionStorage.getItem("index"));
                })

            },
        })
    }

    function edit(data){
        var index = layui.layer.open({
            title : "修改页面",
            type : 2,
            content : "edit.html?id="+data.id,
            success : function(layero, index){
                var body = layui.layer.getChildFrame('body', index);
                form.render();
                setTimeout(function(){
                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });
                },500)

                layui.layer.full(index);
                window.sessionStorage.setItem("index",index);
                //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
                $(window).on("resize",function(){
                    layui.layer.full(window.sessionStorage.getItem("index"));
                })

            },
        })
    }

    //列表操作
    table.on('tool(CarList)', function(obj){
        var Event = obj.event,
        Data = obj.data;
        if (Event === 'edit') {
            edit(Data);
        }
        if (Event === 'del') {
            layer.confirm('您确定要删除这条信息？',{icon:3,title:'提示信息'},function(index){
                $.get("/admin.php/Car/del",{
                    id : Data.id,
                },function(data){
                    data = JSON.parse(data);
                    if (data.status!=1) {
                        layer.msg(data.info);
                    }else{
                        layer.msg(data.info,{icon:1,time: 500,offset:'t'},function(){
                            tableIns.reload();
                            layer.close(index);
                        });
                    }
                })
            });
        }

    });


})
</script>        
</body>
</html>