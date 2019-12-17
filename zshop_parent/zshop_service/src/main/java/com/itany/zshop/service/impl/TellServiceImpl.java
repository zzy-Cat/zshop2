package com.itany.zshop.service.impl;

import com.itany.zshop.dao.TellDao;
import com.itany.zshop.pojo.Tell;
import com.itany.zshop.service.TellService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class TellServiceImpl implements TellService {
    @Autowired
    private TellDao tellDao;

    @Override
    public List<Tell> findAll(){
        return tellDao.selectAll();
    }
    @Override
    public void add(Tell tell){
        tellDao.insert(tell);
    }
}
