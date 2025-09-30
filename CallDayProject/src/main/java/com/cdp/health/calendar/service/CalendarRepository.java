package com.cdp.health.calendar.service;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Param;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.cdp.health.calendar.Calendar;

public interface CalendarRepository extends JpaRepository<Calendar, Integer>{
	
    List<Calendar> findByUser_IdAndCalDateBetweenAndCalCheckIsTrue(
            Long userId, String start, String end);
    
    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Query(value = "UPDATE CALENDAR SET CALCHECK = 'Y'" +
			" WHERE CALNUM  = :calNum AND USER_ID = :userId" +
			" AND NVL(CALCHECK, 'N') = 'N'", nativeQuery = true)
    int markDoneOnce(@Param("calNum") Integer calNum, @Param("userId") String userId);
	
    Optional<Calendar> findByCalNumAndUser_Id(Integer calNum, Long userId);
    
}