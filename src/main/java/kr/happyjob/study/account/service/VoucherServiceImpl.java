package kr.happyjob.study.account.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.account.dao.VoucherDao;
import kr.happyjob.study.account.model.VoucherModel;

@Service
public class VoucherServiceImpl implements VoucherService {
	@Autowired
	VoucherDao voucherDao;
	

	@Override
	public List<VoucherModel> getVoucherList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return voucherDao.getVoucherList(paramMap);
	}

	@Override
	public int getVoucherListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return voucherDao.getVoucherListCnt(paramMap);
	}
	
	@Override
	public String selectSalesVoucherNo() throws Exception {
		return voucherDao.selectSalesVoucherNo();
	}

	@Override
	public int insertReceivable(Map<String, Object> paramMap) throws Exception {
		String voucherNo = voucherDao.selectSalesVoucherNo();
		paramMap.put("voucherNo", voucherNo);
		return voucherDao.insertReceivable(paramMap);
	}

	@Override
	public int insertReceivableHistory(Map<String, Object> paramMap) throws Exception {
		String voucherNo = voucherDao.selectSalesVoucherNo();
		paramMap.put("voucherNo", voucherNo);
		return voucherDao.insertReceivableHistory(paramMap);
	}

	@Override
	public String selectExpenseVoucherSeq() throws Exception {
		// TODO Auto-generated method stub
		return voucherDao.selectExpenseVoucherSeq();
	}

	@Override
	public int insertExpenseVoucher(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return voucherDao.insertExpenseVoucher(paramMap);
	}

}
