<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title><?php echo ($_SESSION['system']['name']); ?>后台系统</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="icon" href="/favicon.ico">
	<!-- <link rel="stylesheet" href="__PUBLIC__/Tongyongcha/layui/css/layui.css" media="all" /> -->
    <link rel="stylesheet" href="__PUBLIC__/Admin/layui-v2/css/layui.css" media="all" />
	<link rel="stylesheet" href="__PUBLIC__/Admin/css/public.css" media="all" />
	<link rel="stylesheet" href="__PUBLIC__/Admin/css/admin.css" media="all" />
</head>
<body class="childrenBody">
	<blockquote class="layui-elem-quote layui-bg-green">
		<div id="nowTime"></div>
	</blockquote>

		<div class="layui-row layui-col-space10">

		<div class="layui-col-lg6 layui-col-md12">
			<blockquote class="layui-elem-quote title">系统基本参数</blockquote>
			<table class="layui-table magt0">
				<colgroup>
					<col width="150">
					<col>
				</colgroup>
				<tbody>
				<tr>
					<td>当前管理人</td>
					<td class="version"><?php echo ($_SESSION['user']['name']); ?></td>
				</tr>
				<tr>
					<td>Url</td>
					<td class="version">https://<?php echo ($_SERVER['SERVER_NAME']); ?>/admin.php/Index/index</td>
				</tr>
				<tr>
					<td>运行环境</td>
					<td class="homePage"><?php echo PHP_OS.' '.$_SERVER['SERVER_SOFTWARE'];?></td>
				</tr>
				<tr>
					<td>网站信息</td>
					<td class="server"><?php echo $_SERVER['SERVER_NAME'].' ( '.$_SERVER['SERVER_ADDR'].':'.$_SERVER['SERVER_PORT'].' )';?></td>
				</tr>
				<tr>
					<td>数据库版本</td>
					<td class="dataBase"><?php echo mysql_get_client_info();?></td>
				</tr>
				<tr>
					<td>最大上传限制</td>
					<td class="maxUpload"><?php echo ini_get('upload_max_filesize');?></td>
				</tr>
				<tr>
					<td>执行时间限制</td>
					<td class="maxUpload"><?php echo ini_get('max_execution_time');?></td>
				</tr>
				<tr>
					<td>剩余空间:</td>
					<td class="userRights"><?php echo round((@disk_free_space(".")/(1024*1024)),2).'M';?></td>
				</tr>
				</tbody>
			</table>
		</div>
		
	</div>

		
	

	<script type="text/javascript" src="__PUBLIC__/Admin/layui/layui.js"></script>
	<script type="text/javascript">
		//获取系统时间
		var newDate = '';
		getLangDate();
		//值小于10时，在前面补0
		function dateFilter(date){
		    if(date < 10){return "0"+date;}
		    return date;
		}
		function getLangDate(){
		    var dateObj = new Date(); //表示当前系统时间的Date对象
		    var year = dateObj.getFullYear(); //当前系统时间的完整年份值
		    var month = dateObj.getMonth()+1; //当前系统时间的月份值
		    var date = dateObj.getDate(); //当前系统时间的月份中的日
		    var day = dateObj.getDay(); //当前系统时间中的星期值
		    var weeks = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
		    var week = weeks[day]; //根据星期值，从数组中获取对应的星期字符串
		    var hour = dateObj.getHours(); //当前系统时间的小时值
		    var minute = dateObj.getMinutes(); //当前系统时间的分钟值
		    var second = dateObj.getSeconds(); //当前系统时间的秒钟值
		    var timeValue = "" +((hour >= 12) ? (hour >= 18) ? "晚上" : "下午" : "上午" ); //当前时间属于上午、晚上还是下午
		    newDate = dateFilter(year)+"年"+dateFilter(month)+"月"+dateFilter(date)+"日 "+" "+dateFilter(hour)+":"+dateFilter(minute)+":"+dateFilter(second);
		    document.getElementById("nowTime").innerHTML = "亲爱的朋友，"+timeValue+"好！ 欢迎使用<?php echo ($_SESSION['system']['name']); ?>后台管理系统。当前时间为： "+newDate+"　"+week;
		    setTimeout("getLangDate()",1000);
		}

		layui.use(['form','element','layer','jquery'],function(){
		    var form = layui.form,
		        layer = parent.layer === undefined ? layui.layer : top.layer,
		        element = layui.element;
		        $ = layui.jquery;
		    //上次登录时间【此处应该从接口获取，实际使用中请自行更换】
		    $(".loginTime").html(newDate.split("日")[0]+"日</br>"+newDate.split("日")[1]);
		    //icon动画
		    $(".panel a").hover(function(){
		        $(this).find(".layui-anim").addClass("layui-anim-scaleSpring");
		    },function(){
		        $(this).find(".layui-anim").removeClass("layui-anim-scaleSpring");
		    })
		    $(".panel a").click(function(){
		        parent.addTab($(this));
		    })

		    $(".qiehuan").click(function(){
		    	var id = $(this)[0].childNodes[0].value;
		    	var index = top.layer.msg('切换中，请稍候',{icon: 16,time:false,shade:0.8});
            	$.ajax({
                      url:'/admin.php/Index/qiehuan',
                      type:'post',           //post提交
                      dataType:"json",        //json格式
                      data:{"id":id},   
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

		    })

		    $("#code").click(function(){
		    	var content = "<div style='display: flex;justify-content: center;flex-wrap: wrap'>"+
                                    "<img src='"+$("#loginUrl").val()+"' style='width:300px;height:300px'>"+
                                    "<div>链接地址： "+$("#loginurl").val()+" </div>"+
                              "</div>";
                layer.open({
                    title: '用户入口二维码',
                    type: 1,
                    area: ["500px","400px"], //宽高
                    content: content
                });
		    })

		  //   $("#fuzhi").click(function(){
		  //   	var loginurl=document.getElementById("loginurl");
				// loginurl.select(); // 选择对象
				// document.execCommand("Copy");
		  //   })


		  	$(".add").click(function(){
		    	var index = layui.layer.open({
		            title : "添加页面",
		            type : 2,
		            content : "/admin.php/Team/add",
		            success : function(layero, index){
		                var body = layui.layer.getChildFrame('body', index);
		                form.render();
		                setTimeout(function(){
		                    layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
		                        tips: 3
		                    });
		                },500)
		            },
		        })

		        layui.layer.full(index);
		        window.sessionStorage.setItem("index",index);
		        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
		        $(window).on("resize",function(){
		            layui.layer.full(window.sessionStorage.getItem("index"));
		        })
		    })

		})
	</script>
</body>
</html>