package com.example.xhbblog.controller.user;

import com.example.xhbblog.service.ArticleService;
import com.example.xhbblog.service.CommentService;
import com.example.xhbblog.service.UserService;
import com.example.xhbblog.annotation.NoRepeatSubmit;
import com.example.xhbblog.pojo.Article;
import com.example.xhbblog.pojo.Comment;
import com.example.xhbblog.pojo.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping({"/userAdmin","/admin"})
public class UserCommentController {   //后台评论只有查找和删除逻辑,添加在前台进行完成

    @Autowired
    private CommentService commentService;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private UserService userService;


    @ModelAttribute("msgCnt")
    public Long  msgs(@SessionAttribute("uid")Integer uid)
    {
        return userService.msgCnt(uid); //用户所获得的消息个数
    }


    @RequestMapping("/commentListOfUser")
    public String list(@RequestParam(name = "start",defaultValue = "0")Integer start, @RequestParam(name = "count",defaultValue = "10")Integer count,@SessionAttribute(value = "uid")Integer uid, Model model)
    {
        User u=userService.get(uid);
        PageHelper.offsetPage(start, count);
        List<Comment> comments=commentService.listByUid(uid);
        model.addAttribute("mine",true);
        model.addAttribute("page",new PageInfo<Comment>(comments));
        return "admin/commentList";
    }


    /**
     * 某文章的全部回复
     * 这里如果该文章属于该用户,那么该用户可以删除该文章所有评论,否则则没有权限删除
     * @param start
     * @param count
     * @param aid
     * @param model
     * @return
     */
    @RequestMapping("/listByAid")
    public String listByAid(@RequestParam(name = "start",defaultValue = "0")Integer start, @RequestParam(name = "count",defaultValue = "10")Integer count, @RequestParam(name = "aid")Integer aid,@SessionAttribute("uid")Integer uid, Model model)
    {
        Article article=articleService.getTitle(aid);
        PageHelper.offsetPage(start,count);
        List<Comment> comments=commentService.listByAid(aid);
        model.addAttribute("page",new PageInfo<Comment>(comments));
        model.addAttribute("article",article);
        model.addAttribute("limit","aid="+aid);
        model.addAttribute("mine",article.getUid().equals(uid));
        return "admin/commentList";
    }

    /**
     * 某评论的全部回复
     */
    @RequestMapping("/listByCid")
    public String listByCid(@RequestParam(name = "start",defaultValue = "0")Integer start, @RequestParam(name = "count",defaultValue = "10")Integer count,Integer cid,Model model,@SessionAttribute("uid")Integer uid)
    {
        Comment c=commentService.get(cid);
        PageHelper.offsetPage(start,count);
        List<Comment> comments=commentService.findChilds(cid);
        model.addAttribute("page",new PageInfo<>(comments));
        model.addAttribute("limit","cid="+cid);
        model.addAttribute("cmt",c);
        model.addAttribute("mine",uid==c.getUid());
        return "admin/commentList";
    }


    /**
     * 一个用户所有匿名评论的文章
     * @param start
     * @param count
     * @param model
     * @param uid
     * @return
     */
    @RequestMapping("/listAnoByUid")
    public String listByUid(@RequestParam(name = "start",defaultValue = "0")Integer start, @RequestParam(name = "count",defaultValue = "10")Integer count,Model model,@SessionAttribute("uid")Integer uid)
    {
        PageHelper.offsetPage(start,count);
        List<Comment> comments=commentService.listAnonymousByUid(uid);
        model.addAttribute("page",new PageInfo<Comment>(comments));
        model.addAttribute("limit","uid="+uid);
        model.addAttribute("user",userService.get(uid));
        model.addAttribute("mine",uid==uid);
        model.addAttribute("anonymous",true);
        return "admin/commentList";
    }

    /**
     * 查询某用户下的全部评论
     * @param start
     * @param count
     * @param uid
     * @param model
     * @return
     */
    @RequestMapping("/listByUid")
    public String listByUid(@RequestParam(name = "start",defaultValue = "0")Integer start, @RequestParam(name = "count",defaultValue = "10")Integer count,Integer uid,Model model,@SessionAttribute("uid")Integer myUid)
    {
        PageHelper.offsetPage(start,count);
        List<Comment> comments=commentService.listByUid(uid);
        model.addAttribute("page",new PageInfo<Comment>(comments));
        model.addAttribute("limit","uid="+uid);
        model.addAttribute("user",userService.get(uid));
        model.addAttribute("mine",uid==myUid);
        return "admin/commentList";
    }

    /**
     * 后台回复评论
     * @param comment
     * @return
     */
    @NoRepeatSubmit
    @RequestMapping(value = "/replyComment",method = RequestMethod.POST)//防止接口重复提交
    public @ResponseBody Object reply(@RequestBody Comment comment) throws IOException {
        Subject subject = SecurityUtils.getSubject();
        User user= (User) subject.getPrincipal();
        if(user!=null){
            comment.setUid(user.getId());
            commentService.add(comment);   //这里是自己的回复所以不显示在websocket上了
            commentService.sendComment(comment,userService.get(comment.getUid()));
        }
        return "success";
    }

    /**
     * 评论单个删除
     * @param comment
     */
    @RequestMapping(value = "/deleteComment",method = RequestMethod.POST)
    public @ResponseBody void deleteCids(Comment comment){
        commentService.delete(comment);
    }

    /**
     * 评论批量删除
     * @param comments
     * @return
     */
    @RequestMapping(value = "/deleteComments",method = RequestMethod.POST)
    public @ResponseBody Object deleteCids(@RequestBody List<Comment> comments){
        Map<String,String> res=new HashMap<>();
        try{
            commentService.deleteCids(comments);
            res.put("msg","success");
        }catch (Exception e){
            res.put("msg","请检查批量删除的评论项中是否有评论含有未删除子评论");
        }
        return res;
    }

}
