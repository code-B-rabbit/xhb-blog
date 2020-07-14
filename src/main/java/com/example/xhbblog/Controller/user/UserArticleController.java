package com.example.xhbblog.Controller.user;

import com.example.xhbblog.Service.ArticleService;
import com.example.xhbblog.Service.TagService;
import com.example.xhbblog.Service.ThumbsService;
import com.example.xhbblog.Service.UserService;
import com.example.xhbblog.pojo.ArticleWithBLOBs;
import com.example.xhbblog.pojo.Comment;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * 用于用户权限的操作类
 * 用户id直接使用sessionAttribute注解注入
 */
@Controller
@RequestMapping("/userAdmin")
public class UserArticleController {

    @Autowired
    private ArticleService service;

    @Autowired
    private TagService tagService;

    @Autowired
    private UserService userService;

    @Autowired
    private ThumbsService thumbsService;


    @ModelAttribute("msgCnt")
    public Long  msgs(HttpSession session)
    {
        Integer uid= (Integer) session.getAttribute("uid");
        if(uid!=null){
            Long size=userService.msgCnt(uid); //用户所获得的消息个数
            return size;
        }
        return null;
    }


    /**
     * 按照是否发表,以及按字段排序查找全部
     * 已发表,或者全部文章,则查找置顶的博客项,查看到自己被置顶的文章
     * 以及查找某个人的文章列表(同时也查询一下这个人被置顶的文章是什么)
     * @param start
     * @param count
     * @param model
     * @param published
     * @param order
     * @return
     */
    @RequestMapping("/articleList")
    private String list(@RequestParam(name = "start",defaultValue = "0")Integer start, @RequestParam(name = "count",defaultValue = "5")Integer count, Model model,Boolean published
    ,@RequestParam(name = "order",defaultValue = "0") Integer order,@SessionAttribute(value = "uid")Integer uid)
    {
        //若为点赞业务则立即持久化
        if(Math.abs(order)==3){
            thumbsService.redisDataToMySQL();
        }
        if(start==0&&(order==null||order==0)&&(published==null||published==true))               //未发表则不查找置顶项(置顶必发表)
        {
            model.addAttribute("tops",service.topArts("....",null,uid));
        }
        PageHelper.offsetPage(start,count);
        List<ArticleWithBLOBs> articles=service.listAll(published,order,uid);
        model.addAttribute("page",new PageInfo<ArticleWithBLOBs>(articles));
        if(published!=null)
        {
            model.addAttribute("limit","published="+published+"&order="+order);           //若存在筛选则进入添加筛选项
        }else{
            model.addAttribute("limit","&order="+order);
        }
        model.addAttribute("order",order);
        return "admin/articleList";
    }

    /**
     * 按照是否发表,以及按字段排序查找某标签下的全部博文
     * @param start
     * @param count
     * @param model
     * @param published
     * @param order
     * @return
     */
    @RequestMapping("/articleListByTag")
    private String list(@RequestParam(name = "start",defaultValue = "0")Integer start, @RequestParam(name = "count",defaultValue = "5")Integer count, Model model,Integer tid,Boolean published
    ,@RequestParam(name = "order",defaultValue = "0") Integer order,@SessionAttribute(value = "uid")Integer uid)
    {
        if(Math.abs(order)==3){
            thumbsService.redisDataToMySQL();
        }
        PageHelper.offsetPage(start,count);
        List<ArticleWithBLOBs> articles=service.listByTid(tid,published,order,uid);   //后台调用标签的管理方法
        model.addAttribute("page",new PageInfo<ArticleWithBLOBs>(articles));
        String limit="tid="+tid;
        if(published!=null)
        {
            limit+="&published="+published;            //添加分页的约束条件
        }
        if(order!=null){
            limit+="&order="+order;
        }
        model.addAttribute("tag",tagService.get(tid));
        model.addAttribute("user",userService.get(uid));
        model.addAttribute("limit",limit);
        model.addAttribute("order",order);
        return "admin/articleList";
    }

    /**
     * 按照是否发表,以及按字段排序查找模糊搜索下的全部博文
     * @param start
     * @param count
     * @param model
     * @param published
     * @param order
     * @return
     */
    @RequestMapping("/articleLike")
    public String research(@RequestParam(name = "start",defaultValue = "0")Integer start, @RequestParam(name = "count",defaultValue = "5")Integer count, Model model,String key
    ,Boolean published,@RequestParam(name = "order",defaultValue = "0") Integer order,@SessionAttribute(value = "uid")Integer uid)
    {
        if(Math.abs(order)==3){
            thumbsService.redisDataToMySQL();
        }
        PageHelper.offsetPage(start,count);
        List<ArticleWithBLOBs> articles=service.listArticleLike(key,published,order,uid);
        model.addAttribute("order",order);
        PageInfo<ArticleWithBLOBs> pageInfo=new PageInfo<ArticleWithBLOBs>(articles);
        model.addAttribute("page",pageInfo);
        //model.addAttribute("count",pageInfo.getTotal());
        String limit="key="+key;
        if(published!=null)
        {
            limit+="&published="+published;            //添加分页的约束条件
        }
        if(order!=null){
            limit+="&order="+order;
        }
        model.addAttribute("limit",limit);
        return "admin/articleList";
    }

    @RequestMapping("/addArticle")
    public String add(Model model)
    {
        model.addAttribute("tags",tagService.list());
        return "admin/articleAdd";
    }
    //增加

    @RequestMapping("/editArticle")
    public String edit(Integer id,Model model)
    {
        model.addAttribute("tags",tagService.list());
        model.addAttribute("article",service.get(id));
        return "admin/articleEdit";
    }
    //修改

    //这里修改和新增保存在了一个方法里
    @RequestMapping("/articleSave")
    public String save(ArticleWithBLOBs article)
    {
        if(article.getId()==null)         //新增
        {
            article.setCreateTime(new Date());
            service.add(article);
        }else
        {
            service.update(article);
        }
        return "redirect:/userAdmin/articleList";
    }

    @RequestMapping("/deleteArticle")
    public String delete(Integer id,Integer tid,Integer order,Boolean published,@SessionAttribute(value = "uid")Integer uid)
    {
        service.deleteArticle(id,uid);
        String url="redirect:/userAdmin/articleList?";
        if(tid!=null){
            url="redirect:/userAdmin/articleListByTag?tid="+tid;  //路由控制
        }
        if(order!=null){
            url+="&order="+order;
        }
        if(published!=null){
            url+="&published="+published;
        }
        return url;
    }

    @RequestMapping("/getArticle")
    public String get(Integer id)
    {
        return "redirect:/article?id="+id; //重定向到fore路径下
    }

}
