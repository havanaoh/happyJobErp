package kr.happyjob.study.sales.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.account.service.VoucherService;
import kr.happyjob.study.sales.model.ReceivableModel;
import kr.happyjob.study.sales.service.ReceivableService;

@Controller
@RequestMapping("/sales/")
public class ReceivableController {
	@Autowired
	private ReceivableService receivableService;
	
	@Autowired
	private VoucherService voucherService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("receivables-list")
	public String init() throws Exception {
		return "sales/receivableList";
	}
	
	@RequestMapping("receivableList.do")
	@ResponseBody
	public Map<String, Object> getReceivableList(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();

		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);

		List<ReceivableModel> receivableList = receivableService.receivableList(paramMap);
		int receivableCnt = receivableService.receivableListCnt(paramMap);

		resultMap.put("receivableList", receivableList);
		resultMap.put("receivableCnt", receivableCnt);

		return resultMap;
	}
	
	@RequestMapping("receivableDetail.do")
	@ResponseBody
	public Map<String, Object> getReceivableDetail(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		ReceivableModel detailValue = receivableService.receivableDetail(paramMap);

		resultMap.put("detail", detailValue);
		resultMap.put("userType", session.getAttribute("userType"));

		List<ReceivableModel> detailList = receivableService.receivableDetailList(paramMap);
		int detailListCnt = receivableService.receivableDetailListCnt(paramMap);

		resultMap.put("detailList", detailList);
		resultMap.put("detailListCnt", detailListCnt);

		return resultMap;
	}
	
	@RequestMapping("insertReceivableHistory.do")
	@ResponseBody
	public Map<String, String> updateDeposit(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		
		int unpaidAmount = Integer.valueOf((String) paramMap.get("unpaidAmount"));
		
		String voucherNo = voucherService.selectSalesVoucherNo();
		paramMap.put("voucherNo", voucherNo);
		
		int result = receivableService.insertReceivableHistory(paramMap);
		
		voucherService.insertReceivableHistory(paramMap);
		
		if (unpaidAmount == 0) {
			result += receivableService.updateReceivableStatus(paramMap);
		}
		
		if (result > 0) {
			int updateResult = receivableService.updateReceivable(paramMap);
			
			if (updateResult > 0) {
				resultMap.put("result", "success");
			} else {
				resultMap.put("result", "fail");
			}
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
}
