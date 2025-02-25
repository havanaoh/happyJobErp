package kr.happyjob.study.account.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.account.model.VoucherModel;

public interface VoucherDao {
	List<VoucherModel> getVoucherList(Map<String, Object> paramMap) throws Exception;

	int getVoucherListCnt(Map<String, Object> paramMap) throws Exception;
	
	int insertReceivable(Map<String, Object> paramMap) throws Exception;
	
	int insertReceivableHistory(Map<String, Object> paramMap) throws Exception;	
	
	String selectExpenseVoucherSeq() throws Exception;
	
	String selectSalesVoucherNo() throws Exception;
	
	int insertExpenseVoucher(Map<String, Object> paramMap) throws Exception;	

}
