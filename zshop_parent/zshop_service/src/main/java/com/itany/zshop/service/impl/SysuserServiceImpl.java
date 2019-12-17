package com.itany.zshop.service.impl;

import com.itany.zshop.common.constant.SysuserConstant;
import com.itany.zshop.common.exception.LoginErrorException;
import com.itany.zshop.dao.SysuserDao;
import com.itany.zshop.params.SysuserParam;
import com.itany.zshop.pojo.Role;
import com.itany.zshop.pojo.Sysuser;
import com.itany.zshop.service.SysuserService;
import com.itany.zshop.vo.SysuserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class SysuserServiceImpl implements SysuserService {
    @Autowired
    private SysuserDao sysuserDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Sysuser> findAll() {
        return sysuserDao.selectAll();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Sysuser Login(String loginName,String password)throws LoginErrorException{
        Sysuser sysuser=sysuserDao.selectBypassword(loginName,password,SysuserConstant.SYSUSER_VALID);
        if (sysuser==null)
            throw new LoginErrorException("登陆失败，用户名或密码不正确");
        return sysuser;
    }
    @Override
    public Sysuser findById(int id) {
        return sysuserDao.selectById(id);
    }

    @Override
    public void add(SysuserVo sysuserVo) {
        Sysuser sysuser =new Sysuser();
        sysuser.setId(sysuserVo.getId());
        sysuser.setName(sysuserVo.getName());
        sysuser.setLoginName(sysuserVo.getLoginName());
        sysuser.setPassword(sysuserVo.getPassword());
        sysuser.setPhone(sysuserVo.getPhone());
        sysuser.setEmail(sysuserVo.getEmail());
            //角色ID
        sysuser.setRole(new Role(sysuserVo.getRoleId()));
            //默认为有效
        sysuser.setIsValid(SysuserConstant.SYSUSER_VALID);
            //创建时间为当前时间
        sysuser.setCreateDate(new Date());
        sysuserDao.insert(sysuser);
    }

    @Override
    public void modify(SysuserVo sysuserVo) {
        Sysuser sysuser=new Sysuser();
            sysuser.setId(sysuserVo.getId());
            sysuser.setName(sysuserVo.getName());
            sysuser.setLoginName(sysuserVo.getLoginName());
            sysuser.setPassword(sysuserVo.getPassword());
            sysuser.setPhone(sysuserVo.getPhone());
            sysuser.setEmail(sysuserVo.getEmail());
            Role role=new Role();
            role.setId(sysuserVo.getRoleId());
            sysuser.setRole(role);
            sysuserDao.update(sysuser);
    }

    @Override
    public void modifyStatus(int id) {
        Sysuser sysuser=sysuserDao.selectById(id);
        int status=sysuser.getIsValid();
        if (status==SysuserConstant.SYSUSER_INVALID)
            status=SysuserConstant.SYSUSER_VALID;
        else
            status=SysuserConstant.SYSUSER_INVALID;
        sysuserDao.updateStatus(id,status);
    }

    @Override
    public List<Sysuser> findByParams(SysuserParam sysuserParam) {
        return sysuserDao.selectByParams(sysuserParam);
    }

}
