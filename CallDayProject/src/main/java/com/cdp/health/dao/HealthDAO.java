package com.cdp.health.dao;

import org.mybatis.spring.SqlSessionTemplate;

public class HealthDAO {
	
	private SqlSessionTemplate sessionTemplate;
	
	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		
		this.sessionTemplate = sessionTemplate;
		
	}

}
