package kr.happyjob.study.sales.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.sales.model.RevenueDailyModel;
import kr.happyjob.study.sales.model.RevenueModel;
import kr.happyjob.study.sales.model.TopRevenueModel;
import kr.happyjob.study.sales.service.RevenueService;

@Controller
@RequestMapping("/sales")
public class RevenueController {

	private final Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private RevenueService service;

	@RequestMapping("/dailyRevenue.do")
	public String dailyRevenue() {
		logger.info("dailyRevenue.do");

		return "sales/dailyRevenue";
	}

	@RequestMapping("/searchDaily.do")
	public String searchDaily(Model model, @RequestParam Map<String, Object> paramMap) {
		logger.info("searchDaily.do");
		logger.info("   - paramMap : " + paramMap);

		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

		paramMap.put("startSeq", (currentPage - 1) * pageSize);
		paramMap.put("pageSize", pageSize);

		List<RevenueDailyModel> list = service.searchDaily(paramMap);
		int totalCount = service.searchDailyTotalCount(paramMap);
		long totalAmount = 0;
		long totalUnpaid = 0;
		long totalPayAmount = 0;

		for (int i = 0; i < list.size(); i++) {
			totalAmount += list.get(i).getAmount();
			totalPayAmount += list.get(i).getPayAmount();

			if (list.get(i).getUnpaidState().equals("N")) {
				totalUnpaid += list.get(i).getAmount();
			}
		}

		model.addAttribute("list", list);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("totalPayAmount", totalPayAmount);
		model.addAttribute("totalUnpaid", totalUnpaid);

		return "sales/dailyRevenueList";
	}
	@RequestMapping("/searchDailyJson.do")
	@ResponseBody
	public Map<String, Object> searchDailyJson(Model model, @RequestBody Map<String, Object> paramMap) {
		logger.info("searchDaily.do");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = (int) paramMap.get("currentPage");
		int pageSize = (int)paramMap.get("pageSize");
		
		paramMap.put("startSeq", (currentPage - 1) * pageSize);
		paramMap.put("pageSize", pageSize);
		
		Map<String, Object> map = new HashMap<>();
		List<RevenueDailyModel> list = service.searchDaily(paramMap);
		int totalCount = service.searchDailyTotalCount(paramMap);
		long totalAmount = 0;
		long totalUnpaid = 0;
		long totalPayAmount = 0;
		
		for (int i = 0; i < list.size(); i++) {
			totalAmount += list.get(i).getAmount();
			totalPayAmount += list.get(i).getPayAmount();
			
			if (list.get(i).getUnpaidState().equals("N")) {
				totalUnpaid += list.get(i).getAmount();
			}
		}
		
		map.put("list", list);
		map.put("totalCount", totalCount);
		map.put("totalAmount", totalAmount);
		map.put("totalPayAmount", totalPayAmount);
		map.put("totalUnpaid", totalUnpaid);
		
		return map;
	}

	@RequestMapping("/monthlyRevenue.do")
	public String monthlyRevenue(Model model) {
		logger.info("monthlyRevenue.do");

		model.addAttribute("isMonthly", "Y");

		return "sales/revenue";
	}

	@RequestMapping("/searchRevenue.do")
	public String searchRevenue(Model model, @RequestParam Map<String, Object> paramMap) {
		logger.info("searchRevenue.do");
		logger.info("   - paramMap : " + paramMap);

		setBetweenDate(paramMap);

		List<RevenueModel> list = service.searchRevenue(paramMap);

		long totalAmount = 0;
		long totalUnpaidAmount = 0;
		long totalPayAmount = 0;

		for (int i = 0; i < list.size(); i++) {
			totalAmount += list.get(i).getAmount();
			totalUnpaidAmount += list.get(i).getUnpaidAmount();
			totalPayAmount += list.get(i).getPayAmount();
		}

		model.addAttribute("list", list);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("totalPayAmount", totalPayAmount);
		model.addAttribute("totalUnpaidAmount", totalUnpaidAmount);

		return "sales/revenueList";
	}
	
