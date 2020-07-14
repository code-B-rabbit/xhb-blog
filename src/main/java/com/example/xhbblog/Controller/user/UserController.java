package com.example.xhbblog.Controller.user;

import com.example.xhbblog.Service.UserService;
import com.example.xhbblog.pojo.User;
import com.example.xhbblog.utils.MD5Utils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/userAdmin")         //用户后台
public class UserController {

    @Autowired
    private UserService userService;

    private Logger LOG= LoggerFactory.getLogger(this.getClass());

    @ModelAttribute("msgCnt")
    public Long  msgs(HttpSession session)
    {
        Integer uid= (Integer) session.getAttribute("uid");
        if(uid!=null){
           return userService.msgCnt(uid); //用户所获得的消息个数
       }
       return  null;
    }



    /**
     * 后台登录页面路由
     * @param model
     * @param message
     * @return
     */
    @RequestMapping("/adminLogin")
    public String login(Model model,@RequestParam(value = "message",defaultValue = "") String message)
    {
        model.addAttribute("message",message);
        return "admin/login";
    }

    /**
     * 后台登录
     * @return
     */
    @RequestMapping("/")
    public String index()
    {
        return "redirect:/userAdmin/articleList";
    }


    /**
     * 登录校验
     * @param session
     * @param user
     * @return
     * @throws UnsupportedEncodingException
     */
    @PostMapping("/checkUser")
    public @ResponseBody Object checkUser(HttpSession session,User user){
        Map<String,Boolean> res=new HashMap<>();
        String s=user.getPassword();          //保存用户所输入的未加密密码
        User u=userService.check(user);
        if(u==null)
        {
            res.put("message",false);
            LOG.info("{}",res);
            return res;
        }else
        {
            u.setPassword(s);    //将用户所输入的未加密密码存回去
            session.setAttribute("user",u);
            session.setAttribute("uid",u.getId());
            session.setAttribute("admin",u.getRole().equals("admin"));
            res.put("message",true);
            res.put("admin",u.getRole().equals("admin"));
            LOG.info("{}",res);
            return res;
        }
    }


    /**
     * 修改密码
     * @param user
     * @param session
     * @return
     */
    @RequestMapping("/changePassword")
    public String changePassword(User user,HttpSession session)
    {
        user.setPassword(MD5Utils.code(user.getPassword()));     //密码加密
        userService.update(user);
        session.removeAttribute("user");
        session.removeAttribute("uid");
        return "redirect:/userAdmin/adminLogin";
    }

    /**
     * 退出
     * @param session
     * @return
     */
    @RequestMapping("/exit")           //退出登录
    public String removeUser(HttpSession session)
    {
        session.removeAttribute("user");
        return "redirect:/userAdmin/adminLogin";
    }


    @RequestMapping("/user")
    public String user()
    {
        return "admin/user";
    }

    @RequestMapping("/changeAccount")
    public String update(@Valid User user, RedirectAttributes attributes, BindingResult result,HttpSession session)      //同时进行表单校验
    {
        String password=user.getPassword();            //先保存这个密码的值
        if(result.hasErrors())
        {
            attributes.addFlashAttribute("message",result.getFieldError().getDefaultMessage());
        }else
        {
            user.setPassword(MD5Utils.code(user.getPassword()));         //密码加密
            userService.update(user);
            session.removeAttribute("user");
            attributes.addFlashAttribute("message","修改成功,请重新登录");
        }
        return "redirect:/userAdmin/login";
    }

    @RequestMapping("/commentsByUser")
    public String comments(Integer id)
    {
        return "redirect:/userAdmin/listByUid?uid="+id;
    }

    /**
     * 异步请求推送信息
     * @return
     */
    @RequestMapping("/messages")
    public @ResponseBody Object getMessages(@SessionAttribute("uid")Integer uid)
    {
        Map<String,Object> anw=new HashMap<>();
        anw.put("data",userService.getMessages(uid));
        return anw;
    }

    /**
     * 异步请求将未设置已读的信息重新添加回去
     * @param uid
     * @return
     */
    @PostMapping("/messagesNotRead")
    public @ResponseBody void addMessages(@RequestParam(name = "messageList") String[] messageList,
                                           @SessionAttribute("uid")Integer uid) throws UnsupportedEncodingException {
        for(int i=0;i<messageList.length;i++){
            messageList[i]= URLDecoder.decode(messageList[i],"utf-8");
        }
        userService.addMessages(messageList,uid);
    }



}