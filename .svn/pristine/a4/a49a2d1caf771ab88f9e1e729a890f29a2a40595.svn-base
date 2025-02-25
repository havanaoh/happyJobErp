package kr.happyjob.study.system.controller;

import java.io.File;
import java.net.URLEncoder;
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

import kr.happyjob.study.system.model.NoticeModel;
import kr.happyjob.study.system.service.NoticeService;

@Controller
@RequestMapping("/system/")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("notice")
	public String init() throws Exception {
		
		return "system/notice";
	}
	
	@RequestMapping("noticeList.do")
	@ResponseBody
	public Map<String, Object> getNoticeList(@RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("paramMap ======= " + paramMap);
		Map<String, Object> resultMap = new HashMap<>();
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);

		List<NoticeModel> noticeList = noticeService.noticeList(paramMap);
		int noticeCnt = noticeService.noticeListCnt(paramMap);
		
		resultMap.put("noticeCnt", noticeCnt);
		resultMap.put("noticeList", noticeList);

		return resultMap;
	}
	
	@RequestMapping("noticeDetail.do")
	@ResponseBody
	public Map<String, Object> noticeDetail(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		NoticeModel detailValue = noticeService.noticeDetail(paramMap);
		
		resultMap.put("detail", detailValue);
		
		return resultMap;
	}
	
	@RequestMapping("noticeFileDetail.do")
	@ResponseBody
	public Map<String, Object> noticeFileDetail(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		NoticeModel detailValue = noticeService.noticeFileDetail(paramMap);
		
		resultMap.put("detail", detailValue);
		
		return resultMap;
	}
	
	@RequestMapping("noticeSave.do")
	@ResponseBody
	public Map<String, String> noticeSave(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveNotice ======= " + paramMap);
		
		String loginId = (String) session.getAttribute("loginId");
		
		paramMap.put("loginId", loginId);
		
		int result = noticeService.noticeSave(paramMap);
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
				
		return resultMap; 
	}
	
	@RequestMapping("noticeFileSave.do")
	@ResponseBody
	public Map<String, String> noticeFileSave(@RequestParam Map<String, Object> paramMap, HttpSession session,
			HttpServletRequest req) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		
		paramMap.put("loginId", loginId);		
		
		int result = noticeService.noticeFileSave(paramMap, req);
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("noticeFileUpdate.do")
	@ResponseBody
	public Map<String, String> noticeFileUpdate(@RequestParam Map<String, Object> paramMap, HttpSession session,
			HttpServletRequest req) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		
		paramMap.put("loginId", loginId);		
		
		int result = noticeService.noticeFileUpdate(paramMap, req);
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("noticeUpdate.do")
	@ResponseBody
	public Map<String, String> noticeUpdate(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveNotice ======= " + paramMap);

		int result = noticeService.noticeUpdate(paramMap);
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
				
		return resultMap; 
	}
	
	@RequestMapping("noticeDelete.do")
	@ResponseBody
	public Map<String, String> noticeDelete(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveNotice ======= " + paramMap);

		int result = noticeService.noticeDelete(paramMap);
		
		// Mapper 성공 : 1, 실패 : 0
		if (result > 0){
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
				
		return resultMap;
	}
	
	@RequestMapping("noticeDownload.do")
	public void noticeDownload(@RequestParam Map<String, Object> paramMap, HttpServletResponse res) throws Exception {
		NoticeModel notice = noticeService.noticeFileDetail(paramMap);
		
		// 파일 경로 가져오기
		String filePath = notice.getPhysicalPath();
		
		// 가져온 파일을 0,1로 구성된 byte array로 변환
		byte bytes[] = FileUtils.readFileToByteArray(new File(filePath));
		
		// 파일 설정
		res.setContentType("application/octet-stream");
		res.setContentLength(bytes.length);
		res.setHeader("Content-Disposition",
	            "attachment; fileName=\"" + URLEncoder.encode(notice.getFileName(), "UTF-8") + "\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		res.getOutputStream().write(bytes);
		res.getOutputStream().flush();
		res.getOutputStream().close();
		
	}
}
