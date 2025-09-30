package com.cdp.health.weight.service;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.cdp.health.weight.Weight;

public interface WeightRepository extends JpaRepository<Weight, Integer> {
    
    // 특정 사용자의 체중 기록을 날짜순으로 조회
    @Query("SELECT w FROM Weight w WHERE w.siteuser.id = :siteuserid ORDER BY w.recorddate DESC")
    List<Weight> findBySiteuseridOrderByRecorddateDesc(@Param("siteuserid") Long siteuserid);
    
    // 특정 사용자의 최근 7개 체중 기록 조회 (차트용)
    @Query(value = "SELECT * FROM Weight w WHERE w.siteuserid = :siteuserid ORDER BY w.recorddate DESC LIMIT 7", nativeQuery = true)
    List<Weight> findRecentWeightsBySiteuserid(@Param("siteuserid") Long siteuserid);
}
