package com.example.xhbblog.Service.impl;

import com.example.xhbblog.Service.CommentService;
import com.example.xhbblog.manager.RedisCommentManager;
import com.example.xhbblog.manager.RedisUserManager;
import com.example.xhbblog.mapper.ArticleMapper;
import com.example.xhbblog.mapper.CommentMapper;
import com.example.xhbblog.mapper.UserMapper;
import com.example.xhbblog.pojo.Article;
import com.example.xhbblog.pojo.Comment;
import com.example.xhbblog.pojo.User;
import com.example.xhbblog.utils.MessageUtil;
import com.example.xhbblog.websocket.WebSocketServer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;


@Service
@Transactional
@CacheConfig(cacheNames = "comment")
@EnableScheduling           //开启定时器
public class CommentServiceImpl implements CommentService {

    private static final Logger LOG = LoggerFactory.getLogger(CommentServiceImpl.class);

    @Autowired
    private CommentMapper mapper;

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private RedisCommentManager redisCommentManager;

    @Autowired
    private WebSocketServer webSocketServer;

    @Autowired
    private RedisUserManager redisUserManager;

    @Override
    public void add(Comment comment) {
        LOG.info("{}添加评论{}",comment.getUid(),comment.getContent());
        redisCommentManager.add(comment);
    }

    /**
     * 递归级联删除一个评论及其子评论
     * @param id
     */
    @Override
    public void delete(Integer id) {
        LOG.info("评论{}被删除",id);
       redisCommentManager.delete(id);
    }

    @Override
    public void update(Comment comment) {
        mapper.updateByPrimaryKey(comment);
    }

    @Override
    public Comment get(Integer id) {
        return mapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Comment> list() {
        return mapper.list();
    }

    @Override
    public List<Comment> findByAid(Integer aid,Integer start,Integer count) {
        LOG.info("查看文章id为{}的所有评论,起始点为{},查询{}条",aid,start,count);
        return redisCommentManager.findByAid(aid,start,count);
    }

    @Override
    public List<Comment> listByAid(Integer aid) {
        LOG.info("查看文章id为{}的所有评论",aid);
        return mapper.listByAid(aid);       //给后台查看评论使用的接口
    }

    @Override
    public Integer countOfArticle(Integer aid) {
        LOG.info("查看文章id为{}的所有首发评论(非回复)",aid);
        return redisCommentManager.countOfArticle(aid);
    }

    @Override
    public Integer countOfComment(Integer aid) {
        LOG.info("查看文章id为{}的所有评论(含回复)",aid);
        return redisCommentManager.countOfComment(aid);
    }

    @Override
    public List<Comment> lastComment() {
        LOG.info("查询最新评论");
        return redisCommentManager.lastComment();
    }

    @Override
    public List<Comment> listByUid(Integer uid) {
        LOG.info("查看用户{}的所有评论",uid);
        return mapper.listByUid(uid);       //给后台查看评论使用的接口
    }

    @Override
    public List<Comment> findChilds(Integer cid) {
        LOG.info("查看评论{}的所有评论",cid);
        return mapper.listByCid(cid);
    }

    /**
     * 将未读信息读入到comment中
     * 实现目的:当评论某文章时将该评论消息推送给该文章作者,
     * 若为回复某评论则也同时将回复消息提示推送给该评论作者
     * 同时放入各自的redis队列中
     * @param comment
     */
    @Override
    public void sendComment(Comment comment,User user) throws IOException {
        Article article=articleMapper.get(comment.getAid());
        String timeStr= LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        if(article.getUid()!=user.getId()){
            String messageToAdd= MessageUtil.ArtComment(comment,article,user,timeStr);
            String messageOnline=MessageUtil.ArtCommentOnline(comment,article,user,timeStr);
            webSocketServer.sendMessage(article.getUid(),messageOnline);  //将消息传送给它评论的文章所对应的那个用户
            redisUserManager.sendMessageTo(article.getUid(),messageToAdd);
        }
        if(comment.getParentID()!=null){
            LOG.info("{}",comment.getParentID());
            Comment parComment=mapper.selectByPrimaryKey(comment.getParentID());
            User parentUser=userMapper.selectByPrimaryKey(parComment.getUid());
            if(parentUser.getId()!=comment.getUid()){   //自己回复自己除外
                String replyToAdd=MessageUtil.replyComment(comment,user,timeStr);
                String replyOnline=MessageUtil.replyCommentOnline(comment,user,timeStr);
                webSocketServer.sendMessage(parentUser.getId(),replyOnline);
                redisUserManager.sendMessageTo(article.getUid(),replyToAdd);
            }
        }
    }

    @Override
    public void deleteCids(List<Integer> cids) {
        LOG.info("删除评论{}的所有评论",cids);
        redisCommentManager.deleteCids(cids);
    }

    @Override
    public Integer count() {
        LOG.info("查询评论数量");
        return mapper.count();
    }


    @Scheduled(cron = "0 0 10,14,16 * * ?")  //每天上午10点，下午2点，4点
    public void evit()
    {
        redisCommentManager.evit();  //清除所有相关缓存
    }

}
