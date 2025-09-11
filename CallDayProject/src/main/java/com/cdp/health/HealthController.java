package com.cdp.health;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cdp.health.dao.HealthDAO;
import com.cdp.health.util.MyUtil;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HealthController {
	
	@Autowired
	@Qualifier("healthDAO")
	HealthDAO dao;
	
	@Autowired
	MyUtil myUtil;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return "main";
		
	}
	
}
