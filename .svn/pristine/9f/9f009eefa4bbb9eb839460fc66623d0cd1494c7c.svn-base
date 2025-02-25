package kr.happyjob.study.sales.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.sales.model.SalesModel;

public interface SalesDao {
	SalesModel getSalesById(int id) throws Exception;
	
	List<SalesModel> dailyList(Map<String, Object> paramMap) throws Exception;
	
	List<SalesModel> dailyListChart(Map<String, Object> paramMap) throws Exception;
	
	SalesModel dailyStatistics(Map<String, Object> paramMap) throws Exception;
	
	List<SalesModel> monthlyList(Map<String, Object> paramMap) throws Exception;
	
	List<Map<String, Object>> monthlyTopProduct(Map<String, Object> paramMap) throws Exception;
	
	List<Map<String, Object>> monthlyTopClient(Map<String, Object> paramMap) throws Exception;
	
	List<SalesModel> annualList(Map<String, Object> paramMap) throws Exception;
	
	List<Map<String, Object>> annualTopProduct(Map<String, Object> paramMap) throws Exception;
	
	List<Map<String, Object>> annualTopClient(Map<String, Object> paramMap) throws Exception;
	
	int dailyListCnt(Map<String, Object> paramMap) throws Exception;
}
