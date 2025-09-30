package com.cdp.health.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.data.repository.query.Param;


import com.cdp.health.board.Board;
import com.cdp.health.dto.CalendarDTO;
import com.cdp.health.dto.ExerciseDTO;
import com.cdp.health.dto.HealthDTO;
import com.cdp.health.dto.LikeStatsDTO;
import com.cdp.health.dto.NoticeDTO;
import com.cdp.health.dto.WeightDTO;

@Mapper
public interface HealthMapper {

	// ====== 방문자 로그 관련(관리자 페이지에서 관리) ======
	int getYesterdayVisitors();
	List<Map<String, Object>> getLast7DaysVisitors();

	// 좋아요 탑 3
	List<Board>getTop3ByLikes();

	// 좋아요 일주일 
	List<LikeStatsDTO> getLast7DaysLikes();

	//좋아요 기록 담기
	void insertBoardLike(@Param("boardNum") int boardNum,
			@Param("voterId") Long voterId);

	//전체 운동 목록 조회
	List<ExerciseDTO> getAllExercises();   
	// 특정 부위 운동 목록 조회
	List<ExerciseDTO> getExercisesByPart(String part);
	// 특정 ID 운동 상세 정보 조회
	ExerciseDTO getExerciseById(int exId);
	// 운동 정보 삽입
	void insertExercise(ExerciseDTO dto);
	// 운동 정보 수정
	void updateExercise(ExerciseDTO dto);
	// 운동 정보 삭제
	void deleteExercise(int exId);

	// ========== 체중 관리 관련 메서드들 (새로 추가) ==========
	void insertWeightRecord(WeightDTO weightDTO);
	List<WeightDTO> getWeightRecordsBySiteuserid(Long siteuserid);
	List<WeightDTO> getRecentWeightRecords(Long siteuserid);
	void updateWeightRecord(WeightDTO weightDTO);
	void deleteWeightRecord(int weightrecordid);
	WeightDTO getWeightRecordById(int weightrecordid);

	//imgCreated
	public int maxNum() throws Exception;

	public void insertData(Board board) throws Exception;

	public int getDataCount(@Param("searchKey") String searchKey,
			@Param("searchValue") String searchValue) throws Exception;

	public List<HealthDTO> getLists(@Param("start")int start,
			@Param("end")int end,@Param("searchKey")String searchKey,
			@Param("searchValue")String searchValue) throws Exception;

	//imgArticle을 띄어주는 메소드
	public HealthDTO getReadData(int num) throws Exception;

	//imgUpdated
	public void updateData(HealthDTO dto) throws Exception;

	public void deleteData(int num) throws Exception;

	public void deleteBoardLikes(int num) throws Exception;



}
