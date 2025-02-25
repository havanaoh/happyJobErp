package kr.happyjob.study.personnel.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.personnel.model.PromotionModel;

public interface PromotionDao {
	List<PromotionModel> promotionList(Map<String, Object> paramMap) throws Exception;
	
	int promotionListCnt(Map<String, Object> paramMap) throws Exception;
	
	List<PromotionModel> promotionDetailList(Map<String, Object> paramMap) throws Exception;
	
	int promotionDetailCnt(Map<String, Object> paramMap) throws Exception;
	
	int jobGradeHistSave(Map<String, Object> paramMap) throws Exception;
}
