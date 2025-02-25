package kr.happyjob.study.business.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.business.model.EstimateModel;
import kr.happyjob.study.business.model.OrderClientModel;
import kr.happyjob.study.business.model.OrderDetailModel;
import kr.happyjob.study.business.model.OrderModel;

public interface OrderDao {

	List<Map<String, Object>> getClientNames() throws Exception;

	List<Map<String, Object>> getProductNames() throws Exception;

	List<Map<String, Object>> getManufacturerNames() throws Exception;
	
	List<Map<String, Object>> getMajorCategoryNames(Map<String, Object> paramMap) throws Exception;
	
	List<Map<String, Object>> getSubCategoryNames(Map<String, Object> paramMap) throws Exception;
	
	List<Map<String, Object>> getOrderProductNames(Map<String, Object> paramMap) throws Exception;
	
	List<OrderModel> getOrderList(Map<String, Object> paramMap) throws Exception;
	
	int getOrderCnt(Map<String, Object> paramMap) throws Exception;

	OrderModel getOrder(Map<String, Object> paramMap) throws Exception;

	OrderClientModel getClient(Map<String, Object> paramMap) throws Exception;

	List<OrderDetailModel> getOrderDetail(Map<String, Object> paramMap) throws Exception;

	Map<String, Object> getEmployeeInfo(String loginId) throws Exception;

	int insertOrder(Map<String, Object> paramMap) throws Exception;

	void insertOrderProduct(Map<String, Object> product) throws Exception;

	String getProductName(String string) throws Exception;

	int getLastInsertId() throws Exception;
	
	List<EstimateModel> getOrderEstimateList(Map<String, Object> paramMap) throws Exception;
	
	int getOrderEstimateCnt(Map<String, Object> paramMap) throws Exception;
	
	int updateOrderStatus(Map<String, Object> paramMap) throws Exception;

}
