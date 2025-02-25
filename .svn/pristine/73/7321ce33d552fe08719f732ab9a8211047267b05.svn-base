package kr.happyjob.study.personnel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.personnel.model.GroupListModel;
import kr.happyjob.study.personnel.model.PromotionModel;
import kr.happyjob.study.personnel.service.GroupListService;
import kr.happyjob.study.personnel.service.PromotionService;

@Controller
@RequestMapping("/personnel/")
public class PromotionController {
	
	@Autowired
	PromotionService promotionService;
	@Autowired
	GroupListService groupListService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("promotion")
	public String intiPromotion(Model model) throws Exception {
		List<GroupListModel> departmentGroupList = groupListService.departmentGroupList();
		List<GroupListModel> jobGradeGroupList = groupListService.jobGradeGroupList();
		
		model.addAttribute("departmentGroupList", departmentGroupList);
		model.addAttribute("jobGradeGroupList", jobGradeGroupList);
		
		return "personnel/promotion";
	}
	
	@RequestMapping("promotionList.do")
	@ResponseBody
	public Map<String, Object> getPromotionList(@RequestParam Map<String, Object> paramMap) throws Exception {		
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<PromotionModel> promotionList = promotionService.promotionList(paramMap);
		int promotionCnt = promotionService.promotionListCnt(paramMap);
		
		resultMap.put("promotionList", promotionList);
		resultMap.put("promotionCnt", promotionCnt);
		
		return resultMap;
	}
	
	@RequestMapping("promotionDetail.do")
	@ResponseBody
	public Map<String, Object> promotionDetailList(@RequestParam Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<PromotionModel> promotionDetailList = promotionService.promotionDetailList(paramMap);
		int promotionDetailCnt = promotionService.promotionDetailCnt(paramMap);

		resultMap.put("promotionDetailList", promotionDetailList);
		resultMap.put("promotionDetailCnt", promotionDetailCnt);
		
		return resultMap;
	}
	
}
