package com.itany.zshop.service.impl;

import com.itany.zshop.common.constant.CustomerConstant;
import com.itany.zshop.common.exception.LoginErrorException;
import com.itany.zshop.dao.CustomerDao;
import com.itany.zshop.params.CustomerParam;
import com.itany.zshop.pojo.Customer;
import com.itany.zshop.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerDao customerDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<Customer> findAll() {
        return customerDao.selectAll();
    }

    @Override
    public Customer findById(int id) {
        return customerDao.selectById(id);
    }

    @Override
    public void modifyStatus(int id) {
        Customer customer=customerDao.selectById(id);
        int status=customer.getIsValid();
        if (status==CustomerConstant.CUSTOMER_INVALID)
            status=CustomerConstant.CUSTOMER_VALID;
        else
            status=CustomerConstant.CUSTOMER_INVALID;
        customerDao.updateStatus(id,status);
    }

    @Override
    public List<Customer> findByParams(CustomerParam customerParam) {
        return customerDao.selectByParams(customerParam);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Customer login(String loginName,String password)throws LoginErrorException{
        Customer customer=customerDao.selectByPassword(loginName,password, CustomerConstant.CUSTOMER_VALID);
        if (customer==null)
            throw new LoginErrorException("登陆失败，用户名或密码不正确");
        return customer;
    }
    @Override
    public void addCustomer(Customer customer){
        customerDao.insert(customer);
    }
    @Override
    public Customer findCustomerByloginName(String loginName){
        return customerDao.selectByloginName(loginName);
    }
    @Override
    public void modifyPassword(Customer customer){
        customerDao.update(customer);
    }
}
