package org.seckill.service.impl;

import org.seckill.dao.SeckillDao;
import org.seckill.dao.SuccessKilledDao;
import org.seckill.dto.Exposer;
import org.seckill.dto.SeckillExecution;
import org.seckill.entity.Seckill;
import org.seckill.entity.SuccessKilled;
import org.seckill.enums.SeckillStatEnum;
import org.seckill.exception.RepeatKillException;
import org.seckill.exception.SeckillCloseException;
import org.seckill.exception.SeckillException;
import org.seckill.service.SeckillService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import java.util.Date;
import java.util.List;

/***
 *create by zhu 2018/3/
 * gan
 */

//@Component,@Controller,@Service,@Dao
@Service
public class SeckillServiceImpl implements SeckillService {
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    //    注入service
    @Autowired
    private SeckillDao seckillDao;
    @Autowired
    private SuccessKilledDao successKilledDao;
    //    md5盐zhi，用于混淆md5
    private final String salt = "sadhajdeydah2i";

    @Override
    public List<Seckill> getSeckillList() {
        return seckillDao.queryAll(0, 3);
    }

    @Override
    public Seckill getById(long seckillId) {
        return seckillDao.queryById(seckillId);
    }
    //    输出秒杀地址的操作

    /***
     * 下面的代码是重要逻辑代码
     */
    @Override
    public Exposer exportSeckillUrl(long seckillId) {
        Seckill seckill = seckillDao.queryById(seckillId);
        if (seckill == null) {
            return new Exposer(false, seckillId);
        }
        Date startTime = seckill.getStartTime();
        Date endTime = seckill.getEndTime();
//        系统当前时间
        Date nowTime = new Date();
        //在秒杀还没开始，或者秒杀已经结束了的时候
        if (nowTime.getTime() < startTime.getTime() || nowTime.getTime() > endTime.getTime()) {
            return new Exposer(false, seckillId, nowTime.getTime(), startTime.getTime(), endTime.getTime());
        }
//        秒杀开启成功的service,根据seckillid来生成md5
        String md5 = getMD5(seckillId);//todo
        return new Exposer(true, md5, seckillId);
    }

    //获取md5值的方法操作
    private String getMD5(long seckillId) {
        String base = seckillId + "/" + salt;
//        使用spring的工具类
        String md5 = DigestUtils.md5DigestAsHex(base.getBytes());
        return md5;
    }
    /***
     *     执行秒杀的流程
     使用注解控制事务方法的优点；
     使开发团队达成一定约定，明确标注事务方法的编程风格。
     保证事务方法的执行时间尽可能短，不要穿插其他的网络操作。
     不是所有的方法都需要事务，比如 只有一条修改操作，是不需要事务控制的。
     */

    @Override
    @Transactional

    public SeckillExecution executeSeckill(long seckillId, long userPhone, String md5) throws SeckillException, SeckillCloseException, RepeatKillException {
        if (md5 == null || !md5.equals(getMD5(seckillId))) {
            throw new SeckillException("seckill data rewrite");
        }
//        执行秒杀逻辑，减库存
        Date nowTime = new Date();
        try {
            int updateCount = seckillDao.reduceNumber(seckillId, nowTime);
            if (updateCount <= 0) {
//            没有更新到操作
                throw new SeckillCloseException("seckill is closed");
            } else {
//            记录购买行为
                int insertCount = successKilledDao.insertSuccessKilled(seckillId, userPhone);
                if (insertCount <= 0) {
//                重复秒杀
                    throw new RepeatKillException("seckill repeated");

                } else {
                    SuccessKilled successKilled = successKilledDao.queryByIdWithSeckill(seckillId, userPhone);
                    return new SeckillExecution(seckillId, SeckillStatEnum.SUCCESS, successKilled);
                }
            }
        } catch (SeckillCloseException e1) {
            throw e1;
        } catch (RepeatKillException e2) {
            throw e2;
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
//            所有编译期异常换为运行时异常
            throw new SeckillException("seckill inner error:" + e.getMessage());
        }
    }
}


