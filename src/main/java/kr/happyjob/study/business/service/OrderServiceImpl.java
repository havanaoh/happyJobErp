package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.account.service.VoucherService;
import kr.happyjob.study.business.dao.OrderDao;
import kr.happyjob.study.business.model.EstimateModel;
import kr.happyjob.study.business.model.OrderClientModel;
import kr.happyjob.study.business.model.OrderDetailModel;
import kr.happyjob.study.business.model.OrderModel;
import kr.happyjob.study.sales.service.ReceivableService;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderDao orderDao;
	
	@Autowired
	private ReceivableService receivableService;
	
	@Autowired
	private VoucherService voucherService;
	
	@Override
	public List<Map<String, Object>> getClientNames() throws Exception {
		return orderDao.getClientNames();
	}

	@Override
	public List<Map<String, Object>> getProductNames() throws Exception {
		return orderDao.getProductNames();
	}

	@Override
	public List<Map<String, Object>> getManufacturerNames() throws Exception {
		return orderDao.getManufacturerNames();
	}
	
	@Override
	public List<Map<String, Object>> getMajorCategoryNames(Map<String, Object> paramMap) throws Exception {
		return orderDao.getMajorCategoryNames(paramMap);
	}

	@Override
	public List<Map<String, Object>> getSubCategoryNames(Map<String, Object> paramMap) throws Exception {
		return orderDao.getSubCategoryNames(paramMap);
	}
	
	@Override
	public List<Map<String, Object>> getOrderProductNames(Map<String, Object> paramMap) throws Exception {
		return orderDao.getOrderProductNames(paramMap);
	}
	
	@Override
	public List<OrderModel> getOrderList(Map<String, Object> paramMap) throws Exception {
		return orderDao.getOrderList(paramMap);
	}

	@Override
	public int getOrderCnt(Map<String, Object> paramMap) throws Exception {
		return orderDao.getOrderCnt(paramMap);
	}

	@Override
	public OrderModel getOrder(Map<String, Object> paramMap) throws Exception {
		return orderDao.getOrder(paramMap);
	}

	@Override
	public OrderClientModel getClient(Map<String, Object> paramMap) throws Exception {
		return orderDao.getClient(paramMap);
	}

	@Override
	public List<OrderDetailModel> getOrderDetail(Map<String, Object> paramMap) throws Exception {
		return orderDao.getOrderDetail(paramMap);
	}

	@Override
	public int saveOrder(Map<String, Object> paramMap) throws Exception {
        List<Map<String, Object>> orderList = (List<Map<String, Object>>) paramMap.get("orderList");

        int totalUnitPrice = orderList.stream()
                .mapToInt(p -> Integer.parseInt(p.get("unitPrice").toString()))
                .sum();

        int totalSupplyPrice = orderList.stream()
                .mapToInt(p -> Integer.parseInt(p.get("supplyPrice").toString()) * Integer.parseInt(p.get("quantity").toString()))
                .sum();
        int totalDeliveryCount = orderList.stream()
                .mapToInt(p -> Integer.parseInt(p.get("quantity").toString()))
                .sum();
        
        int totalTax = (int) (totalSupplyPrice * 0.1);

        int depositAmount = totalSupplyPrice + totalTax;
        int receivableAmount = depositAmount;
        
        String productName;
        if (orderList.size() == 1) {
        	productName = orderDao.getProductName(orderList.get(0).get("productId").toString());
        } else {
        	String firstProductName = orderDao.getProductName(orderList.get(0).get("productId").toString());
        	 productName = firstProductName + " 외 " + (orderList.size() - 1);
        }
        
        paramMap.put("totalUnitPrice", totalUnitPrice);
        paramMap.put("totalSupplyPrice", totalSupplyPrice);
        paramMap.put("totalTax", totalTax);
        paramMap.put("depositAmount", depositAmount);
        paramMap.put("receivableAmount", receivableAmount);
        paramMap.put("productName", productName);
        paramMap.put("totalDeliveryCount", totalDeliveryCount);
        
        int orderId = orderDao.insertOrder(paramMap);
        if (orderId <= 0) {
            return 0;
        }
        
        orderId = orderDao.getLastInsertId();
        
        for (Map<String, Object> product : orderList) {
            product.put("orderId", orderId);
            product.put("clientId", paramMap.get("clientId"));
            product.put("empId", paramMap.get("empId"));
            orderDao.insertOrderProduct(product);
        }
        
        paramMap.put("unpaidAmount", receivableAmount);
        paramMap.put("depositAmount", 0);
        paramMap.put("managerName", "");
        receivableService.insertReceivableHistory(paramMap);
        
        voucherService.insertReceivable(paramMap);
		return 1;
	}

	@Override
	public Map<String, Object> getEmployeeInfo(String loginId) throws Exception {
		return orderDao.getEmployeeInfo(loginId);
	}

	@Override
	public List<EstimateModel> getOrderEstimateList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return orderDao.getOrderEstimateList(paramMap);
	}

	@Override
	public int getOrderEstimateCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return orderDao.getOrderEstimateCnt(paramMap);
	}

	@Override
	public int updateOrderStatus(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return orderDao.updateOrderStatus(paramMap);
	}


}
