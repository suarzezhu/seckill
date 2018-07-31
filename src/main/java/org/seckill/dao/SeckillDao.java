package org.seckill.dao;
/**
 * create by zhu 2018
 * gan activate-power-mode OR Power mode
 */

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.Seckill;

import java.util.Date;
import java.util.List;

/**
 * @author zhu
 */
public interface SeckillDao {
    /**
     * @param seckillId
     * @param killTime
     * @return
     */
    int reduceNumber(@Param("seckillId") long seckillId, @Param("killTime") Date killTime);

    /**
     * 根据id查询秒杀对象
     */

    Seckill queryById(long seckillId);

    //    根据偏移量来查询商品列表
//    java需要用param来确定形参
    List<Seckill> queryAll(@Param("offset") int offset, @Param("limit") int limit);

}
