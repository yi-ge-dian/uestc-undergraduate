package com.staging.base.controller.home;

import com.staging.base.bean.PageBean;
import com.staging.base.entity.common.Goods;
import com.staging.base.entity.common.GoodsCategory;
import com.staging.base.service.common.CommentService;
import com.staging.base.service.common.GoodsCategoryService;
import com.staging.base.service.common.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

/**
 * 前台物品管理控制器
 */
@RequestMapping("/home/goods")
@Controller
public class HomeGoodsController {

    @Autowired
    private GoodsCategoryService goodsCategoryService;

    @Autowired
    private GoodsService goodsService;
    @Autowired
    private CommentService commentService;

    /**
     * 物品详情页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/detail")
    public String detail(@RequestParam(name="id",required = true) Long id, Model model){
        Goods goods = goodsService.findById(id);
        if(goods == null){
            model.addAttribute("msg","物品不存在");
            return "error/runtime_error";
        }
        model.addAttribute("goods",goods);
        model.addAttribute("commentList",commentService.findByGoods(goods));
        //更新商品浏览量
        goods.setViewNumber(goods.getViewNumber()+1);
        goodsService.save(goods);
        return "home/goods/detail";
    }

    /**
     * 根据商品分类搜索商品信息
     * @param cid
     * @param model
     * @return
     */
    @RequestMapping(value = "/list")
    public String list(@RequestParam(name="cid",required = true) Long cid, PageBean<Goods> pageBean, Model model){
        GoodsCategory goodsCategory = goodsCategoryService.findById(cid);
        if(goodsCategory == null){
            model.addAttribute("msg","物品分类不存在");
            return "error/runtime_error";
        }
        //接下来分两步来考虑，分类考虑是否是二级分类
        List<Long> ids=new ArrayList<Long>();
        ids.add(goodsCategory.getId());
        if (goodsCategory.getParent()==null){
            //选中的是顶级分类，此时需要获取改分类下面的所有子分类
            List<GoodsCategory> findChildren = goodsCategoryService.findChildren(goodsCategory);
            for (GoodsCategory gc : findChildren){
                ids.add(gc.getId());
            }
        }
        model.addAttribute("pageBean",goodsService.findlist(ids,pageBean));
        model.addAttribute("gc",goodsCategory);
        return "home/goods/list";
    }
}
