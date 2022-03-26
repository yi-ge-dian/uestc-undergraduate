package com.staging.base.dao.common;
/**
 * 求购物品dao层
 */

import com.staging.base.entity.common.WantedGoods;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WantedGoodsDao extends JpaRepository<WantedGoods,Long> {
}