	// Json for react 
	@RequestMapping("/searchRevenueJson.do")
	@ResponseBody
	public Map<String, Object> searchRevenueJson(Model model, @RequestParam Map<String, Object> paramMap) {
		logger.info("searchRevenue.do");
		logger.info("   - paramMap : " + paramMap);

		
		paramMap.put("isMonthly", "Y");
		
		setBetweenDate(paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int cpage = Integer.parseInt((String)paramMap.get("cpage"));
		int pageSize =Integer.parseInt((String)paramMap.get("pageSize"));
		int startSeq = (cpage - 1) * pageSize;
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<RevenueModel> list = service.searchRevenue(paramMap);

		resultMap.put("monthlyList", list);
		
		long totalAmount = 0;
		long totalUnpaidAmount = 0;
		long totalPayAmount = 0;

		for (int i = 0; i < list.size(); i++) {
			totalAmount += list.get(i).getAmount();
			totalUnpaidAmount += list.get(i).getUnpaidAmount();
			totalPayAmount += list.get(i).getPayAmount();
		}

		model.addAttribute("list", list);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("totalPayAmount", totalPayAmount);
		model.addAttribute("totalUnpaidAmount", totalUnpaidAmount);
		
		resultMap.put("totalAmount", totalAmount);
		resultMap.put("totalPayAmount", totalPayAmount);
		resultMap.put("totalUnpaidAmount", totalUnpaidAmount);

		return resultMap;
	}
	
	@RequestMapping("/searchGraphJson.do")
	@ResponseBody
	public Map<String, Object> searchGraphJson(Model model, @RequestParam Map<String, Object> paramMap) {
		logger.info("searchRevenue.do");
		logger.info("   - paramMap : " + paramMap);

		paramMap.put("isMonthly", "Y");
		
		setBetweenDate(paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int cpage = Integer.parseInt((String)paramMap.get("cpage"));
		int pageSize =Integer.parseInt((String)paramMap.get("pageSize"));
		int startSeq = (cpage - 1) * pageSize;
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<RevenueModel> list = service.searchRevenue(paramMap);

		resultMap.put("monthlyList", list);
		
		long totalAmount = 0;
		long totalUnpaidAmount = 0;
		long totalPayAmount = 0;

		for (int i = 0; i < list.size(); i++) {
			totalAmount += list.get(i).getAmount();
			totalUnpaidAmount += list.get(i).getUnpaidAmount();
			totalPayAmount += list.get(i).getPayAmount();
		}

		model.addAttribute("list", list);
		model.addAttribute("totalAmount", totalAmount);
		model.addAttribute("totalPayAmount", totalPayAmount);
		model.addAttribute("totalUnpaidAmount", totalUnpaidAmount);
		
		resultMap.put("totalAmount", totalAmount);
		resultMap.put("totalPayAmount", totalPayAmount);
		resultMap.put("totalUnpaidAmount", totalUnpaidAmount);

		return resultMap;
	}
	
	
	@RequestMapping("/yearlyRevenue.do")
	public String yearlyRevenue(Model model) {
		logger.info("yearlyRevenue.do");

		model.addAttribute("isMonthly", "N");

		return "sales/revenue";
	}

	@RequestMapping("/searchTop.do")
	public String searchTop(Model model, @RequestParam Map<String, Object> paramMap) {
		logger.info("searchTop.do");
		logger.info("   - paramMap : " + paramMap);

		String type = (String) paramMap.get("type");

		setBetweenDate(paramMap);

		List<TopRevenueModel> list = null;
		String title = null;
		String nameLabel = null;
		String amountLabel = null;

		if ("item".equals(type)) {
			list = service.searchTopItem(paramMap);
			title = "매출 상위 제품";
			nameLabel = "제품명";
			amountLabel = "제품 단가";
		} else {
			list = service.searchTopCust(paramMap);
			title = "매출 상위 기업";
			nameLabel = "기업명";
			amountLabel = "매출";
		}

		model.addAttribute("list", list);
		model.addAttribute("title", title);
		model.addAttribute("nameLabel", nameLabel);
		model.addAttribute("amountLabel", amountLabel);

		return "sales/topRevenue";
	}
	
	@RequestMapping("/searchTopJson.do")
	@ResponseBody
	public Map<String, Object> searchTopJson(Model model, @RequestParam Map<String, Object> paramMap) {
		logger.info("searchTop.do");
		logger.info("   - paramMap : " + paramMap);

		String type = (String) paramMap.get("type");

		setBetweenDate(paramMap);

		Map<String, Object> resultMap = new HashMap<>();
		
		List<TopRevenueModel> list = null;
		String title = null;
		String nameLabel = null;
		String amountLabel = null;

		if ("item".equals(type)) {
			list = service.searchTopItem(paramMap);
			title = "매출 상위 제품";
			nameLabel = "제품명";
			amountLabel = "제품 단가";
		} else {
			list = service.searchTopCust(paramMap);
			title = "매출 상위 기업";
			nameLabel = "기업명";
			amountLabel = "매출";
		}

		model.addAttribute("list", list);
		model.addAttribute("title", title);
		model.addAttribute("nameLabel", nameLabel);
		model.addAttribute("amountLabel", amountLabel);
		
		resultMap.put("list", list);
		resultMap.put("title", title);
		resultMap.put("nameLabel", nameLabel);
		resultMap.put("amountLabel", amountLabel);

		return resultMap;
	}

	private void setBetweenDate(Map<String, Object> params) {
		        String isMonthly = (String) params.get("isMonthly");

		        if ("Y".equals(isMonthly)) {
		            String month = (String) params.get("month");

		            // month 값이 비어있지 않으면 "-01"을 추가, 비어있다면 현재 날짜로 설정
		            if (month != null && !month.isEmpty()) {
		                month += "-01";
		            } else {
		                month = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		            }

		            try {
		                // YearMonth를 사용하여 날짜 계산
		                YearMonth yearMonth = YearMonth.parse(month.substring(0, 7)); // yyyy-MM 형식만 파싱
		                LocalDate startDate = yearMonth.atDay(1); // 해당 월의 첫날
		                LocalDate lastDate = yearMonth.atEndOfMonth(); // 해당 월의 마지막 날

		                params.put("startDate", startDate.format(DateTimeFormatter.ISO_LOCAL_DATE));
		                params.put("endDate", lastDate.format(DateTimeFormatter.ISO_LOCAL_DATE));
		            } catch (DateTimeParseException e) {
		                System.out.println("Invalid date format: " + month);
		            }
		        } else if ("N".equals(isMonthly)) {
		            String yearStr = (String) params.get("year");
		            int year;

		            if (yearStr == null || yearStr.isEmpty()) {
		                year = LocalDate.now().getYear();
		            } else {
		                year = Integer.parseInt(yearStr);
		            }

		            params.put("startDate", (year - 4) + "-01-01");
		            params.put("endDate", year + "-12-31");
		        }
		    }
	
//	private void setBetweenDate(Map<String, Object> params) {
//		String isMonthly = (String) params.get("isMonthly");
//
//		if ("Y".equals(isMonthly)) {
//			String month = (String) params.get("month");
//
//			if (!"".equals(month)) {
//				month = (String) params.get("month") + "-01";
//			} else {
//				month = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
//			}
//
//			LocalDate localDate = LocalDate.parse(month);
//			LocalDate startDate = localDate.withDayOfMonth(1);
//			LocalDate lastDate = localDate.withDayOfMonth(localDate.lengthOfMonth());
//
//			params.put("startDate", startDate.format(DateTimeFormatter.ISO_LOCAL_DATE));
//			params.put("endDate", lastDate.format(DateTimeFormatter.ISO_LOCAL_DATE));
//			
//		} else if ("N".equals(isMonthly)) {
//			String yearStr = (String) params.get("year");
//			int year = 0;
//
//			if ("".equals(yearStr)) {
//				year = LocalDate.now().getYear();
//			} else {
//				year = Integer.parseInt(yearStr);
//			}
//
//			params.put("startDate", (year - 4) + "-01-31");
//			params.put("endDate", year + "-12-31");
//		}
//	}
}
