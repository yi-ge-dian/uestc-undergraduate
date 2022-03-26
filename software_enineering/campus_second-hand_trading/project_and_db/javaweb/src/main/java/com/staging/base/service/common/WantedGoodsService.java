package com.staging.base.service.common;

import com.staging.base.dao.common.WantedGoodsDao;
import com.staging.base.entity.common.WantedGoods;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 求购物品service
 */
@Service
public class WantedGoodsService {
    @Autowired
    private WantedGoodsDao wantedGoodsDao;

    /**
     * 求购物品信息添加/编辑
     * @param wantedGoods
     * @return
     */
    public WantedGoods save(WantedGoods wantedGoods){
        return wantedGoodsDao.save(wantedGoods);
    }
}
