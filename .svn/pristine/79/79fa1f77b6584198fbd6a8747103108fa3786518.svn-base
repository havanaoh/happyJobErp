package kr.happyjob.study.system.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.common.comnUtils.FileUtilMultipartFile;
import kr.happyjob.study.system.dao.NoticeDao;
import kr.happyjob.study.system.model.NoticeModel;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Override
	public List<NoticeModel> noticeList(Map<String, Object> paramMap) throws Exception {
		return noticeDao.noticeList(paramMap);
	}

	@Override
	public int noticeListCnt(Map<String, Object> paramMap) throws Exception {
		return noticeDao.noticeListCnt(paramMap);
	}

	@Override
	public NoticeModel noticeDetail(Map<String, Object> paramMap) throws Exception {
		return noticeDao.noticeDetail(paramMap);
	}

	@Override
	public int noticeSave(Map<String, Object> paramMap) throws Exception {
		return noticeDao.noticeSave(paramMap);
	}

	@Override
	public int noticeUpdate(Map<String, Object> paramMap) throws Exception {
		return noticeDao.noticeUpdate(paramMap);
	}

	@Override
	public int noticeDelete(Map<String, Object> paramMap) throws Exception {
		// 기존에 있던 파일을 삭제
		NoticeModel getDetail = noticeDao.noticeFileDetail(paramMap);

		if(getDetail.getFileName() != null) {
			File oldFile = new File(getDetail.getPhysicalPath());
			oldFile.delete();
		}
		
		return noticeDao.noticeDelete(paramMap);
	}

	@Override
	public int noticeFileSave(Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req;
		
		String itemFilePath = noticePath + File.separator;
				
		FileUtilCho fileUpload = new FileUtilCho(multiFile, rootPath, virtualRootPath, itemFilePath);
		
		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		
		if (fileInfo.get("file_nm") == null) {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		} else {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		}
		
		return noticeDao.noticeFileSave(paramMap);
	}

	@Override
	public int noticeFileUpdate(Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		// 기존에 있던 파일을 삭제
		NoticeModel getDetail = noticeDao.noticeFileDetail(paramMap);
				
		// 변경된 파일을 저장
		MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req;
		
		String itemFilePath = noticePath + File.separator;
				
		FileUtilCho fileUpload = new FileUtilCho(multiFile, rootPath, virtualRootPath, itemFilePath);
		
		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		
		if(fileInfo != null && fileInfo.get("file_nm") != null) {
			if(getDetail.getFileName() != null && !(getDetail.getFileName().equals(fileInfo.get("file_nm")))) {
				File oldFile = new File(getDetail.getPhysicalPath());
				oldFile.delete();
			}
		}
		
		if (fileInfo.get("file_nm") == null) {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		} else {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		}
		
		return noticeDao.noticeFileUpdate(paramMap);
	}

	@Override
	public NoticeModel noticeFileDetail(Map<String, Object> paramMap) throws Exception {
		return noticeDao.noticeFileDetail(paramMap);
	}

}
