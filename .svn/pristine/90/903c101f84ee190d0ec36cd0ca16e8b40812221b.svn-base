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

import kr.happyjob.study.business.model.EstimateDetailModel;
import kr.happyjob.study.business.model.EstimateModel;
import kr.happyjob.study.business.model.OrderClientModel;
import kr.happyjob.study.business.service.EstimateService;

@Controller
@RequestMapping("/business/")
public class EstimateController {
	
	@Autowired
	EstimateService estimateService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("estimate-list")
	public String initEstimatePage() throws Exception {
		return "business/estimate";
	}
	
//	@RequestMapping("clientNames")
//	@ResponseBody
//	public List<Map<String, Object>> getClientNames() throws Exception {
//		return estimateService.getClientNames();
//	}
//	
//	@RequestMapping("productNames")
//	@ResponseBody
//	public List<Map<String, Object>> getProductNames() throws Exception {
//		return estimateService.getProductNames();
//	}
//	
//	@RequestMapping("manufacturerNames")
//	@ResponseBody
//	public List<Map<String, Object>> getManufacturerNames() throws Exception {
//		return estimateService.getManufacturerNames();
//	}	
//	
//	@RequestMapping("majorCategoryNames")
//	@ResponseBody
//	public List<Map<String, Object>> getMajorCategoryNames(@RequestParam Map<String, Object> paramMap) throws Exception {
//		return estimateService.getMajorCategoryNames(paramMap);
//	}
//
//	@RequestMapping("subCategoryNames")
//	@ResponseBody
//	public List<Map<String, Object>> getSubCategoryNames(@RequestParam Map<String, Object> paramMap) throws Exception {
//		logger.info("============= subCategoryNames" + paramMap);
//		return estimateService.getSubCategoryNames(paramMap);
//	}

	@RequestMapping("estimateProductNames")
	@ResponseBody
	public List<Map<String, Object>> getEstimateProductNames(@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("============= orderProductNames" + paramMap);
		return estimateService.getEstimateProductNames(paramMap);
	}
	
	@RequestMapping("estimateList")
	public String getOrderList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		logger.info("paramMap ======= " + paramMap);
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<EstimateModel> estimateList = estimateService.getEstimateList(paramMap);
		int estimateCnt = estimateService.getEstimateCnt(paramMap);
		
		model.addAttribute("estimateList", estimateList);
		model.addAttribute("estimateCnt", estimateCnt);
		
		return "business/estimateList";
	}
	
	
	@RequestMapping("estimateDetail")
	@ResponseBody
	public Map<String, Object> orderDetail(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		EstimateModel estimate = estimateService.getEstimate(paramMap);
		OrderClientModel client = estimateService.getClient(paramMap);
		
		// 수주서 제품들
		List<EstimateDetailModel> estimateDetailList = estimateService.getEstimateDetail(paramMap);
		resultMap.put("estimateDetail", estimateDetailList);
		resultMap.put("estimate", estimate);
		resultMap.put("client", client);
//		model.addAttribute("orderDetail", orderDetailList);
//		model.addAttribute("order", order);
//		model.addAttribute("client", client);
		
		return resultMap;
	}
	
	@RequestMapping("saveEstimate")
	@ResponseBody
	public Map<String, Object> saveOrder(@RequestBody Map<String, Object> paramMap, HttpSession session ) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		
		paramMap.put("loginId", loginId);

        Map<String, Object> empInfo = estimateService.getEmployeeInfo(loginId);

        paramMap.put("departmentCode", empInfo.get("departmentCode"));
        paramMap.put("estimateEmpName", empInfo.get("estimateEmpName"));
        paramMap.put("empId", empInfo.get("empId"));
                
		int result = estimateService.saveEstimate(paramMap);
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
}
