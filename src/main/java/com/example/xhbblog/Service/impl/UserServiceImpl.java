package com.example.xhbblog.Service.impl;

import com.example.xhbblog.Service.ArticleService;
import com.example.xhbblog.Service.CommentService;
import com.example.xhbblog.Service.UserService;
import com.example.xhbblog.manager.RedisArticleManager;
import com.example.xhbblog.manager.RedisCommentManager;
import com.example.xhbblog.manager.RedisUserManager;
import com.example.xhbblog.mapper.ArticleMapper;
import com.example.xhbblog.mapper.CommentMapper;
import com.example.xhbblog.mapper.UserMapper;
import com.example.xhbblog.pojo.*;
import com.example.xhbblog.utils.MD5Utils;

import com.example.xhbblog.utils.RedisKey;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;


@Service
@Transactional
@CacheConfig(cacheNames = "user")
public class UserServiceImpl implements UserService {

    private Logger LOG=LoggerFactory.getLogger(this.getClass());

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private RedisArticleManager redisArticleManager;

    @Autowired
    private RedisCommentManager redisCommentManager;

    @Autowired
    private RedisUserManager redisUserManager;


    @Override
    public void add(User u) {
        LOG.info("{}用户注册",u);
        u.setPassword(MD5Utils.code(u.getPassword())); //加密
        userMapper.insert(u);
    }

    @Override
    public User check(User user){
        LOG.info("{}用户登录校验",user);
        user.setPassword(MD5Utils.code(user.getPassword()));  //加密
        UserExample userExample=new UserExample();
        userExample.createCriteria().andNameEqualTo(user.getName())
                .andPasswordEqualTo(user.getPassword());
        List<User> users=userMapper.selectByExample(userExample);
        return users.isEmpty()?null:users.get(0);
    }

    @Override
    public void update(User user) {
        LOG.info("{}用户登录修改用户信息",user);
        redisUserManager.update(user);
    }

    @Override
    public boolean checkName(String name) {
        LOG.info("查询名为{}的用户是否存在",name);
        return userMapper.checkName(name)>0;     //大于0则存在
    }

    @Override
    public boolean checkEmail(String email) {
        LOG.info("查询email为{}的用户是否存在",email);
        return userMapper.checkEmail(email)>0;
    }

    @Override
    public Integer count() {
        LOG.info("查询用户总数");
        return userMapper.count();
    }

    @Override
    public List<User> list() {
        LOG.info("查询权限为用户的用户总数");
        return userMapper.selectUser();
    }



    @Override
    public User get(Integer id) {
        return redisUserManager.get(id);
    }


    @Override
    public User uid(String name) {
        LOG.info("删除名为{}的用户id",name);
        return redisUserManager.uid(name);
    }

    @Override
    public Long msgCnt(Integer uid) {
        LOG.info("查询uid为{}的消息总数",uid);
        return redisUserManager.msgCnt(uid);
    }

    /**
     * 封号业务,同时将该用户所有文章以及该文章所有评论以及相关缓存删除
     * 还要将该用户其他的文章评论同时删除
     * @param uid
     */
    @Override
    public void deleteUser(Integer uid) {
        LOG.info("删除用户uid为{}",uid);
        redisUserManager.delUsr(uid);
        List<ArticleWithBLOBs> articles=articleMapper.findAll(null,null,uid);
        for (ArticleWithBLOBs article : articles) {
            redisArticleManager.deleteArticle(article.getId(),uid);
        }
        List<Comment> comments=commentMapper.listByUid(uid);
        for (Comment comment : comments) {
            redisCommentManager.delete(comment.getId());
        }
        userMapper.deleteByPrimaryKey(uid);
    }



    /**
     * 获得用户所有推送的信息(博客被留言,被评论等)
     * @return
     */
    @Override
    public List<String> getMessages(Integer uid) {
        LOG.info("查询uid为{}的所有未读信息",uid);
        return redisUserManager.getMessages(uid);
    }

    /**
     * 读信息后保存没有标记已读的信息的业务
     * @param messages
     * @param uid
     */
    @Override
    public void addMessages(String[] messages, Integer uid) {
        LOG.info("用户{}添加信息{}",uid,messages.length);
        redisUserManager.addMessages(uid,messages);
    }

    public static void main(String[] args) throws UnsupportedEncodingException {
//        System.out.println(URLDecoder.decode("2020-07-14%2012%3A05%3A20%20%20%E5%8C%BF%E5%90%8D%E7%94%A8%E6%88%B7%20%E8%AF%84%E8%AE%BA%E4%BA%86%E4%BD%A0%E7%9A%84%E6%96%87%E7%AB%A0%3A%3Cspan%20class%3D'text-primary'%3E%E6%9A%B4%E8%B7%B3%2C%E5%A6%82%E9%9B%B7%3C%2Fspan%3E%20%E5%86%85%E5%AE%B9%E4%B8%BA%3A%3Cspan%20style%3D'", "UTF-8"));

    }

}