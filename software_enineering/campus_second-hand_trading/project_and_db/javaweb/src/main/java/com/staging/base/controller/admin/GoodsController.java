package com.staging.base.controller.admin;

import com.staging.base.bean.CodeMsg;
import com.staging.base.bean.PageBean;
import com.staging.base.bean.Result;
import com.staging.base.entity.common.Goods;
import com.staging.base.entity.common.GoodsCategory;
import com.staging.base.service.common.GoodsCategoryService;
import com.staging.base.service.common.GoodsService;
import com.staging.base.util.ValidateEntityUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.Console;

/**
 * 后台物品管理控制器
 */

@RequestMapping("/admin/commodity")
@Controller
public class GoodsController {

    @Autowired
    private GoodsCategoryService goodsCategoryService;

    @Autowired
    private GoodsService goodsService;

    /**
     * 物品管理列表页面
     *
     * @param goods
     * @param pageBean
     * @param model
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Goods goods, PageBean<Goods> pageBean, Model model) {
        Goods test =new Goods();
        goods = test;
        model.addAttribute("title", "物品列表");
        model.addAttribute("name", goods.getName());
        model.addAttribute("pageBean", goodsService.findlist(pageBean, goods));
        return "admin/goods/list";
    }

    /**
     * 物品添加页面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String add(Model model) {
        model.addAttribute("title", "添加物品");
        model.addAttribute("goodsCategorys", goodsCategoryService.findTopCategorys());
        return "admin/goods_category/add";
    }

    /**
     * 物品上架提交
     *
     * @param id,status
     * @return
     */
    @RequestMapping(value = "/up_down", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> upDown(@RequestParam (name="id",required=true) Long id,
                                  @RequestParam (name="status",required=true)Integer status) {
        Goods goods = goodsService.findById(id);
        if(goods == null){
            return Result.error(CodeMsg.ADMIN_GOODS_NO_EXIST);
        }
        if(goods.getStatus() == status){
            return Result.error(CodeMsg.ADMIN_GOODS_STATUS_NO_CHANGE);
        }
        if(status != Goods.GOODS_STATUS_UP && status != Goods.GOODS_STATUS_DOWN){
            return Result.error(CodeMsg.ADMIN_GOODS_STATUS_ERROR);
        }
        goods.setStatus(status);
        int test = goods.getStatus();
        //进行更新数据库
        if (goodsService.save(goods) == null) {
            return Result.error(CodeMsg.ADMIN_GOODS_EDIT_ERROR);
        }
        return Result.success(true);
    }

    /**
     * 物品推荐和取消
     * @param id
     * @param recommend
     * @return
     */
    @RequestMapping(value = "/recommend", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> recommend(@RequestParam (name="id",required=true) Long id,
                                  @RequestParam (name="recommend",required=true)Integer recommend) {
        Goods goods = goodsService.findById(id);
        if(goods == null){
            return Result.error(CodeMsg.ADMIN_GOODS_NO_EXIST);
        }
        if(goods.getRecommend() == recommend){
            return Result.error(CodeMsg.ADMIN_GOODS_STATUS_NO_CHANGE);
        }
        if(recommend != Goods.GOODS_RECOMMEND_OFF && recommend != Goods.GOODS_RECOMMEND_ON && recommend != Goods.GOODS_REVIEW_PASS){
            return Result.error(CodeMsg.ADMIN_GOODS_STATUS_ERROR);
        }
        if(goods.getStatus() == Goods.GOODS_STATUS_SOLD){
            return Result.error(CodeMsg.ADMIN_GOODS_STATUS_UNABLE);
        }
        goods.setRecommend(recommend);
        //进行更新数据库
        if (goodsService.save(goods) == null) {
            return Result.error(CodeMsg.ADMIN_GOODS_EDIT_ERROR);
        }
        return Result.success(true);
    }



    /**
     * 物品删除
     * @param id
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result<Boolean> delete(@RequestParam(name = "id",required = true) Long id) {
        try {
            goodsService.delete(id);
        } catch (Exception e) {
            return  Result.error(CodeMsg.ADMIN_GOODS_DELETE_ERROR);
        }
        return Result.success(true);
    }
}
