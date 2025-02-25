package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.dao.PlanDao;

@Service
public class PlanServiceImpl implements PlanService {

	@Autowired

	private PlanDao planDao;

	@Override
	public List<Map<String, Object>> getManufacturer(Map<String, Object> params) {

		return planDao.getManufacturer(params);
	}

	@Override
	public String getUnitindustrycode() {
		// TODO Auto-generated method stub
		return planDao.getUnitindustrycode();
	}

	@Override
	public List<Map<String, Object>> getMainCategoryList(Map<String, Object> params) {

		return planDao.getMainCategoryList(params);
	}

	public List<Map<String, Object>> getSubCategoryList(Map<String, Object> params) {

		return planDao.getSubCategoryList(params);
	}

	@Override
	public List<Map<String, Object>> getProductList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return planDao.getProductList(params);
	}

	@Override
	public List<Map<String, Object>> searchPlanList(Map<String, Object> params) {

//		return planDao.searchPlanList(params);
		return planDao.searchPlanList2(params);
	}

	@Override	
	public  List<Map<String, Object>> defaultSearchPlanList(Map<String, Object> params){

		return planDao. defaultSearchPlanList(params);
	}

	
	
	@Override
	public Map<String, Object> checkEmpId(Map<String, Object> params) {

		return planDao.checkEmpId(params);
	}

	@Override
	public int insertPlan(Map<String, Object> params) {

		int affectedRow = planDao.insertPlan(params);

		return affectedRow;
	}

	@Override
	public int updatePlan(Map<String, Object> params) {
		int affectedRow = planDao.updatePlan(params);
		return affectedRow;
	}

	@Override
	public int actionDeletePlan(Map<String, Object> params) {
		int affectedRow = planDao.deletePlan(params);

		return affectedRow;
	}

}
