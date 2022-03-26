<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <#include "../common/include_css.ftl"/>
    <#include "../common/top_header.ftl"/>
    <title>${siteName!""}交易平台--修密码物品</title>
</head>
<body>
<br><br><br><br>
<!-- section -->
<section class="section section--first section--carousel " >
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="details">
                    <!-- section title -->
                    <div class="details__content">
                        <div class="row">
                            <div class="col-12 col-xl-12 order-xl-1">
                            <div class="requirements">
                                <span class="requirements__title">密码管理:</span>
                                <ul class="requirements__list">
                                    <li ><span>原密码:</span>
                                        <span class="span required1" id="old_pwd_span"></span>
                                        <input class="form__input required1 nosee" value="" id="old-pwd" type="password">
                                    </li>
                                    <li><span>新密码:</span>
                                        <span class="span required1" id="new_pwd_span"></span>
                                        <input class="form__input required1 nosee" value="" id="new-pwd" type="password">
                                    </li>
                                    <li><span>确认密码:</span>
                                        <span  class="span required1" id="confirm_pwd_span"></span>
                                        <input  class="form__input required1 nosee" value="" id="re-new-pwd" type="password">
                                    </li>
                                    <button id="save_pwd_info" type="button" class="form__btn nosee">保存</button>
                                </ul>
                            </div>
                    </div>
                </div>
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
        $("#save_pwd_info").click(function () {
            var oldPwd = $("#old-pwd").val();
            var newPwd = $("#new-pwd").val();
            var reNewPwd = $("#re-new-pwd").val();
            if (oldPwd == ''){
                showWarningMsg('请填写原密码');
                return ;
            }
            if (newPwd == ''){
                showWarningMsg('请填写新密码');
                return ;
            }
            if (reNewPwd == ''){
                showWarningMsg('请再次填写新密码');
                return ;
            }
            if (newPwd!=reNewPwd){
                showWarningMsg('两次密码填写不一致');
                return;
            }
            if (newPwd.length<6){
                showWarningMsg('密码至少填写6位');
                return;
            }
            ajaxRequest('edit_pwd','post',{oldPwd:oldPwd,newPwd:newPwd},function (rst) {
                showConfirmSuccessMsg_publish('密码修改成功');
                $("#save_pwd_info").css({
                    display: "none"
                });
                $("#edit_pwd_info").css({
                    display:"block"
                });
                $("input.required1").css({
                    display:"none"
                });
                $("span.required1").css({
                    display:"inline"
                })
            });
        });
    })

</script>
</body>
</html>