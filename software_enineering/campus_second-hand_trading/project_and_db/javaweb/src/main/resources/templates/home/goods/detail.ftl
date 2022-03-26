<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <#include "../common/include_css.ftl"/>
    <#include "../common/top_header.ftl"/>


    <title>${siteName!""}交易平台</title>
</head>
<body>

<!-- section -->
<section class="section section--first section--carousel section--bg" data-bg="img/bg.jpg">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="details">
                    <div class="details__head">
                        <div class="details__cover">
                            <img src="/photo/view?filename=${goods.photo}" alt="">
                        </div>

                        <div class="details__wrap">
                            <h1 class="details__title">${goods.name}</h1>

                            <ul class="details__list">
                                <li><span>商品编号:</span> ${goods.id}</li>
                                <li><span>发布时间：</span> ${goods.createTime!""}</li>
                                <li><span>交易地点：</span> ${goods.student.school!"未知"}</li>
                                <li><span>
                                        卖家学院：</span>${goods.student.academy!"未知"}</li>
                                <li><span>卖家年级：</span>${goods.student.grade!"未知"}</li>
                                <li><span>卖家昵称：</span>${goods.student.nickname!goods.student.sn}</li>
                            </ul>
                        </div>
                    </div>

                    <div class="details__text">
                        <span class="requirements__title">商品详情:</span>
                        <p>${goods.content}</p>
                    </div>

                    <div class="details__cart">
                        <ul class="details__stat">
                            <li><svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><path d='M394,480a16,16,0,0,1-9.39-3L256,383.76,127.39,477a16,16,0,0,1-24.55-18.08L153,310.35,23,221.2A16,16,0,0,1,32,192H192.38l48.4-148.95a16,16,0,0,1,30.44,0l48.4,149H480a16,16,0,0,1,9.05,29.2L359,310.35l50.13,148.53A16,16,0,0,1,394,480Z'/></svg> 浏览量<b>${goods.viewNumber}</b></li>

                            <#--<li><svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><path d='M336,176h40a40,40,0,0,1,40,40V424a40,40,0,0,1-40,40H136a40,40,0,0,1-40-40V216a40,40,0,0,1,40-40h40' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><polyline points='176 272 256 352 336 272' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><line x1='256' y1='48' x2='256' y2='336' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/></svg> <b>58</b> sales</li>-->
                        </ul>

                        <span class="details__cart-title">价格</span>
                        <div class="details__price">
                            <span>￥${goods.sellPrice!""}</span>原价：<s>￥${goods.buyPrice!""}</s>
                        </div>

                        <div class="details__actions">
                            <button id="buy-button" class="details__buy" type="button">我要购买</button>

                        </div>
                    </div>



                </div>
            </div>
        </div>
    </div>
</section>
<!-- end section -->


<#include "../common/end_foot.ftl"/>
<#include "../common/include_js.ftl"/>
<script type="text/javascript">
    $(document).ready(function() {
        $("#buy-button").click(function () {
            <#if barter_student??>
            showSuccessMsg("请你联系卖家购买" + "\n" + "电话：${barter_student.mobile!""}\n" + "QQ:${barter_student.qq!""}");
            <#else>
            showWarningMsg("请先登录");
            window.location.href = "../index/login";
            </#if>
        });

        $("#to-login-btn").click(function () {
            window.location.href = "../index/login";
        });
        $("#submit-comment-btn").click(function () {
            var content = $("#comment-content").val();
            if (content == '') {
                showErrorMsg('请输入评论内容');
                return;
            }
            var data = {'goods.id':${goods.id}, content: content};
            if ($("#submit-comment-btn").attr('data-reply') != 0) {
                data.replyTo = $("#submit-comment-btn").attr('data-reply');
                data.content=data.content.replace('回复：'+data.replyTo+':','');
                data.content='回复：“'+$("#submit-comment-btn").attr('data-reply-content')+'”<br>'+data.content;
            }
            ajaxRequest('/home/student/comment','post',data,function () {
                /*showSuccessMsg('评论成功！');*/
                showConfirmSuccessMsg('评论成功');
            })
        })
        $(".rpl").click(function () {
             $("#comment-content").val('回复：'+$(this).attr('data-name')+':');
             $("#submit-comment-btn").attr('data-reply',$(this).attr('data-name'));
             $("#submit-comment-btn").attr('data-reply-content',$(this).attr('data-reply'))
        });
    })
</script>
</body>
</html>