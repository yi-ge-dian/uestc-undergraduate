package com.staging.base.interceptor.home;

import com.alibaba.fastjson.JSON;
import com.staging.base.bean.CodeMsg;
import com.staging.base.config.SiteConfig;
import com.staging.base.constant.SessionConstant;
import com.staging.base.entity.admin.Menu;
import com.staging.base.entity.admin.User;
import com.staging.base.service.common.GoodsCategoryService;
import com.staging.base.util.MenuUtil;
import com.staging.base.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * 前台全局拦截器
 *
 */
@Component
public class HomeGlobalInterceptor implements HandlerInterceptor{

	@Autowired
	private GoodsCategoryService goodsCategoryService;

	@Autowired
	private SiteConfig siteConfig;
	
	@Override
	public boolean  preHandle(HttpServletRequest request, HttpServletResponse response, Object handler){

		if(!StringUtil.isAjax(request)){
			//若不是ajax请求，则将菜单信息放入页面模板变量
			request.setAttribute("goodsCategorys", goodsCategoryService.findAll());
			request.setAttribute("siteName",siteConfig.getSiteName());
		}
		return true;
	}
}
