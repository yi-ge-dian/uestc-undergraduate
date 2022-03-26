package com.staging.base.service.common;
/**
 * 物品管理service
 */

import com.staging.base.bean.PageBean;
import com.staging.base.dao.common.GoodsCategoryDao;
import com.staging.base.entity.common.GoodsCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsCategoryService {

    @Autowired
    private GoodsCategoryDao goodsCategoryDao;

    /**
     * 物品分类添加/编辑，当id不为空时，则编辑
     * @param goodsCategory
     * @return
     */
    public GoodsCategory save(GoodsCategory goodsCategory){
        return goodsCategoryDao.save(goodsCategory);
    }

    /**
     * 获取所有的一级分类
     * @return
     */
    public List<GoodsCategory> findTopCategorys(){
        return goodsCategoryDao.findByParentIsNull();
    }

    /**
     * 获取所有的二级分类
     * @return
     */
    public List<GoodsCategory> findSecondCategorys(){
        return goodsCategoryDao.findByParentIsNotNull();
    }
    /**
     * 搜索分类列表
     * @param pageBean
     * @param goodsCategory
     * @return
     */
    public PageBean<GoodsCategory> findlist(PageBean<GoodsCategory> pageBean,GoodsCategory goodsCategory){
        ExampleMatcher exampleMatcher = ExampleMatcher.matching();
        exampleMatcher = exampleMatcher.withMatcher("name", ExampleMatcher.GenericPropertyMatchers.contains());
        exampleMatcher = exampleMatcher.withIgnorePaths("sort");
        Example<GoodsCategory> example = Example.of(goodsCategory, exampleMatcher);
        Sort sort = Sort.by(Sort.Direction.ASC,"sort");
        PageRequest pageable = PageRequest.of(pageBean.getCurrentPage()-1, pageBean.getPageSize(), sort);
        Page<GoodsCategory> findAll= goodsCategoryDao.findAll(example, pageable);
        pageBean.setContent(findAll.getContent());
        pageBean.setTotal(findAll.getTotalElements());
        pageBean.setTotalPage(findAll.getTotalPages());
        return pageBean;
    }

    /**
     * 根据id查询
     * @param id
     * @return
     */
    public GoodsCategory findById(Long id){
        return goodsCategoryDao.find(id);
    }

    /**
     * 物品分类删除
     * @param id
     */
    public void delete(Long id){
        goodsCategoryDao.deleteById(id);
    }

    /***
     * 获取所有的物品分类
     * @return
     */
    public List<GoodsCategory> findAll(){
        return goodsCategoryDao.findAll();
    }
    /**
     * 获取某个顶级分类下的所有子分类
     * @param parent
     * @return
     */
    public List<GoodsCategory> findChildren(GoodsCategory parent){
        return goodsCategoryDao.findByParent(parent);
    }
}
