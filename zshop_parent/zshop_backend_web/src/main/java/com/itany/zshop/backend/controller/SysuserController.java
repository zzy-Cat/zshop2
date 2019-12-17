package com.itany.zshop.backend.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itany.zshop.common.constant.PaginationConstant;
import com.itany.zshop.common.constant.ResponseStatusConstant;
import com.itany.zshop.common.exception.LoginErrorException;
import com.itany.zshop.common.util.ResponseResult;
import com.itany.zshop.params.SysuserParam;
import com.itany.zshop.pojo.Customer;
import com.itany.zshop.pojo.Role;
import com.itany.zshop.pojo.Sysuser;
import com.itany.zshop.service.RoleService;
import com.itany.zshop.service.SysuserService;
import com.itany.zshop.vo.SysuserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/backend/sysuser")
public class SysuserController {
    @Autowired
    private SysuserService sysuserService;
    @Autowired
    private RoleService roleService;

    @RequestMapping("/login")
    public String login(){
        return "main";
    }
    @RequestMapping("/logout")
    @ResponseBody
    public ResponseResult logout(HttpSession session){
        session.invalidate();
        return ResponseResult.success();
    }

    @RequestMapping("/add")
    @ResponseBody
    public ResponseResult add(SysuserVo sysuserVo){
        sysuserService.add(sysuserVo);
        return ResponseResult.success("注册成功");
    }

    @RequestMapping("/testlogin")
    @ResponseBody
    public ResponseResult login(String loginName, String password,HttpSession session){
        //实现登入
        ResponseResult result=new ResponseResult();
        try {
            Sysuser sysuser=sysuserService.Login(loginName, password);
            session.setAttribute("Mysysuser",sysuser);
            result.setData(sysuser);
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
        }catch (LoginErrorException e){
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAIL);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/findAll")
    public String findAll(Integer pageNum, Model model){
        if(ObjectUtils.isEmpty(pageNum)){
            pageNum= PaginationConstant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);
        List<Sysuser> sysusers =sysuserService.findAll();
        PageInfo<Sysuser> pageInfo=new PageInfo<Sysuser>(sysusers);
        model.addAttribute("pageInfo",pageInfo);
        return "sysuserManager";
    }

    @RequestMapping("/findByParams")
    public String findByParams(SysuserParam sysuserParam, Integer pageNum, Model model){
        if(ObjectUtils.isEmpty(pageNum)){
            pageNum= PaginationConstant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);
        List<Sysuser> sysusers=sysuserService.findByParams(sysuserParam);
        PageInfo<Sysuser> pageInfo=new PageInfo<Sysuser>(sysusers);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("sysuserParam",sysuserParam);
        return "sysuserManager";
    }
    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(int id){
        Sysuser sysuser=sysuserService.findById(id);
        return ResponseResult.success(sysuser);
    }
    @RequestMapping("/modify")
    @ResponseBody
    public  ResponseResult modify(SysuserVo sysuserVo){
        sysuserService.modify(sysuserVo);
        return ResponseResult.success();
    }
    @RequestMapping("/modifyStatus")
    @ResponseBody
    public ResponseResult modifyStatus(int id){
        sysuserService.modifyStatus(id);
        return ResponseResult.success();
    }
    @ModelAttribute("roles")
    public List<Role> loadRoles(){
        return roleService.findAll();
    }
}
