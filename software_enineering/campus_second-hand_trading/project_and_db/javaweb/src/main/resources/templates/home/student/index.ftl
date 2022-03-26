<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- CSS -->
	<#include "../common/include_css.ftl"/>
	<#include "../common/top_header.ftl"/>

	<!-- Favicons -->
	<meta name="description" content="">
	<meta name="keywords" content="">
	<meta name="author" content="Dmitry Volkov">
	<title>易货商品</title>
	<style type="text/css">
	.nosee{
		display: none;
	}
	</style>

</head>
<body>

<!-- section -->
<section class="section section--first section--carousel section--bg" data-bg="/home/img/bg.jpg">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<div class="details">
					<div class="details__head">
						<div class="details__cover" id="user_photo">
							<#if barter_student.headPic??>
								<img id="origin_ph"  src="/photo/view?filename=${barter_student.headPic}">
							<#else>
								<img id="origin_ph"  src="/home/student/img/default.png" alt="">
							</#if>
							<input type="file" id="select-file" style="display:none;" onchange="uploadPhoto('origin_ph','headPic')">
							<img id="change_photo" src="/home/student/img/default.png" alt="" style="display: none;">
						</div>

						<div class="details__wrap">
							<h1 class="details__title">个人中心</h1>
							<ul class="requirements__list">
								<li>
								<span id="head" class="nosee">更换头像</span>
								<input type="hidden" id="headPic" name="headPic" value="${barter_student.headPic!""}" tips="请上传图片">
								<input type="file" id="uploadFile" class="nosee">
								</li>
								<li ><span>昵称:</span>
									<span class="span" id="nickname_span">${barter_student.nickname!""}</span>
									<input class="form__input nosee" value="${barter_student.nickname!""}" id="nickname" type="text">
								</li>
								<li><span>手机:</span>
									<span class="span" id="mobile_span">${barter_student.mobile!""}</span>
									<input class="form__input nosee" value="${barter_student.mobile!""}" id="mobile" type="number">
								</li>
								<li><span>QQ:</span>
									<span  class="span" id="qq_span">${barter_student.qq!""}</span>
									<input  class="form__input nosee" value="${barter_student.qq!""}" id="qq" type="number">
								</li>
								<li><span>学院:</span>
									<span class="span" id="academy_span">${barter_student.academy!""}</span>
									<input  class="form__input nosee" value="${barter_student.academy!""}" id="academy" type="text">
								</li>
								<li><span>年级:</span>
									<span class="span" id="grade_span">${barter_student.grade!""}</span>
									<input  class="form__input nosee" value="${barter_student.grade!""}" id="grade" type="text">
								</li>
								<li><span>学校:</span>
									<span class="span" id="school_span">${barter_student.school!""}</span>
									<input  class="form__input nosee" value="${barter_student.school!""}" id="school" type="text">
								</li>
								<button id="edit_info" type="button" class="form__btn">编辑</button>
								<button id="save_info" type="button" class="form__btn nosee">保存</button>
							</ul>

						</div>
					</div>

					<div class="details__content">
						<div class="row">
							<div class="col-12 col-xl-12 order-xl-1">
								<!-- requirements -->


								<div class="requirements">
									<span class="requirements__title">基本信息:</span>
									<ul class="details__list">
										<li><span>账号id:</span> <a href="#">${barter_student.id}</a></li>
										<li><span>账号状态:</span> <a href="#">
												<#if barter_student.status == 1>
													正常
												<#else>冻结
												</#if></a></li>
										<li><span>学号:</span>${barter_student.sn}</li>
									</ul>
								</div>
								<!-- end requirements -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- end section -->
	<!-- section -->
	<section class="section section--carousel">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="section__title-wrap">
						<h2 class="section__title">我发布的商品</h2>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- end section -->
	<br><br><br><br><br><br>
	<!-- section -->
	<#if goodsList??>
		<#list goodsList as goods>
	<section class="section  section--carousel">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="details">
						<div class="details__head">
							<div class="details__cover">
								<img src="/photo/view?filename=${goods.photo}" href="../goods/detail?id=${goods.id}" alt="${goods.name}" >
								<br><br><br>
								<li><span>状态</span>
									<#if goods.status == 1>
										<font style="color:limegreen">正在出售</font>
									<#elseif goods.status == 2>
										<font style="color: red">已下架</font>
									<#else>
										<font style="color: green">已出售</font>
 									</#if>
								</li>
								<li><span>审核状态</span>
									<#if goods.recommend == 1>
										<font style="color: red">审核未通过</font>
									<#elseif goods.recommend == 0>
										<font style="color: green">未审核</font>
									<#else>
										<font style="color: limegreen">审核通过</font>
									</#if>
								</li>

								<li><span>上架日期</span> <a href="#">${goods.createTime}</a></li>
							</div>
							<div class="details__wrap">
								<h1 class="details__title"><a href="../goods/detail?id=${goods.id}" title="${goods.name}">${goods.name}</a></h1>
								<ul class="details__list">
									<p style="overflow: hidden">${goods.content}</p>
								</ul>
							</div>
						</div>
						<div class="details__content">
							<div class="details__stat">
								<#if goods.status == 2><!--已下架 -->

								<#else>
										<#if goods.status == 3>
										<#else>
											<a href="edit_goods?id=${goods.id}">
												<button type="button" class="form__btn">编辑</button>
											</a>
										</#if>
										<#if goods.status == 1>
											<button type="button" class="form__btn" onclick="offshelf(${goods.id})">下架</button>
										<#elseif goods.status == 2>
											<button type="button" class="form__btn" onclick="onshelf(${goods.id})">上架</button>
										</#if>
										<#if goods.status == 1>
											<button type="button" class="form__btn" onclick="sellout(${goods.id})">确认售出</button>
										<#elseif goods.status == 3>
											<button type="button" class="form__btn">已售出</button>
										</#if>
								</#if>
								<button type="button" class="form__btn" onclick="del(${goods.id})">删除</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	</#list>
	</#if>
	<!-- end section -->

	<#include "../common/include_js.ftl"/>
	<script type="text/javascript">
		$("#uploadFile").change(function () {
			uploadPhoto('origin_ph','headPic');
		});

		function uploadPhoto(showPictureImg,input) {
			var formData=new FormData();
			formData.append('photo',document.getElementById('uploadFile').files[0]);
			$.ajax({
				url:'/home/upload/upload_photo',
				contentType:false,
				processData:false,
				data:formData,
				type:'POST',
				success:function (data) {
					$('.loading').addClass("hide")
					if (data.code==0){
						$("#show-img").show();
						$("#"+showPictureImg).attr('src','/photo/view?filename='+data.data);
						$("#"+input).val(data.data);
					}else{
						//data=$.parseJSON(data);
						showWarningMsg(data.msg);
					}
				},
				error:function (data) {
					showWarningMsg("网络错误")
				}
			})
		}
		function refresh(id,flag){
			ajaxRequest('update_flag','post',{"id":id,"flag":flag},function () {
				if(flag==1){
					showWarningMsg("恭喜，已顶");
				}
				else{
					showWarningMsg("取消顶")
				}
				location.reload()
			})
		}

		function offshelf(id){

			$.confirm({
				title: '确定下架？',
				content: '下架后不可重新上架，请慎重！',
				buttons: {
					confirm: {
						text: '确认',
						action: function(){
							ajaxRequest('update_status','post',{"id":id,"status":2},function () {
								showConfirmSuccessMsg("您已成功下架商品");
							})
						}
					},
					cancel: {
						text: '关闭',
						action: function(){
							return;
						}
					}
				}
			});
		}

		function onshelf(id){

			ajaxRequest('update_status','post',{"id":id,"status":1},function () {
				showConfirmSuccessMsg("您已成功上架商品");
			})
		}

		function sellout(id){
			if(!confirm('是否确认售出？')){
				return;
			}
			ajaxRequest('update_status','post',{"id":id,"status":3},function () {
				showConfirmSuccessMsg("您已成功售出商品");
			})
		}
		$(document).ready(function() {
			$("#edit_info").bind('click',function () {
				$("#edit_info").css({
					display:"none"
				});
				$("#save_info").css({
					display:"block"
				});
				$(".form__input").css({
					display:"block"
				});
				$(".span").css({
					display:"none"
				});
				$("#uploadFile").css({
					display:"block"
				});
				$("#head").css({
					display:"block"
				});
			});

				$("#save_info").bind('click', function () {
					var nickname = $("#nickname").val(),
							mobile = $("#mobile").val(),
							qq = $("#qq").val(),
							academy = $("#academy").val(),
							grade = $("#grade").val(),
							school = $("#school").val(),
							headPic= $("#headPic").val();
					if (mobile.length != 11){
						showWarningMsg("手机号长度出错");
						return;
					}
					$.ajax({
						url: 'edit_info',
						type: 'POST',
						data: {
							headPic:headPic,
							nickname: nickname,
							qq: qq,
							mobile: mobile,
							academy: academy,
							grade: grade,
							school: school,
						},
						dataType: 'json',
						success: function (data) {
							if (data.code == 0) {
								$("#qq_span").text(qq);
								$("#mobile_span").text(mobile);
								$("#nickname_span").text(nickname);
								$("#academy_span").text(academy);
								$("#grade_span").text(grade);
								$("#school_span").text(school);
								$("#save_info").css({
									display: "none"
								});
								$("#edit_info").css({
									display:"block"
								});
								$(".form__input").css({
									display:"none"
								});
								$(".span").css({
									display:"inline"
								});
								$("#uploadFile").css({
									display:"none"
								});
								$("#head").css({
									display:"none"
								});
							} else {
								showWarningMsg(data.msg);
							}
							showConfirmSuccessMsg("成功保存");
						},
						error: function (data) {
							showWarningMsg('网络错误!');
						}
					});
				});

		});

		function del(id){
			$.confirm({
				title: '确定删除？',
				content: '删除后数据不可恢复，请慎重！',
				buttons: {
					confirm: {
						text: '确认',
						action: function(){
							ajaxRequest('delete','post',{"id":id},function () {
								showConfirmSuccessMsg("您已成功删除商品");
							})
						}
					},
					cancel: {
						text: '关闭',
						action: function(){
							return;
						}
					}
				}
			});
		}
	</script>
</body>
</html>