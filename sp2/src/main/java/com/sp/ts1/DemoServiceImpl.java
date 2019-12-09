package com.sp.ts1;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("ts1.demoService")
public class DemoServiceImpl implements DemoService {
	@Autowired
	private CommonDAO dao;	
	
	@Override
	public void insertDemo(Demo dto) throws Exception {
		try {
			dao.insertData("ts1.insertDemo1", dto);
			dao.insertData("ts1.insertDemo2", dto);
			dao.insertData("ts1.insertDemo3", dto);
		} catch (Exception e) {
			System.out.println(e.toString());
			throw e;
		}
	}
}
