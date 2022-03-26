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

<section class="section section--first section--last section--head" data-bg="../img/bg.jpg">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section__wrap">
                    <!-- section title -->
                    <h2 class="section__title">分类：${gc.name}<span>共${pageBean.total}个商品</span></h2>
                    <!-- end section title -->

                </div>
            </div>
        </div>
    </div>
</section>

<section class="section section--last section--catalog">
    <div class="container">
        <!-- catalog -->
        <div class="row">
            <!-- filter wrap -->

            <!-- end filter wrap -->

            <!-- content wrap -->
            <div class="col-12 col-lg-12">
                <div class="row">
                    <!-- card -->
                    <#if pageBean.content??>
                        <#list pageBean.content as goods>
                            <div class="col-12 col-sm-4 col-xl-4">
                                <div class="card">
                                    <a href="../goods/detail?id=${goods.id}" class="card__cover">
                                    <img src="/photo/view?filename=${goods.photo}" alt="${goods.name}" width="300px" height="300px">
                                    </a>

                                    <div class="card__title">
                                        <h3><a href="../goods/detail?id=${goods.id}">${goods.name}</a></h3>
                                        <span>￥${goods.sellPrice}</span><s>￥${goods.buyPrice}</s>
                                    </div>

                                    <div class="card__actions">
                                        <a href="../goods/detail?id=${goods.id}">
                                            <button  class="card__buy" type="button">了解更多</button>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </#list>
                    </#if>

                </div>
            </div>
            <#if pageBean.total gt 0>
            <#--分页开始-->
                <div class="col-12">
                    <div class="paginator">
                        <div class="paginator__counter">
                            <span>共${pageBean.totalPage}页</span>
                        </div>

                        <ul class="paginator__wrap">
                            <#if pageBean.currentPage == 1>
                                <li class="paginator__item paginator__item--prev">
                                    <a href="#">
                                        <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><polyline points='244 400 100 256 244 112' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px'/><line x1='120' y1='256' x2='412' y2='256' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px'/></svg>
                                    </a>
                                </li>
                            <#else>
                                <li class="paginator__item paginator__item--prev">
                                    <a href="/home/index/index?name=${name!""}&currentPage=1">
                                        <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><polyline points='244 400 100 256 244 112' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px'/><line x1='120' y1='256' x2='412' y2='256' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px'/></svg>
                                    </a>
                                </li>
                            </#if>
                            <#list pageBean.currentShowPage as showPage>
                                <#if pageBean.currentPage == showPage>
                                    <li class="paginator__item paginator__item--active"><span>${showPage}</span></li>
                                <#else>
                                    <li class="paginator__item"><a href="/home/index/index?name=${name!""}&currentPage=${showPage}">${showPage}</a></li>
                                </#if>
                            </#list>
                            <#if pageBean.currentPage == pageBean.totalPage>
                                <li class="paginator__item paginator__item--next">
                                    <a href="#">
                                        <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><polyline points='268 112 412 256 268 400' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px'/><line x1='392' y1='256' x2='100' y2='256' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px'/></svg>
                                    </a>
                                </li>
                            <#else>
                                <li class="paginator__item paginator__item--next">
                                    <a href="/home/index/index?name=${name!""}&currentPage=${pageBean.totalPage}">
                                        <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><polyline points='268 112 412 256 268 400' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px'/><line x1='392' y1='256' x2='100' y2='256' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:48px'/></svg>
                                    </a>
                                </li>
                            </#if>

                        </ul>
                    </div>
                </div>
            <#--  分页结束-->
            </#if>
        </div>
    </div>
</section>
<!-- end home -->
<#include "../common/end_foot.ftl"/>

<#include "../common/include_js.ftl"/>

</body>
</html>