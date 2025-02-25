package kr.happyjob.study.account.controller;

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

import kr.happyjob.study.account.model.AccountModel;
import kr.happyjob.study.account.service.AccountService;
import kr.happyjob.study.system.model.NoticeModel;

@Controller
@RequestMapping("/account/")
public class AccountController {
	
	@Autowired
	private AccountService accountService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("manage")
	public String init(Model model) throws Exception {
		List<AccountModel> accountGroupList = accountService.accountGroupList();
		model.addAttribute("accountGroupList", accountGroupList);
		return "account/manage";
	}
	
	@RequestMapping("accountList.do")
	@ResponseBody
	public Map<String, Object> getNoticeList(@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("paramMap ======= " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);

		List<AccountModel> accountList = accountService.getAccountList(paramMap);
		int accountCnt = accountService.getAccountListCnt(paramMap);
		
		resultMap.put("account", accountList);
		resultMap.put("accountCnt", accountCnt);

		return resultMap;
	}
	
	@RequestMapping("accountSearchDetail.do")
	@ResponseBody
	public Map<String, Object> accountSearchDetail(@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("paramMap ======= " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		List<AccountModel> accountSearchList = accountService.accountSearchList(paramMap);
				
		resultMap.put("searchAccount", accountSearchList);

		return resultMap;
	}
	
	@RequestMapping("accountSave.do")
	@ResponseBody
	public Map<String, String> accountSave(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveaccount ======= " + paramMap);
		
		String loginId = (String) session.getAttribute("loginId");
		
		paramMap.put("loginId", loginId);
		
		int result = accountService.accountSave(paramMap);
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
				
		return resultMap; 
	}
	
	@RequestMapping("accountUpdate.do")
	@ResponseBody
	public Map<String, String> accountUpdate(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("updateAccount ======= " + paramMap);

		int result = accountService.accountUpdate(paramMap);
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
				
		return resultMap; 
	}
	
	@RequestMapping("accountDelete.do")
	@ResponseBody
	public Map<String, String> accountDelete(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("deleteAccount ======= " + paramMap);

		int result = accountService.accountDelete(paramMap);
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
				
		return resultMap;
	}
	
}
