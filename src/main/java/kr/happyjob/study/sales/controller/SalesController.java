package kr.happyjob.study.sales.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.sales.model.ReceivableModel;
import kr.happyjob.study.sales.model.SalesModel;
import kr.happyjob.study.sales.service.SalesService;

@Controller
@RequestMapping("/sales/")
public class SalesController {
	@Autowired
	private SalesService salesService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("daily")
	public String dailyInit() throws Exception {
		return "sales/salesDaily";
	}
	
	@RequestMapping("monthly")
	public String monthlyInit() throws Exception {
		return "sales/salesMonthly";
	}
	
	@RequestMapping("annual")
	public String annualInit() throws Exception {
		return "sales/salesAnnual";
	}
	
	@RequestMapping("dailyList.do")
	@ResponseBody
	public Map<String, Object> getReceivableList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);

		List<SalesModel> dailyList = salesService.dailyList(paramMap);
		List<SalesModel> dailyListChart = salesService.dailyListChart(paramMap);
		SalesModel dailyStatistics = salesService.dailyStatistics(paramMap);
		int dailyListCnt = salesService.dailyListCnt(paramMap);

		resultMap.put("dailyList", dailyList);
		resultMap.put("dailyListChart", dailyListChart);
		resultMap.put("dailyStatistics", dailyStatistics);
		resultMap.put("dailyListCnt", dailyListCnt);

		return resultMap;
	}
	
	@RequestMapping("monthlyList.do")
	@ResponseBody
	public Map<String, Object> monthlyList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();

		List<SalesModel> monthlyList = salesService.monthlyList(paramMap);

		resultMap.put("monthlyList", monthlyList);

		return resultMap;
	}
	
	@RequestMapping("monthlyTopProduct.do")
	@ResponseBody
	public Map<String, Object> getMonthlyTopProduct(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		List<Map<String, Object>> detailValue = salesService.monthlyTopProduct(paramMap);

		resultMap.put("detail", detailValue);

		return resultMap;
	}
	
	@RequestMapping("monthlyTopClient.do")
	@ResponseBody
	public Map<String, Object> getMonthlyTopClient(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		List<Map<String, Object>> detailValue = salesService.monthlyTopClient(paramMap);

		resultMap.put("detail", detailValue);

		return resultMap;
	}
	
	@RequestMapping("annualList.do")
	@ResponseBody
	public Map<String, Object> annualList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();

		List<SalesModel> annualList = salesService.annualList(paramMap);

		resultMap.put("annualList", annualList);

		return resultMap;
	}
	
	@RequestMapping("annualTopProduct.do")
	@ResponseBody
	public Map<String, Object> getAnnualTopProduct(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		List<Map<String, Object>> detailValue = salesService.annualTopProduct(paramMap);

		resultMap.put("detail", detailValue);

		return resultMap;
	}
	
	@RequestMapping("annualTopClient.do")
	@ResponseBody
	public Map<String, Object> getAnnualTopClient(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		List<Map<String, Object>> detailValue = salesService.annualTopClient(paramMap);

		resultMap.put("detail", detailValue);

		return resultMap;
	}

}
