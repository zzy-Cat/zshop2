package com.itany.zshop.backend.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itany.zshop.common.constant.PaginationConstant;
import com.itany.zshop.common.util.ResponseResult;
import com.itany.zshop.params.CustomerParam;
import com.itany.zshop.pojo.Customer;
import com.itany.zshop.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/backend/customer")
public class CustomerController {
    @Autowired
    CustomerService customerService;

    @RequestMapping("/login")
    public String login(){
        //实现登入
        return "main";
    }
    @RequestMapping("/findAll")
    public String findAll(Integer pageNum, Model model){
        if(ObjectUtils.isEmpty(pageNum)){
            pageNum= PaginationConstant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);
        List<Customer> customers=customerService.findAll();
        PageInfo<Customer> pageInfo=new PageInfo<>(customers);
        model.addAttribute("pageInfo",pageInfo);
        return "customerManager";
    }

    @RequestMapping("/findByParams")
    public String findByParams(CustomerParam customerParam, Integer pageNum, Model model){
        if(ObjectUtils.isEmpty(pageNum)){
            pageNum= PaginationConstant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);
        List<Customer> customers=customerService.findByParams(customerParam);
        PageInfo<Customer> pageInfo=new PageInfo<>(customers);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("CustomerParam",customerParam);
        return "customerManager";
    }
    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(int id){
        Customer customer=customerService.findById(id);
        return ResponseResult.success(customer);
    }
    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(int id){
        customerService.modifyStatus(id);
        return ResponseResult.success();
    }

}

