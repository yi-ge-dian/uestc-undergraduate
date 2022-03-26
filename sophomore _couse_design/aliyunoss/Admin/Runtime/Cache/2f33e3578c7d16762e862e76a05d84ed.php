<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>车辆租赁</title>
<link rel="stylesheet" href="__PUBLIC__/Admin/layui-v2/css/layui.css" media="all" />
<link rel="stylesheet" href="__PUBLIC__/Admin/css/all.css" media="all" />
</head>
<body>
    <blockquote class="layui-elem-quote quoteBox">
        <form class="layui-form">
            <div class="layui-inline">
                <div class="layui-input-inline">
                    <input type="text" name="kaishi" class="layui-input width200 kaishi" id="kaishi" placeholder="开始时间">
                </div>
                <div class="layui-input-inline">
                    <input type="text" name="jieshu" class="layui-input width200 jieshu" id="jieshu" placeholder="结束时间">
                </div>
                <div class="layui-input-inline">
                    <select id="status" name="status">
                        <option value="">全部</option>
                        <option value="1">退租</option>
                        <option value="2">结算</option>
                        <option value="3">还车</option>
                    </select>
                </div>
                <a class="layui-btn search_btn" data-type="reload">搜索</a>
            </div>
        </form>
    </blockquote>

    <table id="ZulinList" lay-filter="ZulinList"></table>

    <script type="text/html" id="ZulinListBar">
    </script>


<script type="text/javascript" src="__PUBLIC__/Admin/layui-v2/layui.js"></script>
<script type="text/javascript">
layui.use(['form','layer','table','laydate','laytpl','util'],function(){
    var form = layui.form,
        layer = parent.layer === undefined ? layui.layer : top.layer,
        $ = layui.jquery,
        laytpl = layui.laytpl,
        table = layui.table,
        laydate = layui.laydate,
        savetag = null,
        util = layui.util;

    //列表
    var tableIns = table.render({
        elem: '#ZulinList',
        url : '/admin.php/Tongji/getList',
        cellMinWidth : 95,
        page : true,
        height : "full-125",
        limit : 20,
        limits : [10,15,20,25],
        id : "ZulinListTable",
        cols : [[
            {type: "checkbox", fixed:"left", width:50},
            {field: 'id', title: 'ID', width:100, align:"center"},
            {field: 'cid', title: '车辆', minWidth:100, align:'center',templet:function(d){
                if(d.carinfo){
                    return d.carinfo.chepai;
                }
                return "未知";
            }},
            {field: 'sid', title: '司机', minWidth:100, align:'center',templet:function(d){
                if(d.sijiinfo){
                    return d.sijiinfo.name;
                }
                return "未知";
            }},

            {field: 'kid', title: '客户', minWidth:100, align:'center',templet:function(d){
                if(d.kehuinfo){
                    return d.kehuinfo.name;
                }
                return "未知";
            }},
            {field: 'money', title: '价格', minWidth:100, align:'center'},
            {field: 'kaishi', title: '开始时间', minWidth:100, align:'center'},
            {field: 'jieshu', title: '结束时间', minWidth:100, align:'center'},

            {field: 'cid', title: '车辆状况', minWidth:100, align:'center',templet:function(d){
                if(d.carinfo){
                    return d.carinfo.zhuangkuang;
                }
                return "未知";
            }},
            {title: '状态', maxWidth:200, templet:'#ZulinListBar',fixed:"right",align:"center",templet:function(d){
                var str = "租赁中";

                if (d.status==1) {
                    str = '已退租';
                }

                if (d.status==2) {
                    str = '已结算';
                }

                if (d.status==3) {
                    str = '已还车';
                }
                return str;
            }}
        ]]
    });

    laydate.render({
      elem: '#kaishi',
      type: 'datetime'
    });
    
    laydate.render({
      elem: '#jieshu',
      type: 'datetime'
    });
    


    $(".search_btn").click(function(){
        tableIns.reload({
            where:{
                kaishi:$("#kaishi").val(),
                jieshu:$("#jieshu").val(),
                status:$("#status").val()
            }
        });
    })

    


})
</script>        
</body>
</html>