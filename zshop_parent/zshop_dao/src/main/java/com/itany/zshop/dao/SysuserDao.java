package com.itany.zshop.dao;

import com.itany.zshop.params.SysuserParam;
import com.itany.zshop.pojo.Sysuser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysuserDao {

    public List<Sysuser> selectAll();
    public Sysuser selectById(int id);
    public void insert(Sysuser sysuser);
    public void update(Sysuser sysuser);
    public void updateStatus(@Param("id") int id, @Param("isValid") int isValid);
    public Sysuser selectBypassword(@Param("loginName") String loginName,@Param("password") String password,@Param("isValid") Integer isValid);

    List<Sysuser> selectByParams(SysuserParam sysuserParam);
}
