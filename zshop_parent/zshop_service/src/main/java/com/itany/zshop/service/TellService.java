package com.itany.zshop.service;

import com.itany.zshop.pojo.Tell;

import java.util.List;

public interface TellService {
    public List<Tell> findAll();
    public void add(Tell tell);
}
