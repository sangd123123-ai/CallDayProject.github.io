package com.cdp.health;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableJpaRepositories(basePackages = {
							"com.cdp.health"})
@EnableTransactionManagement
public class JpaConfig {
	
	
}