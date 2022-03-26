<!-- header -->

<header class="header">
    <div class="header__wrap">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="header__content">
                        <button class="header__menu" type="button">
                            <span></span>
                            <span></span>
                            <span></span>
                        </button>

                        <a href="/home/index/index" class="header__logo">
                            <h1 style="color: #7A56D4" class="h1">易货商品</h1>
                        </a>

                        <ul class="header__nav">
                            <#list goodsCategorys as goodsCategory>
                            <#if goodsCategory.parent??>
                            <#else >
                            <li class="header__nav-item">
                                <a class="header__nav-link" href="/home/goods/list?cid=${goodsCategory.id}" role="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${goodsCategory.name}</a>
                                <ul class="dropdown-menu header__nav-menu" aria-labelledby="dropdownMenu1">
                                    <#list goodsCategorys as secondGoodsCategory>
                                    <#if secondGoodsCategory.parent??>
                                    <#if secondGoodsCategory.parent.id == goodsCategory.id>
                                    <li><a class="header__nav-link" href="/home/goods/list?cid=${secondGoodsCategory.id}">${secondGoodsCategory.name}</a></li>
                                    </#if>
                                    </#if>
                                    </#list>
                                </ul>
                            </li>
                            </#if>
                            </#list>
                        </ul>

                        <div class="header__actions">
                            <#if barter_student??>
                            <div class="header__lang">
                                <a class="header__lang-btn" href="#" role="button" id="dropdownMenuLang" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <#if barter_student.headPic??>
                                    <img src="/photo/view?filename=${barter_student.headPic}">
                                    <#else>
                                        <img src="/home/img/flags/china.svg" alt="">
                                    </#if>
                                    <span>${barter_student.nickname!barter_student.sn}</span>
                                    <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><path d='M98,190.06,237.78,353.18a24,24,0,0,0,36.44,0L414,190.06c13.34-15.57,2.28-39.62-18.22-39.62H116.18C95.68,150.44,84.62,174.49,98,190.06Z'/></svg>
                                </a>
                                <ul class="dropdown-menu header__lang-menu" aria-labelledby="dropdownMenuLang">
                                    <li><a href="../student/index"><span>个人中心</span></a></li>
                                    <li><a href="../student/edit_pwd"><span>修改密码</span></a></li>
                                    <li><a href="../index/loginout"><span>退出</span></a></li>
                                </ul>
                            </div>
                            <#else>
                            <a href="../index/login" class="header__login">
                                <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><path d='M192,176V136a40,40,0,0,1,40-40H392a40,40,0,0,1,40,40V376a40,40,0,0,1-40,40H240c-22.09,0-48-17.91-48-40V336' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><polyline points='288 336 368 256 288 176' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><line x1='80' y1='256' x2='352' y2='256' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/></svg>
                                <span>登录</span>
                            </a>
                            &nbsp;&nbsp;
                            <a href="../index/signup" class="header__login">
                                <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><path d='M192,176V136a40,40,0,0,1,40-40H392a40,40,0,0,1,40,40V376a40,40,0,0,1-40,40H240c-22.09,0-48-17.91-48-40V336' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><polyline points='288 336 368 256 288 176' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><line x1='80' y1='256' x2='352' y2='256' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/></svg>
                                <span>注册</span>
                            </a>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="header__wrap">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="header__content">

                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <div class="header__actions header__actions--2">
                            <!--<a href="../student/publish_wanted" class="header__link">
                                <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><path d='M352.92,80C288,80,256,144,256,144s-32-64-96.92-64C106.32,80,64.54,124.14,64,176.81c-1.1,109.33,86.73,187.08,183,252.42a16,16,0,0,0,18,0c96.26-65.34,184.09-143.09,183-252.42C447.46,124.14,405.68,80,352.92,80Z' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/></svg>
                                <span><h4>求购</h4></span>
                            </a>
                                        -->
                            <a href="../student/publish" class="header__link">
                                <svg xmlns='http://www.w3.org/2000/svg' width='512' height='512' viewBox='0 0 512 512'><circle cx='176' cy='416' r='16' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><circle cx='400' cy='416' r='16' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><polyline points='48 80 112 80 160 352 416 352' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/><path d='M160,288H409.44a8,8,0,0,0,7.85-6.43l28.8-144a8,8,0,0,0-7.85-9.57H128' style='fill:none;stroke-linecap:round;stroke-linejoin:round;stroke-width:32px'/></svg>
                                <span><h4>我想要卖</h4></span>
                            </a>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- end header -->
<script type="text/javascript">
    function searchPro() {
        var keyword=$("#keyword").val();
        window.location.href="/home/index/index?name="+keyword;
    }
</script>