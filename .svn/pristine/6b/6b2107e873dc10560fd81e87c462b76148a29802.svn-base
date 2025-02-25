package kr.happyjob.study.business.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.business.model.EstimateModel;
import kr.happyjob.study.business.model.OrderClientModel;
import kr.happyjob.study.business.model.OrderDetailModel;
import kr.happyjob.study.business.model.OrderModel;
import kr.happyjob.study.business.service.OrderService;

@Controller
@RequestMapping("/business/")
public class OrderController {
	
	@Autowired
	OrderService orderService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("order-information-list")
	public String initOrderPage() throws Exception {
		return "business/order";
	}
	
	@RequestMapping("clientNames")
	@ResponseBody
	public List<Map<String, Object>> getClientNames() throws Exception {
		return orderService.getClientNames();
	}
	
	@RequestMapping("productNames")
	@ResponseBody
	public List<Map<String, Object>> getProductNames() throws Exception {
		return orderService.getProductNames();
	}
	
	@RequestMapping("manufacturerNames")
	@ResponseBody
	public List<Map<String, Object>> getManufacturerNames() throws Exception {
		return orderService.getManufacturerNames();
	}	
	
	@RequestMapping("majorCategoryNames")
	@ResponseBody
	public List<Map<String, Object>> getMajorCategoryNames(@RequestParam Map<String, Object> paramMap) throws Exception {
		return orderService.getMajorCategoryNames(paramMap);
	}

	@RequestMapping("subCategoryNames")
	@ResponseBody
	public List<Map<String, Object>> getSubCategoryNames(@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("============= subCategoryNames" + paramMap);
		return orderService.getSubCategoryNames(paramMap);
	}
	
	@RequestMapping("orderProductNames")
	@ResponseBody
	public List<Map<String, Object>> getOrderProductNames(@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("============= orderProductNames" + paramMap);
		return orderService.getOrderProductNames(paramMap);
	}
	
	@RequestMapping("orderList")
	public String getOrderList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		logger.info("paramMap ======= " + paramMap);
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<OrderModel> orderList = orderService.getOrderList(paramMap);
		int orderCnt = orderService.getOrderCnt(paramMap);
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("orderCnt", orderCnt);
		
		return "business/orderList";
	}
	
	@RequestMapping("orderDetail")
	@ResponseBody
	public Map<String, Object> orderDetail(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		OrderModel order = orderService.getOrder(paramMap);
		OrderClientModel client = orderService.getClient(paramMap);
		
		// 수주서 제품들
		List<OrderDetailModel> orderDetailList = orderService.getOrderDetail(paramMap);
		resultMap.put("orderDetail", orderDetailList);
		resultMap.put("order", order);
		resultMap.put("client", client);
//		model.addAttribute("orderDetail", orderDetailList);
//		model.addAttribute("order", order);
//		model.addAttribute("client", client);
		
		return resultMap;
	}
	
	@RequestMapping("saveOrder")
	@ResponseBody
	public Map<String, Object> saveOrder(@RequestBody Map<String, Object> paramMap, HttpSession session ) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		
		paramMap.put("loginId", loginId);

        Map<String, Object> empInfo = orderService.getEmployeeInfo(loginId);

        paramMap.put("departmentCode", empInfo.get("departmentCode"));
        paramMap.put("orderEmpName", empInfo.get("orderEmpName"));
        paramMap.put("empId", empInfo.get("empId"));
        
		int result = orderService.saveOrder(paramMap);
		
		String estimateId = (String) paramMap.get("estimateId");
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			if (estimateId != null && !(estimateId.isEmpty())) {
				int update_result = orderService.updateOrderStatus(paramMap);
				
				if(update_result > 0){
					resultMap.put("result", "success");
				}else{
					resultMap.put("result", "fail");
				}
			} else {
				resultMap.put("result", "success");
			}
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("orderEstimateList")
	public String getOrderEstimateList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		logger.info("paramMap ======= " + paramMap);
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<EstimateModel> estimateList = orderService.getOrderEstimateList(paramMap);
		int estimateCnt = orderService.getOrderEstimateCnt(paramMap);
		
		model.addAttribute("estimateList", estimateList);
		model.addAttribute("estimateCnt", estimateCnt);
		
		return "business/orderEstimateList";
	}
	
}
