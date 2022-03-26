package com.staging.base.service.common;
/**
 * 物品管理service
 */

import com.staging.base.bean.PageBean;
import com.staging.base.dao.common.GoodsDao;
import com.staging.base.dao.common.GoodsDao;
import com.staging.base.entity.common.Goods;
import com.staging.base.entity.common.Goods;
import com.staging.base.entity.common.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsService {

    @Autowired
    private GoodsDao goodsDao;

    /**
     * 物品添加/编辑，当id不为空时，则编辑
     * @param goods
     * @return
     */
    public Goods save(Goods goods){
        return goodsDao.save(goods);
    }

    /**
     * 搜索分类列表
     * @param pageBean
     * @param goods
     * @return
     */
    public PageBean<Goods> findlist(PageBean<Goods> pageBean,Goods goods){
        ExampleMatcher exampleMatcher = ExampleMatcher.matching();
        exampleMatcher = exampleMatcher.withMatcher("name", ExampleMatcher.GenericPropertyMatchers.contains());
        exampleMatcher = exampleMatcher.withIgnorePaths("flag","viewNumber");
        Example<Goods> example = Example.of(goods, exampleMatcher);
        Sort sort = Sort.by(Sort.Direction.DESC,"createTime","recommend","flag","viewNumber");
        PageRequest pageable = PageRequest.of(pageBean.getCurrentPage()-1, pageBean.getPageSize(), sort);
        Page<Goods> findAll= goodsDao.findAll(example, pageable);
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
    public Goods findById(Long id){
        return goodsDao.find(id);
    }

    /**
     * 物品分类删除
     * @param id
     */
    public void delete(Long id){
        goodsDao.deleteById(id);
    }

    /***
     * 获取所有的物品分类
     * @return
     */
    public List<Goods> findAll(){
        return goodsDao.findAll();
    }

    /**
     * 根据学生查找商品
     * @param student
     * @return
     */
    public List<Goods> findByStudent(Student student){
        return goodsDao.findByStudent(student);
    }

    /**
     * 根据学生id和物品id查询
     * @param id
     * @param studentID
     * @return
     */
    public Goods find(Long id,Long studentID){
        return goodsDao.find(id,studentID);
    }

    /**
     * 根据物品分类查询
     * @param cids
     * @param pageBean
     * @return
     */
    public PageBean<Goods> findlist(List<Long> cids,PageBean<Goods> pageBean){

        List<Goods> findList = goodsDao.findList(cids, pageBean.getOffset(), pageBean.getPageSize());
        pageBean.setContent(findList);
        pageBean.setTotal(goodsDao.getTotalCount(cids));
        pageBean.setTotalPage(Integer.valueOf(pageBean.getTotal()/pageBean.getPageSize()+""));
        long totalPage= pageBean.getTotal()%pageBean.getPageSize();
        if (totalPage !=0){
            pageBean.setTotalPage(pageBean.getTotalPage()+1);
        }
        return pageBean;
    }

    /**
     * 根据物品名称模糊搜索
     * @param name
     * @return
     */
    public List<Goods> findListByName(String name){
        return goodsDao.findListByName(name);
    }

}
