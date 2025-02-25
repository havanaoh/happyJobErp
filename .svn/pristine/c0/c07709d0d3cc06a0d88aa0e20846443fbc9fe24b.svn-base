package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sales.dao.SalesDao;
import kr.happyjob.study.sales.model.SalesModel;

@Service
public class SalesServiceImpl implements SalesService {
	
	@Autowired
	SalesDao salesDao;

	@Override
	public List<SalesModel> dailyList(Map<String, Object> params) throws Exception {
		return salesDao.dailyList(params);
	}
	
	@Override
	public List<SalesModel> dailyListChart(Map<String, Object> params) throws Exception {
		return salesDao.dailyListChart(params);
	}
	
	@Override
	public SalesModel dailyStatistics(Map<String, Object> params) throws Exception {
		return salesDao.dailyStatistics(params);
	}

	@Override
	public List<SalesModel> monthlyList(Map<String, Object> params) throws Exception {
		return salesDao.monthlyList(params);
	}
	
	@Override
	public List<Map<String, Object>> monthlyTopProduct(Map<String, Object> params) throws Exception {
		return salesDao.monthlyTopProduct(params);
	}

	@Override
	public List<Map<String, Object>> monthlyTopClient(Map<String, Object> params) throws Exception {
		return salesDao.monthlyTopClient(params);
	}
	
	@Override
	public List<SalesModel> annualList(Map<String, Object> params) throws Exception {
		return salesDao.annualList(params);
	}

	@Override
	public List<Map<String, Object>> annualTopProduct(Map<String, Object> params) throws Exception {
		return salesDao.annualTopProduct(params);
	}

	@Override
	public List<Map<String, Object>> annualTopClient(Map<String, Object> params) throws Exception {
		return salesDao.annualTopClient(params);
	}

	@Override
	public int dailyListCnt(Map<String, Object> params) throws Exception {
		return salesDao.dailyListCnt(params);
	}

}
