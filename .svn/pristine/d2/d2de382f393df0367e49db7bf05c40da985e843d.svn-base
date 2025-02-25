package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.dao.EstimateDao;
import kr.happyjob.study.business.model.EstimateDetailModel;
import kr.happyjob.study.business.model.EstimateModel;
import kr.happyjob.study.business.model.OrderClientModel;
import kr.happyjob.study.business.model.OrderDetailModel;
import kr.happyjob.study.business.model.OrderModel;

@Service
public class EstimateServiceImpl implements EstimateService {

	@Autowired
	EstimateDao estimateDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
//	@Override
//	public List<Map<String, Object>> getClientNames() throws Exception {
//		return estimateDao.getClientNames();
//	}
//
//	@Override
//	public List<Map<String, Object>> getProductNames() throws Exception {
//		return estimateDao.getProductNames();
//	}
//
//	@Override
//	public List<Map<String, Object>> getManufacturerNames() throws Exception {
//		return estimateDao.getManufacturerNames();
//	}
//	
//	@Override
//	public List<Map<String, Object>> getMajorCategoryNames(Map<String, Object> paramMap) throws Exception {
//		return estimateDao.getMajorCategoryNames(paramMap);
//	}
//
//	@Override
//	public List<Map<String, Object>> getSubCategoryNames(Map<String, Object> paramMap) throws Exception {
//		return estimateDao.getSubCategoryNames(paramMap);
//	}
	
	@Override
	public List<Map<String, Object>> getEstimateProductNames(Map<String, Object> paramMap) throws Exception {
		return estimateDao.getEstimateProductNames(paramMap);
	}
	
	@Override
	public List<EstimateModel> getEstimateList(Map<String, Object> paramMap) throws Exception {
		return estimateDao.getEstimateList(paramMap);
	}

	@Override
	public int getEstimateCnt(Map<String, Object> paramMap) throws Exception {
		return estimateDao.getEstimateCnt(paramMap);
	}

	@Override
	public EstimateModel getEstimate(Map<String, Object> paramMap) throws Exception {
		return estimateDao.getEstimate(paramMap);
	}

	@Override
	public OrderClientModel getClient(Map<String, Object> paramMap) throws Exception {
		return estimateDao.getClient(paramMap);
	}

	@Override
	public List<EstimateDetailModel> getEstimateDetail(Map<String, Object> paramMap) throws Exception {
		return estimateDao.getEstimateDetail(paramMap);
	}

	@Override
	public int saveEstimate(Map<String, Object> paramMap) throws Exception {
        List<Map<String, Object>> estimateList = (List<Map<String, Object>>) paramMap.get("estimateList");

        int totalUnitPrice = estimateList.stream()
                .mapToInt(p -> Integer.parseInt(p.get("unitPrice").toString()))
                .sum();

        int totalSupplyPrice = estimateList.stream()
                .mapToInt(p -> Integer.parseInt(p.get("supplyPrice").toString()) * Integer.parseInt(p.get("quantity").toString()))
                .sum();
        int totalDeliveryCount = estimateList.stream()
                .mapToInt(p -> Integer.parseInt(p.get("quantity").toString()))
                .sum();
        
        int totalTax = (int) (totalSupplyPrice * 0.1);

        int depositAmount = totalSupplyPrice + totalTax;
        int receivableAmount = depositAmount;
        
        String productName;
        if (estimateList.size() == 1) {
        	productName = estimateDao.getProductName(estimateList.get(0).get("productId").toString());
        } else {
        	String firstProductName = estimateDao.getProductName(estimateList.get(0).get("productId").toString());
        	 productName = firstProductName + " 외 " + (estimateList.size() - 1);
        }
        
        paramMap.put("totalUnitPrice", totalUnitPrice);
        paramMap.put("totalSupplyPrice", totalSupplyPrice);
        paramMap.put("totalTax", totalTax);
        paramMap.put("depositAmount", depositAmount);
        paramMap.put("receivableAmount", receivableAmount);
        paramMap.put("productName", productName);
        paramMap.put("totalDeliveryCount", totalDeliveryCount);
        
        int estimateId = estimateDao.insertEstimate(paramMap);
        if (estimateId <= 0) {
            return 0;
        }
        
        estimateId = estimateDao.getLastInsertId();
        
        for (Map<String, Object> product : estimateList) {
            product.put("estimateId", estimateId);
            product.put("clientId", paramMap.get("clientId"));
            product.put("empId", paramMap.get("empId"));
            estimateDao.insertEstimateProduct(product);
        }
        
		return 1;
	}

	@Override
	public Map<String, Object> getEmployeeInfo(String loginId) throws Exception {
		return estimateDao.getEmployeeInfo(loginId);
	}


}
