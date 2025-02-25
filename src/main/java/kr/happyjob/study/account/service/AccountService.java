package kr.happyjob.study.account.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.account.model.AccountModel;

public interface AccountService {
	List<AccountModel> getAccountList(Map<String, Object> paramMap) throws Exception;
	
	List<AccountModel> accountSearchList(Map<String, Object> paramMap) throws Exception;
	
	List<AccountModel> accountGroupList() throws Exception;

	int getAccountListCnt(Map<String, Object> paramMap) throws Exception;
	
	int accountSave(Map<String, Object> paramMap) throws Exception;

	int accountUpdate(Map<String, Object> paramMap) throws Exception;

	int accountDelete(Map<String, Object> paramMap) throws Exception;
	
	
}
