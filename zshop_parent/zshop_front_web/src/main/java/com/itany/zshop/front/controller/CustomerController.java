package com.itany.zshop.front.controller;

import com.itany.zshop.common.constant.CustomerConstant;
import com.itany.zshop.common.constant.ResponseStatusConstant;
import com.itany.zshop.common.exception.LoginErrorException;
import com.itany.zshop.common.util.ResponseResult;
import com.itany.zshop.pojo.Customer;
import com.itany.zshop.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
@RequestMapping("/front/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @RequestMapping("/loginByAccount")
    @ResponseBody
    public ResponseResult loginByAccount(String loginName, String password, HttpSession session){
        ResponseResult result=new ResponseResult();
        try {
            Customer customer=customerService.login(loginName, password);
            session.setAttribute("customer",customer);
            result.setData(customer);
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
        }catch (LoginErrorException e){
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAIL);
            result.setMessage(e.getMessage());
        }
        return result;
    }
    @RequestMapping("/logout")
    @ResponseBody
    public ResponseResult logout(HttpSession session){
        session.invalidate();
        return ResponseResult.success();
    }
    @RequestMapping("/regist")
    @ResponseBody
    public ResponseResult regist(String userName,String loginName,String password,String phone,String address){
        Customer customer=new Customer(userName,loginName,password,phone,address, CustomerConstant.CUSTOMER_VALID,new Date());
        Customer findCustomer=customerService.findCustomerByloginName(loginName);
        if (findCustomer==null)
            customerService.addCustomer(customer);
        else
            return ResponseResult.fail("用户已存在，请重新输入账号");
        return ResponseResult.success("注册成功");
    }
    @RequestMapping("/modifyPassword")
    @ResponseBody
    public ResponseResult modifyPassword(String password,String newPassword,String renewPassword,HttpSession session){
        if (!newPassword.equals(renewPassword))
            return ResponseResult.fail("两次输入的密码不相同");
        Customer customer=(Customer) session.getAttribute("customer");
        if (customer==null)
            return ResponseResult.fail("您还未登入，请先登入");
        if (!customer.getPassword().equals(password))
            return ResponseResult.fail("密码输入错误");
        customer.setPassword(newPassword);
        customerService.modifyPassword(customer);
        return ResponseResult.success("修改成功");
    }
}
