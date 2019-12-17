package com.itany.zshop.service;

import com.itany.zshop.common.exception.LoginErrorException;
import com.itany.zshop.params.CustomerParam;
import com.itany.zshop.pojo.Customer;

import java.util.List;

public interface CustomerService {
    public Customer login(String loginName,String password)throws LoginErrorException;
    public void addCustomer(Customer customer);
    public Customer findCustomerByloginName(String loginName);
    public void modifyPassword(Customer customer);
    public List<Customer> findAll();
    public Customer findById(int id);
    public void modifyStatus( int id);
    public List<Customer> findByParams(CustomerParam customerParam);
}
