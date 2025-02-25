package kr.happyjob.study.account.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.account.model.VoucherModel;
import kr.happyjob.study.account.service.ExpenseService;
import kr.happyjob.study.account.service.VoucherService;
import kr.happyjob.study.business.model.BusinessModel;
import kr.happyjob.study.login.model.LgnInfoModel;

@Controller
@RequestMapping("/account/")
public class VoucherController {
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	private ExpenseService expenseService;
	
	@Autowired
	private VoucherService voucherService;
	
	@RequestMapping("voucher-list")
	public String init(Model model) throws Exception {		
		List<BusinessModel> clientList = expenseService.expenseClient();
		model.addAttribute("clientList", clientList);
		return "account/voucherList";
	}
	
	@RequestMapping("voucherList.do")
	@ResponseBody
	public Map<String, Object> getVoucherList(@RequestParam Map<String, Object> paramMap, HttpSession session, HttpServletRequest request) throws Exception {
		logger.info("paramMap ======= " + paramMap);
		int user_idx = (int) session.getAttribute("user_idx");
		logger.info("test ======= " + user_idx);
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
			
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<VoucherModel> voucherList = voucherService.getVoucherList(paramMap);
		int voucherCnt = voucherService.getVoucherListCnt(paramMap);
		
		resultMap.put("voucher", voucherList);
		resultMap.put("voucherCnt", voucherCnt);		

		return resultMap;
	}

}
