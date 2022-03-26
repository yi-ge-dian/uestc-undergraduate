<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <#include "../common/include_css.ftl"/>
    <#include "../common/top_header.ftl"/>
    <title>${siteName!""}交易平台--求购物品</title>
</head>
<body>
<br><br><br><br>
<!-- section -->
<section class="section">
    <div class="container">
        <div class="row">
            <div class="col-12 col-md-7 col-xl-8">
                <div class="row">
                    <!-- section title -->
                    <div class="col-12">
                        <h2 class="section__title">求购商品</h2>
                    </div>
                    <!-- end section title -->
                    <div class="col-12">
                        <form action="publish" class="form form--contacts" method="post" id="publish-form">
                            <h2 style="color: #7A56D4">商品名称</h2>
                            <input type="text" class="form__input required" id="name" name="name" placeholder="最多18个字" maxlength="18" tips="请填写商品名称">
                            <h2 style="color: #7A56D4">期望价格</h2>
                            <input type="number" class="form__input required" placeholder="￥" id="sellPrice" name="sellPrice" tips="请填写期望价格且只能为数字">
                            <h2 style="color: #7A56D4">期望交易地点</h2>
                            <input type="text" class="form__input required" placeholder="请填写期望交易地点" id="tradePlace" name="tradePlace" tips="请填写期望交易地点">

                            <h2 style="color: #7A56D4">商品详情</h2>
                            <textarea name="content" id="desc" class="form__textarea required" placeholder="简要介绍下你需求的商品，商品详情至少5个字" tips="请填写商品详情"></textarea>
                            <button type="button" class="form__btn" value="发布" id="submit-btn">Send</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-5 col-xl-4">
                <div class="row">
                    <!-- section title -->
                    <div class="col-12">
                        <h2 class="section__title">关于易货</h2>
                    </div>
                    <!-- end section title -->

                    <div class="col-12">
                        <p class="section__text section__text--mt">这是一个网站，专门为您的闲置物品而打造。</p>

                        <ul class="contacts__list">
                            <li>This is a website, specially built for your idle items.</li>
                            <li><a href="#">www.barter.com</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- end section -->
<#include "../common/end_foot.ftl"/>
<#include "../common/mycommon_js.ftl"/>
<#include "../common/include_js.ftl"/>

<script type="text/javascript">
    $(document).ready(function(){
        $("#submit-btn").click(function () {
            var flag=true;
            $(".required").each(function (i,e) {
                if ($(e).val()==''){
                    alert($(e).attr('tips'));
                    /*showErrorMsg($(e).attr('tips'));*/
                    flag=false;
                    return false;
                }
            });
            if (flag){
                if ($("#desc").val().length<5){
                    alert('商品详情描述字数不能少于5个字');
                    return;
                }
                if (parseFloat($("#sellPrice").val())=='NaN'){
                    alert('期望价格只能输入数字！')
                    return;
                }
                //全部符号，准备提交表单
                ajaxRequest('publish_wanted','post',$("#publish-form").serialize(),function () {
                    window.location.href="index";
                })
            }
        });
});
</script>
</body>
</html>