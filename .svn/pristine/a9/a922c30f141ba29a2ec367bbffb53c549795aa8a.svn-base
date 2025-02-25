package kr.happyjob.study.account.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.account.dao.ExpenseDao;
import kr.happyjob.study.account.model.AccountModel;
import kr.happyjob.study.account.model.ExpenseModel;
import kr.happyjob.study.business.model.BusinessModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.login.model.LgnInfoModel;

@Service
public class ExpenseServiceImpl implements ExpenseService {
	
	@Autowired
	ExpenseDao expenseDao;
	
	@Autowired
	private ExpenseService expenseService;
	
	@Value("${fileUpload.accountPath}")
	private String accountPath;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;

	@Override
	public List<ExpenseModel> getExpenseList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return expenseDao.getExpenseList(paramMap);
	}

	@Override
	public int getExpenseListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return expenseDao.getExpenseListCnt(paramMap);
	}


	@Override
	public int expenseUpdate(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return expenseDao.expenseUpdate(paramMap);
	}

	@Override
	public int expenseDelete(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return expenseDao.expenseDelete(paramMap);
	}

	@Override
	public List<AccountModel> expenseSearchList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return expenseDao.expenseSearchList(paramMap);
	}

	@Override
	public LgnInfoModel expenseUser(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return expenseDao.expenseUser(paramMap);
	}

	@Override
	public List<BusinessModel> expenseClient() throws Exception {
		// TODO Auto-generated method stub
		return expenseDao.expenseClient();
	}
	
	@Override
	public int expenseFileSave(Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req;
		
		String itemFilePath = accountPath + File.separator;
				
		FileUtilCho fileUpload = new FileUtilCho(multiFile, rootPath, virtualRootPath, itemFilePath);
		
		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		
		if (fileInfo.get("file_nm") == null) {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		} else {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		}
		
		return expenseDao.expenseFileSave(paramMap);
	}

	@Override
	public ExpenseModel expenseFileDetail(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return expenseDao.expenseFileDetail(paramMap);
	}

	@Override
	public List<ExpenseModel> getAllExpenseList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return expenseDao.getAllExpenseList(paramMap);
	}

	@Override
	public int getAllExpenseListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return expenseDao.getAllExpenseListCnt(paramMap);
	}

	@Override
	public List<AccountModel> expenseCrebitList() throws Exception {
		// TODO Auto-generated method stub
		return expenseDao.expenseCrebitList();
	}

	@Override
	@Transactional
	public int expenseLastUpdate(Map<String, Object> paramMap) throws Exception {
		
		return expenseDao.expenseLastUpdate(paramMap);
	}

	
	
}
