package kr.happyjob.study.sales.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.sales.dao.ReceivableDao;
import kr.happyjob.study.sales.model.ReceivableModel;

@Service
public class ReceivableServiceImpl implements ReceivableService {
	
	@Autowired
	private ReceivableDao receivableDao;

	@Override
	public List<ReceivableModel> receivableList(Map<String, Object> params) throws Exception {
		return receivableDao.receivableList(params);
	}

	@Override
	public ReceivableModel receivableDetail(Map<String, Object> params) throws Exception {
		return receivableDao.receivableDetail(params);
	}
	
	@Override
	public int insertReceivableHistory(Map<String, Object> params) throws Exception {
		return receivableDao.insertReceivableHistory(params);
	}

	@Override
	public int receivableListCnt(Map<String, Object> params) throws Exception {
		return receivableDao.receivableListCnt(params);
	}

	@Override
	public List<ReceivableModel> receivableDetailList(Map<String, Object> params) throws Exception {
		return receivableDao.receivableDetailList(params);
	}

	@Override
	public int receivableDetailListCnt(Map<String, Object> params) throws Exception {
		return receivableDao.receivableDetailListCnt(params);
	}

	@Override
	public int updateReceivable(Map<String, Object> params) throws Exception {
		return receivableDao.updateReceivable(params);
	}

	@Override
	public int updateReceivableStatus(Map<String, Object> params) throws Exception {
		return receivableDao.updateReceivableStatus(params);
	}
	
}
