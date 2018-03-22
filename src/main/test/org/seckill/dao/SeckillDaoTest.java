package org.seckill.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.entity.Seckill;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml"})
public class SeckillDaoTest {

    @Test
    public void reduceNumber() {
        long seckillId=1000;
        Date date=new Date();
        int updateCount=seckillDao.reduceNumber(seckillId,date);
        System.out.println(updateCount);
    }
    @Autowired
    private  SeckillDao seckillDao;
    @Test
    public void queryById() {
        long id=1000;
        Seckill seckill=seckillDao.queryById(id);
        System.out.println(seckill.getName());
        System.out.println(seckill);

    }

    @Test
    public void queryAll() {
        List<Seckill> seckills=seckillDao.queryAll(0,100);
        for (Seckill seckill : seckills)
        {
            System.out.println(seckill);
        }
    }
}