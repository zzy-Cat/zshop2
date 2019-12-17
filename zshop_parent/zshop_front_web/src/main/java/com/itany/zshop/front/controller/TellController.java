package com.itany.zshop.front.controller;

import com.github.pagehelper.PageInfo;
import com.itany.zshop.common.util.ResponseResult;
import com.itany.zshop.pojo.Customer;
import com.itany.zshop.pojo.Product;
import com.itany.zshop.pojo.Tell;
import com.itany.zshop.service.TellService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/front/tell")
public class TellController {
    @Autowired
    private TellService tellService;

    @RequestMapping("/findAll")
    public String findAll(Model model){
        List<Tell> tells=tellService.findAll();
        PageInfo<Tell> tellPageInfo=new PageInfo<>(tells);
        model.addAttribute("tells",tellPageInfo);
        return "center";
    }
    @RequestMapping("/add")
    @ResponseBody
    public ResponseResult add(String info, HttpSession session){
        Customer customer=(Customer)session.getAttribute("customer");
        if (customer==null)
            return ResponseResult.fail("你不是会员，不能发帖");
        Tell tell=new Tell();
        tell.setCustomerId(customer.getId());
        tell.setCustomerName(customer.getName());
        tell.setCreateDate(new Date());
        tell.setInfo(info);
        tellService.add(tell);
        return ResponseResult.success();
    }
}
