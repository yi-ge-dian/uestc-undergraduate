<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html >
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
    <blockquote class="layui-elem-quote layui-quote-nm">
                <a class="layui-btn layui-btn-normal" id="add">Upload</a>
                <i  class="layui-icon layui-inline" style="font-size:20px; color:#009688;left:120px">Those who look up at the starry sky will eventually become the starry sky</i>
                <p class="layui-btn layui-btn-normal" style="float: right" >Dragon Course Design</p>
    </blockquote>
    <table id="List" lay-filter="List"></table>
    <script type="text/javascript" src="__PUBLIC__/Admin/layui-v2/layui.js"></script>
    <script type="text/javascript">
layui.use(['form','layer','table','laytpl','upload','util'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table,
        upload = layui.upload,
        savetag = null,
        util = layui.util;

    //列表的渲染
    var tableIns = table.render({
        elem: '#List',//对应的id选择器
        url : '/admin.php/Index/getlist',//IndexAction.class.php
        cellMinWidth : 95,//单元格最小宽度
        page : true,//自动分页
        height : "full-125",//容器高度
        limit : 10,//每页显示的条数
        limits : [10,15,20,25],//   每页条数的选择项
        id : "ListTable",// 设定容器唯一id
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'name', title: 'file_name', minWidth:100, align:'center'},
            {title: 'Operation', width:400, templet:'#ListBar',fixed:"right",align:"center",templet:function(d){
                var str = "";
                str += '<a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="xiazai">Download</a>';
                str += '<a class="layui-btn layui-btn-xs" lay-event="edit">Rename</a>';
                str += '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="del">Delete</a>';
                return str;
            }}
        ]]
        //表头参数，是一个二维数组
    });

    $("#add").on("click",function(){
        add();
    });

//add函数
    function add(){
        //弹出层
        var index = layui.layer.open({
            title : "Uploadpage",//标题
            type : 2,//iframe层
            area: ['900px','500px'],//大小
            content : "/admin.php/Index/add",//url
            success : function(layero, index){
                form.render();//表单的渲染
                setTimeout(function(){
                    layui.layer.tips('click here to close it', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });//tips层
                },500)
            },//success的回调函数参数layero在第一位，index在第二位。层弹出后的成功回调方法,success会携带两个参数，分别是当前层DOM和当前层索引
        })
    }
//edit函数
    function edit(data){
        //弹出层
        var index = layui.layer.open({
            title : "Rename",//标题
            type : 2,//iframe层
            area: ['900px','500px'],
            content : "/admin.php/Index/edit?name="+data.name,//url
            success : function(layero, index){
                form.render();//表单的渲染
                setTimeout(function(){
                    layui.layer.tips('close here to close it', '.layui-layer-setwin .layui-layer-close', {
                        tips: 3
                    });//tips层
                },500)
            },
        })
    }

    //列表操作,监听事件
    table.on('tool(List)', function(obj){
        var Event = obj.event,
        Data = obj.data;
        if (Event === 'edit') {
            edit(Data);
        }
        if (Event === 'xiazai') {
            window.location.href = "/admin.php/Index/xiazai?name="+Data.name;
        }
        if (Event === 'del') {
            layer.confirm('are you sure to delete this file？',{icon:3,title:'message information',btn: ['sure','cancel']},function(index){
                $.get("/admin.php/Index/del",{
                    name : Data.name,
                },function(data){
                    data = JSON.parse(data);
                    if (data.status!=1) {
                        layer.msg(data.info);
                    }else{
                        layer.msg(data.info,{icon:1,time: 500,offset:'t'},function(){
                            tableIns.reload();
                           layer.close(index);//关闭层
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