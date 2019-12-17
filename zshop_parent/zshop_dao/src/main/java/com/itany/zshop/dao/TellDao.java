package com.itany.zshop.dao;

import com.itany.zshop.pojo.Tell;

import java.util.List;

public interface TellDao {
    public void insert(Tell tell);
    public List<Tell> selectAll();
}
