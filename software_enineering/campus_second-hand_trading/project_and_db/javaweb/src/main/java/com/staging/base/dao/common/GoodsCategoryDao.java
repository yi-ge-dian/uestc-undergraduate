package com.staging.base.dao.common;

import com.staging.base.entity.common.GoodsCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GoodsCategoryDao extends JpaRepository<GoodsCategory, Long> {
    /**
     * 获取所有一级分类
     * @return
     */
    List<GoodsCategory> findByParentIsNull();

    /**
     * 获取所有的二级分类
     * @return
     */
    List<GoodsCategory> findByParentIsNotNull();
    /**
     * 根据id获取
     * @return
     */
    @Query("select gc from GoodsCategory gc where id =:id")
    GoodsCategory find(@Param("id")Long id);
    /**
     * 获取某个顶级分类下面的子分类
     * @param parent
     * @return
     */
    List<GoodsCategory> findByParent(GoodsCategory parent);
}
