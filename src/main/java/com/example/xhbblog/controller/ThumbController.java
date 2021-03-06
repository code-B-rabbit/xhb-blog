package com.example.xhbblog.controller;

import com.example.xhbblog.pojo.Thumb;
import com.example.xhbblog.service.ThumbsService;
import com.example.xhbblog.utils.IpUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
public class ThumbController {

    @Autowired
    private ThumbsService thumbsService;

    /**
     * 给某文章点赞
     * @param aid
     * @param request
     */
    @PostMapping("thumbsUp/{aid}")
    public void thumbsUp(@PathVariable("aid") Integer aid, HttpServletRequest request)
    {
        Thumb thumbs = new Thumb();
        thumbs.setAid(aid);
        thumbs.setAddress(IpUtil.getIpAddr(request));
        thumbsService.insert(thumbs);
    }

    /**
     * 给某文章取消点赞
     * @param aid
     * @param request
     */
    @PostMapping("thumbsDown/{aid}")
    public void thumbsDown(@PathVariable("aid") Integer aid, HttpServletRequest request)
    {
        thumbsService.deleteThumb(aid,IpUtil.getIpAddr(request));
    }

}
