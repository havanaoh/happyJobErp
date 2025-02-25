package kr.happyjob.study.account.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.account.dao.AccountDao;
import kr.happyjob.study.account.model.AccountModel;

@Service
public class AccountServiceImpl implements AccountService {
	
	@Autowired
	AccountDao accountDao;
	
	@Value("${fileUpload.accountPath}")
	private String accountPath;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;

	@Override
	public List<AccountModel> getAccountList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return accountDao.getAccountList(paramMap);
	}

	@Override
	public int getAccountListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return accountDao.getAccountListCnt(paramMap);
	}

	@Override
	public int accountSave(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return accountDao.accountSave(paramMap);
	}

	@Override
	public int accountUpdate(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return accountDao.accountUpdate(paramMap);
	}

	@Override
	public int accountDelete(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return accountDao.accountDelete(paramMap);
	}

	@Override
	public List<AccountModel> accountSearchList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return accountDao.accountSearchList(paramMap);
	}

	@Override
	public List<AccountModel> accountGroupList() throws Exception {
		// TODO Auto-generated method stub
		return accountDao.accountGroupList();
	}
	
	
	
	
}
