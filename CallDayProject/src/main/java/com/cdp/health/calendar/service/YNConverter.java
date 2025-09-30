package com.cdp.health.calendar.service;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;

@Converter(autoApply = false)
public class YNConverter implements AttributeConverter<Boolean, String> {
	
	@Override 
	public String convertToDatabaseColumn(Boolean attribute) {
		
        return Boolean.TRUE.equals(attribute) ? "Y" : "N";
        
    }
	
    @Override 
    public Boolean convertToEntityAttribute(String dbData) {
    	
        return "Y".equalsIgnoreCase(dbData);
        
    }
    
}

