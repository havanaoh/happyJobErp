package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.sales.model.SalesModel;

public interface SalesService {
	List<SalesModel> dailyList(Map<String, Object> params) throws Exception;
	
	List<SalesModel> dailyListChart(Map<String, Object> params) throws Exception;
	
	SalesModel dailyStatistics(Map<String, Object> params) throws Exception;
	
	List<SalesModel> monthlyList(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> monthlyTopProduct(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> monthlyTopClient(Map<String, Object> params) throws Exception;
	
	List<SalesModel> annualList(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> annualTopProduct(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> annualTopClient(Map<String, Object> params) throws Exception;
	
	int dailyListCnt(Map<String, Object> params) throws Exception;

}
