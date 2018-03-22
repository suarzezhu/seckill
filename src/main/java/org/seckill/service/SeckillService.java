package org.seckill.service;

import org.seckill.entity.Seckill;

import java.util.List;

/**业务接口:站在使用者(程序员)的角度设计接口
        * 三个方面:1.方法定义粒度，方法定义的要非常清楚2.参数，要越简练越好
        * 3.返回类型(return 类型一定要友好/或者return异常，我们允许的异常)
        * Created by zhu on 2018
        * gan
        */
public interface SeckillService {
    /**查询全部秒杀记录
     *
     */
    List<Seckill> getSeckillList();

    /**
     *查询单个秒杀记录
     * @param seckillId
     * @return
     */
Seckill getById(long seckillId);

    /**
     * 在秒杀开启时输出秒杀接口的地址，否则输出系统时间和秒杀时间
     * @param seckillId
     */


}
