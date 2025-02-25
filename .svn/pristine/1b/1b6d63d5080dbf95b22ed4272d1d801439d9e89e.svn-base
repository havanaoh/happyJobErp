package kr.happyjob.study.account.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.account.model.AccountModel;
import kr.happyjob.study.account.model.ExpenseModel;
import kr.happyjob.study.account.service.ExpenseService;
import kr.happyjob.study.account.service.VoucherService;
import kr.happyjob.study.business.model.BusinessModel;
import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.system.model.NoticeModel;

@Controller
@RequestMapping("/account/")
public class ExpenseController {
	
	@Autowired
	private ExpenseService expenseService;
	
	@Autowired
	private VoucherService voucherService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("expense-list")
	public String init(Model model, HttpSession session) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		LgnInfoModel LgnInfo = expenseService.expenseUser(paramMap);
		List<BusinessModel> clientList = expenseService.expenseClient();
		
		model.addAttribute("lgnInfo", LgnInfo);
		model.addAttribute("clientList", clientList);
		return "account/expense";
	}
	
	@RequestMapping("expense-review")
	public String initExpenseReview(Model model) throws Exception {
		List<AccountModel> crebitList = expenseService.expenseCrebitList();
		model.addAttribute("crebitList", crebitList);
		return "account/expenseReview";
	}
	
	@RequestMapping("expense-approval")
	public String initExpenseApproval() throws Exception {
		
		return "account/expenseApproval";
	}
	
	@RequestMapping("outputExpense")
	public String outputExpense() throws Exception {
		
		return "account/outputExpense";
	}
	
	@RequestMapping("expenseList.do")
	@ResponseBody
	public Map<String, Object> getExpenseList(@RequestParam Map<String, Object> paramMap, HttpSession session, HttpServletRequest request) throws Exception {
		logger.info("paramMap ======= " + paramMap);
		int user_idx = (int) session.getAttribute("user_idx");
		logger.info("test ======= " + user_idx);
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
			
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<ExpenseModel> expenseList = new ArrayList<>();
		int expenseCnt = 0;
		
		String referer = request.getHeader("Referer");
        String url = "expense-list"; 
        
        if(referer.contains(url)){
        	String loginId = (String) session.getAttribute("loginId");		
    		paramMap.put("loginId", loginId);	
        	expenseList = expenseService.getExpenseList(paramMap);
    		expenseCnt = expenseService.getExpenseListCnt(paramMap);
        }else{
        	expenseList = expenseService.getAllExpenseList(paramMap);
    		expenseCnt = expenseService.getAllExpenseListCnt(paramMap);
        }		
		
		resultMap.put("expense", expenseList);
		resultMap.put("expenseCnt", expenseCnt);

		return resultMap;
	}
	
	
	
	@RequestMapping("expenseSearchDetail.do")
	@ResponseBody
	public Map<String, Object> accountSearchDetail(@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("paramMap ======= " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		
		List<AccountModel> accountSearchList = expenseService.expenseSearchList(paramMap);
				
		resultMap.put("searchAccount", accountSearchList);

		return resultMap;
	}
		
	@RequestMapping("expenseFileSave.do")
	@ResponseBody
	public Map<String, String> expenseFileSave(@RequestParam Map<String, Object> paramMap, HttpSession session,
			HttpServletRequest req) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		
		paramMap.put("loginId", loginId);		
		
		int result = expenseService.expenseFileSave(paramMap, req);
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("expenseUpdate.do")
	@ResponseBody
	public Map<String, String> expenseUpdate(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("expenseUpdate ======= " + paramMap);

		int result = expenseService.expenseUpdate(paramMap);
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
				
		return resultMap; 
	}
	
	@RequestMapping("expenseLastUpdate.do")
	@ResponseBody
	public Map<String, String> expenseLastUpdate(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("expenseLastUpdate ======= " + paramMap);

		int result = expenseService.expenseLastUpdate(paramMap);
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			String voucherNo = voucherService.selectExpenseVoucherSeq();
			paramMap.put("voucherNo", voucherNo);
			voucherService.insertExpenseVoucher(paramMap);
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
				
		return resultMap; 
	}
	
	@RequestMapping("expenseDelete.do")
	@ResponseBody
	public Map<String, String> expenseDelete(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("expenseDelete ======= " + paramMap);

		int result = expenseService.expenseDelete(paramMap);
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
				
		return resultMap;
	}
	
	@RequestMapping("expenseDownload.do")
	public void noticeDownload(@RequestParam Map<String, Object> paramMap, HttpServletResponse res) throws Exception {
		ExpenseModel expense = expenseService.expenseFileDetail(paramMap);
		
		// 파일 경로 가져오기
		String filePath = expense.getPhysical_path();
		
		// 가져온 파일을 0,1로 구성된 byte array로 변환
		byte bytes[] = FileUtils.readFileToByteArray(new File(filePath));
		
		// 파일 설정
		res.setContentType("application/octet-stream");
		res.setContentLength(bytes.length);
		res.setHeader("Content-Disposition",
	            "attachment; fileName=\"" + URLEncoder.encode(expense.getFile_name(), "UTF-8") + "\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		res.getOutputStream().write(bytes);
		res.getOutputStream().flush();
		res.getOutputStream().close();
		
	}
}
