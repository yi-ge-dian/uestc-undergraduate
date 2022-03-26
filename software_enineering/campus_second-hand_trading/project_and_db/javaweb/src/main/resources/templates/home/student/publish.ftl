<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <#include "../common/include_css.ftl"/>
    <#include "../common/top_header.ftl"/>
    <title>${siteName!""}交易平台--发布物品</title>
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
                        <h2 class="section__title">发布商品</h2>
                    </div>
                    <!-- end section title -->
                    <div class="col-12">
                        <form action="publish" class="form form--contacts" method="post" id="publish-form">
                            <input type="hidden" id="photo" name="photo" value="" class="required" tips="请上传图片">
                            <div id="show-img" style="display: none">
                                <h2 style="color: #7A56D4">已上传图片</h2>
                                <br>
                                <img id="uploaded-img" src="/home/img/logo.svg" alt="" width="80px" height="80px">
                            </div>
                            <br>
                            <h2 style="color: #7A56D4">上传图片</h2>
                            <input type="file" class="form__label" id="uploadFile">
                            <br><br>
                            <h2 style="color: #7A56D4">商品名称</h2>
                            <input type="text" class="form__input required" id="name" name="name" placeholder="最多18个字" maxlength="18" tips="请填写商品名称">
                            <h2 style="color: #7A56D4">购入价格</h2>
                            <input type="number" class="form__input required" placeholder="￥" id="buyPrice" name="buyPrice" tips="请填写购入价格且只能为数字">
                            <h2 style="color: #7A56D4">出售价格</h2>
                            <input type="number" class="form__input required" placeholder="￥" id="sellPrice" name="sellPrice" tips="请填写出售价格且只能为数字">
                            <h2 style="color: #7A56D4">商品分类</h2>
                            <input type="hidden" id="status" name="status" value="1">
                            <input type="hidden" id="flag" name="flag" value="0">
                            <input type="hidden" id="recommend" name="recommend" value="0">
                            <input type="hidden" id="review" name="review" value="0">
                            <select name="" class="form__input" id="cid">
                                <option value="">请选择大类</option>
                                <#if goodsCategorys??>
                                <#list goodsCategorys as goodsCategory>
                                        <#if goodsCategory.parent??>
                                        <#else >
                                    <option value="${goodsCategory.id}">${goodsCategory.name}</option>
                                        </#if>
                                </#list>
                                </#if>
                            </select>
                            <select name="goodsCategory.id" class="form__input" id="cid2" name="goodCategory.id">
                                <option value="-1" >请选择小类</option>
                                <#if goodsCategorys??>
                                <#list goodsCategorys as goodsCategory>
                                <#if goodsCategory.parent??>
                                    <option style="display: none" value="${goodsCategory.id}" pid="${goodsCategory.parent.id}">${goodsCategory.name}</option>
                                </#if>
                                </#list>
                                </#if>
                            </select>
                            <h2 style="color: #7A56D4">商品详情</h2>
                            <textarea name="content" id="desc" class="form__textarea required" placeholder="简要介绍下你的商品，建议填写商品用途、新旧程度、原价等信息，商品详情至少十五个字" tips="请填写商品详情"></textarea>
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

<#include "../common/include_js.ftl"/>
<#include "../common/mycommon_js.ftl">
<script type="text/javascript">
    function showConfirmSuccessMsg_publish(msg,callback){
        $.confirm({
            title:'成功',
            content:msg,
            type:'green',
            typeAnimated:false,
            buttons:{
                omg:{
                    text:'确定',
                    btnClass:'btn-green',
                    action:function(){
                        window.location.href="index";
                    }
                }
            }
        })
    }
    $(document).ready(function(){
        $('#cid').change(function () {
           var cid=$(this).val();
           $("#cid2 option[value='-1']").prop("selected",true);
           $("#cid2 option[value!='-1']").css({'display':'none'});
           $("#cid2 option").each(function (i,e) {
                if ($(e).attr('pid')==cid){
                    $(e).css({'display':'block'})
                }
           });
        });
        $("#submit-btn").click(function () {
            var flag=true;
            $(".required").each(function (i,e) {
                if ($(e).val()==''){
                    showWarningMsg($(e).attr('tips'));
                    /*showErrorMsg($(e).attr('tips'));*/
                    flag=false;
                    return false;
                }
            });
            if (flag){
                if ($("#desc").val().length<15){
                    showWarningMsg('商品详情描述字数不能少于15个字');
                    return;
                }
                if (parseFloat($("#buyPrice").val())=='NaN'){
                    showWarningMsg('购买价格只能输入数字！')
                    return;
                }
                if (parseFloat($("#sellPrice").val())=='NaN'){
                    showWarningMsg('出售价格只能输入数字！')
                    return;
                }
                //检查分类
                if ($("#cid2").val()==''||$("#cid2").val()=='-1'){
                    showWarningMsg('请选择物品分类！')
                    return;
                }
                //全部符号，准备提交表单
                ajaxRequest('publish','post',$("#publish-form").serialize(),function () {
                    showConfirmSuccessMsg_publish("恭喜你，成功发布商品，请注意完善个人信息以便于买家咨询");
                })
            }
        });
        //监听图片上传按钮
        $("#uploadFile").change(function () {
            uploadPhoto('uploaded-img','photo');
        })

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
                   showSuccessMsg("上传成功")
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
</script>
</body>
</html>