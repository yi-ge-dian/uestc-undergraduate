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
            <a class="layui-btn layui-btn-normal add">租赁</a>

            <div class="layui-inline">
                <div class="layui-input-inline">
                  <select id="cid" name="cid">
                    <option value="">请选择车辆</option>
                    <?php if(is_array($carlist)): $i = 0; $__LIST__ = $carlist;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><option value="<?php echo ($vo["id"]); ?>"><?php echo ($vo["chepai"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                  </select>
                </div>
                <div class="layui-input-inline">
                  <select id="sid" name="sid">
                    <option value="">请选择司机</option>
                    <?php if(is_array($sijilist)): $i = 0; $__LIST__ = $sijilist;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><option value="<?php echo ($vo["id"]); ?>"><?php echo ($vo["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                  </select>
                </div>
                <div class="layui-input-inline">
                    <select id="kid" name="kid">
                        <option value="">请选择客户</option>
                        <?php if(is_array($kehulist)): $i = 0; $__LIST__ = $kehulist;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><option value="<?php echo ($vo["id"]); ?>"><?php echo ($vo["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
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
        elem: '#ZulinList',
        url : '/admin.php/Zulin/getList',
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
            {title: '操作', maxWidth:200, templet:'#ZulinListBar',fixed:"right",align:"center",templet:function(d){
                var str = "";
                if (d.status==0) {
                    str += '<a class="layui-btn layui-btn-xs layui-btn-danger" lay-event="tuizu">退租</a>';
                    str += '<a class="layui-btn layui-btn-xs" lay-event="jiesuan">结算</a>';
                    str += '<a class="layui-btn layui-btn-xs layui-btn-normal" lay-event="huanche">还车</a>';
                }

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



    $(".search_btn").click(function(){
        tableIns.reload({
            where:{
                cid:$("#cid").val(),
                sid:$("#sid").val(),
                kid:$("#kid").val()
            }
        });
    })

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


    //列表操作
    table.on('tool(ZulinList)', function(obj){
        var Event = obj.event,
        Data = obj.data;
        if (Event === 'jiesuan') {
            layer.confirm('您确定要结算？',{icon:3,title:'提示信息'},function(index){
                $.get("/admin.php/Zulin/jiesuan",{
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
        if (Event === 'tuizu') {
            layer.confirm('您确定要退租？',{icon:3,title:'提示信息'},function(index){
                $.get("/admin.php/Zulin/tuizu",{
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
        if (Event === 'huanche') {
            layer.confirm('您确定要还车？',{icon:3,title:'提示信息'},function(index){
                $.get("/admin.php/Zulin/huanche",{
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