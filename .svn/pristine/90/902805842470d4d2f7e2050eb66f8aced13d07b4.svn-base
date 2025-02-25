package kr.happyjob.study.account.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.account.model.AccountModel;
import kr.happyjob.study.account.model.ExpenseModel;
import kr.happyjob.study.business.model.BusinessModel;
import kr.happyjob.study.login.model.LgnInfoModel;

public interface ExpenseDao {
	List<ExpenseModel> getExpenseList(Map<String, Object> paramMap) throws Exception;
	
	List<ExpenseModel> getAllExpenseList(Map<String, Object> paramMap) throws Exception;

	List<AccountModel> expenseSearchList(Map<String, Object> paramMap) throws Exception;
	
	LgnInfoModel expenseUser(Map<String, Object> paramMap) throws Exception;
	
	List<BusinessModel> expenseClient() throws Exception;
	
	int getExpenseListCnt(Map<String, Object> paramMap) throws Exception;
	
	int getAllExpenseListCnt(Map<String, Object> paramMap) throws Exception;

	List<AccountModel> expenseCrebitList() throws Exception;
	
	int expenseUpdate(Map<String, Object> paramMap) throws Exception;
	
	int expenseLastUpdate(Map<String, Object> paramMap) throws Exception;
	
	int expenseDelete(Map<String, Object> paramMap) throws Exception;
	
	int expenseFileSave(Map<String, Object> paramMap) throws Exception;

	ExpenseModel expenseFileDetail(Map<String, Object> paramMap) throws Exception;	

}
