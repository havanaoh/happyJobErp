package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.business.model.EstimateDetailModel;
import kr.happyjob.study.business.model.EstimateModel;
import kr.happyjob.study.business.model.OrderClientModel;
import kr.happyjob.study.business.model.OrderDetailModel;
import kr.happyjob.study.business.model.OrderModel;

public interface EstimateService {

//	List<Map<String, Object>> getClientNames() throws Exception;
//
//	List<Map<String, Object>> getProductNames() throws Exception;
//	
//	List<Map<String, Object>> getManufacturerNames() throws Exception;
//
//	List<Map<String, Object>> getMajorCategoryNames(Map<String, Object> paramMap) throws Exception;
//
//	List<Map<String, Object>> getSubCategoryNames(Map<String, Object> paramMap) throws Exception;
	
	List<Map<String, Object>> getEstimateProductNames(Map<String, Object> paramMap) throws Exception;
	
	List<EstimateModel> getEstimateList(Map<String, Object> paramMap) throws Exception;

	int getEstimateCnt(Map<String, Object> paramMap) throws Exception;

	EstimateModel getEstimate(Map<String, Object> paramMap) throws Exception;

	OrderClientModel getClient(Map<String, Object> paramMap) throws Exception;

	List<EstimateDetailModel> getEstimateDetail(Map<String, Object> paramMap) throws Exception;

	int saveEstimate(Map<String, Object> paramMap) throws Exception;

	Map<String, Object> getEmployeeInfo(String loginId) throws Exception;

}
