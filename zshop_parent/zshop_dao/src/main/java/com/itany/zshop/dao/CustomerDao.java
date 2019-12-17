package com.itany.zshop.dao;

        import com.itany.zshop.params.CustomerParam;
        import com.itany.zshop.pojo.Customer;
        import org.apache.ibatis.annotations.Param;

        import java.util.List;

public interface CustomerDao {
    public Customer selectByPassword(@Param("loginName") String loginName,@Param("password") String password, @Param("isValid") Integer isValid);
    public void insert(Customer customer);
    public Customer selectByloginName(@Param("loginName") String loginName);
    public void update(Customer customer);
    public void updateStatus(@Param("id")int id, @Param("isValid")int isValid);
    public List<Customer> selectByParams(CustomerParam customerParam);
    public List<Customer> selectAll();
    public Customer selectById(int id);
}
