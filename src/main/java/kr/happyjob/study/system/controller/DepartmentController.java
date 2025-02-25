package kr.happyjob.study.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.system.model.DepartmentModel;
import kr.happyjob.study.system.service.DepartmentService;

@Controller
@RequestMapping("/system")
public class DepartmentController {
	
	@Autowired
	private DepartmentService departmentService;
	
	@RequestMapping("department")
	public String init() throws Exception {
		return "system/department";
	}

	@RequestMapping("departmentList")
	public String getDepartmentList(@RequestParam Map<String, Object> paramMap, HttpSession session, Model model) throws Exception {
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		List<DepartmentModel> departmentList = departmentService.getDepartmentList(paramMap);
		int departmentCnt = departmentService.getDepartmentCnt(paramMap);
		
		model.addAttribute("departmentList", departmentList);
		model.addAttribute("departmentCnt", departmentCnt);
		
		return "system/departmentList";
	}
	
	@RequestMapping("departmentDetail")
	@ResponseBody
	public Map<String, Object> departmentDetail (@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		DepartmentModel departmentDetailValue = departmentService.departmentDetail(paramMap);
		
		resultMap.put("detail", departmentDetailValue);
				
		return resultMap;
	}
	
	@RequestMapping("departmentSave")
	@ResponseBody
	public Map<String, String> departmentSave (@RequestParam Map<String, Object> paramMap, HttpSession session) {
		Map<String, String> resultMap = new HashMap<>();
		
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		try {
	        int result = departmentService.departmentSave(paramMap);

	        if (result > 0) {
	            resultMap.put("result", "success");
	            resultMap.put("message", "저장되었습니다.");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "저장에 실패했습니다.");
	        }
	    } catch (DuplicateKeyException e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "이미 존재하는 부서 코드입니다.");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "예기치 못한 오류가 발생했습니다.");
	    }
		
		return resultMap;
	}
	
	@RequestMapping("departmentUpdate")
	@ResponseBody
	public Map<String, String> departmentUpdate (@RequestParam Map<String, Object> paramMap, HttpSession session) {
		Map<String, String> resultMap = new HashMap<>();
		
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		try {
	        int result = departmentService.departmentUpdate(paramMap);

	        if (result > 0) {
	            resultMap.put("result", "success");
	            resultMap.put("message", "수정되었습니다.");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "수정에 실패했습니다.");
	        }
	    } catch (DuplicateKeyException e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "이미 존재하는 부서 코드입니다.");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "예기치 못한 오류가 발생했습니다.");
	    }
		
		return resultMap;
	}
	
	@RequestMapping("departmentDelete")
	@ResponseBody
	public Map<String, String> departmentDelete (@RequestParam Map<String, Object> paramMap) {
		Map<String, String> resultMap = new HashMap<>();
		
		try {
	        int result = departmentService.departmentDelete(paramMap);

	        if (result > 0) {
	            resultMap.put("result", "success");
	            resultMap.put("message", "삭제되었습니다.");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "삭제에 실패했습니다.");
	        }
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "예기치 못한 오류가 발생했습니다.");
	    }
		
		return resultMap;
	}
}
