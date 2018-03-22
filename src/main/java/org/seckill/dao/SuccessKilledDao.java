package org.seckill.dao;
/**
 * create by zhu 2018
 * gan
 */
import org.apache.ibatis.annotations.Param;
import org.seckill.entity.SuccessKilled;
public interface SuccessKilledDao {
//插入明细可过滤重复
//    加入param来绑定参数
    int insertSuccessKilled(@Param("seckillId") long seckillId,@Param("userPhone") long userPhone);
//根据id查询successKilled并携带秒杀实体,这里的param很重要用来映射entity里的包的
    SuccessKilled queryByIdWithSeckill(@Param("seckillId") long seckillId,@Param("userPhone") long userPhone);
}
