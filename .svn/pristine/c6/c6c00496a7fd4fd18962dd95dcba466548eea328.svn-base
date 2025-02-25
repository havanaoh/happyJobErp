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

import kr.happyjob.study.system.model.GroupModel;
import kr.happyjob.study.system.service.GroupService;

@Controller
@RequestMapping("/system")
public class GroupController {
	
	@Autowired
	private GroupService groupService;
	
	@RequestMapping("code")
	public String init() throws Exception {
		return "system/group";
	}

	@RequestMapping("groupList")
	public String getGroup(@RequestParam Map<String, Object> paramMap, HttpSession session, Model model) throws Exception {
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		List<GroupModel> groupList = groupService.getGroupList(paramMap);
		int groupCnt = groupService.getGroupCnt(paramMap);
		
		model.addAttribute("groupList", groupList);
		model.addAttribute("groupCnt", groupCnt);
		
		return "system/groupList";
	}
	
	@RequestMapping("detailList")
	public String getDetail(@RequestParam Map<String, Object> paramMap, HttpSession session, Model model) throws Exception {
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		List<GroupModel> detailList = groupService.getDetailList(paramMap);
		int detailCnt = groupService.getDetailCnt(paramMap);
		
		model.addAttribute("detailList", detailList);
		model.addAttribute("detailCnt", detailCnt);
		
		return "system/detailList";
	}
	
	@RequestMapping("groupDetail")
	@ResponseBody
	public Map<String, Object> groupDetail (@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		GroupModel groupDetailValue = groupService.groupDetail(paramMap);
		
		resultMap.put("detail", groupDetailValue);
				
		return resultMap;
	}
	
	@RequestMapping("detailDetail")
	@ResponseBody
	public Map<String, Object> detailDetail (@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		GroupModel detailDetailValue = groupService.detailDetail(paramMap);
		
		resultMap.put("detail", detailDetailValue);
				
		return resultMap;
	}
	
	@RequestMapping("groupSave")
	@ResponseBody
	public Map<String, String> groupSave (@RequestParam Map<String, Object> paramMap, HttpSession session) {
		Map<String, String> resultMap = new HashMap<>();
		
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		try {
	        int result = groupService.groupSave(paramMap);

	        if (result > 0) {
	            resultMap.put("result", "success");
	            resultMap.put("message", "저장되었습니다.");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "저장에 실패했습니다.");
	        }
	    } catch (DuplicateKeyException e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "이미 존재하는 공통 코드입니다.");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "예기치 못한 오류가 발생했습니다.");
	    }
		
		return resultMap;
	}
	
	@RequestMapping("groupUpdate")
	@ResponseBody
	public Map<String, String> groupUpdate (@RequestParam Map<String, Object> paramMap, HttpSession session) {
		Map<String, String> resultMap = new HashMap<>();
		
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		try {
	        int result = groupService.groupUpdate(paramMap);

	        if (result > 0) {
	            resultMap.put("result", "success");
	            resultMap.put("message", "수정되었습니다.");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "수정에 실패했습니다.");
	        }
	    } catch (DuplicateKeyException e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "이미 존재하는 공통 코드입니다.");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "예기치 못한 오류가 발생했습니다.");
	    }
		
		return resultMap;
	}
	
	
	
	@RequestMapping("detailSave")
	@ResponseBody
	public Map<String, String> detailSave (@RequestParam Map<String, Object> paramMap, HttpSession session) {
		Map<String, String> resultMap = new HashMap<>();
		
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		try {
	        int result = groupService.detailSave(paramMap);

	        if (result > 0) {
	            resultMap.put("result", "success");
	            resultMap.put("message", "저장되었습니다.");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "저장에 실패했습니다.");
	        }
	    } catch (DuplicateKeyException e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "이미 존재하는 공통 코드입니다.");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "예기치 못한 오류가 발생했습니다.");
	    }
		
		return resultMap;
	}
	
	@RequestMapping("detailUpdate")
	@ResponseBody
	public Map<String, String> detailUpdate (@RequestParam Map<String, Object> paramMap, HttpSession session) {
		Map<String, String> resultMap = new HashMap<>();
		
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		try {
	        int result = groupService.detailUpdate(paramMap);

	        if (result > 0) {
	            resultMap.put("result", "success");
	            resultMap.put("message", "수정되었습니다.");
	        } else {
	            resultMap.put("result", "fail");
	            resultMap.put("message", "수정에 실패했습니다.");
	        }
	    } catch (DuplicateKeyException e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "이미 존재하는 공통 코드입니다.");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "예기치 못한 오류가 발생했습니다.");
	    }
		
		return resultMap;
	}
	
	
}
