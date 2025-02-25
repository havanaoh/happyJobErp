package kr.happyjob.study.personnel.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.personnel.dao.PromotionDao;
import kr.happyjob.study.personnel.model.PromotionModel;

@Service
public class PromotionServiceImpl implements PromotionService {
	
	@Autowired
	private PromotionDao promotionDao;
	
	@Override
	public List<PromotionModel> promotionList(Map<String, Object> paramMap) throws Exception {
		return promotionDao.promotionList(paramMap);
	}

	@Override
	public int promotionListCnt(Map<String, Object> paramMap) throws Exception {
		return promotionDao.promotionListCnt(paramMap);
	}

	@Override
	public List<PromotionModel> promotionDetailList(Map<String, Object> paramMap) throws Exception {
		return promotionDao.promotionDetailList(paramMap);
	}

	@Override
	public int promotionDetailCnt(Map<String, Object> paramMap) throws Exception {
		return promotionDao.promotionDetailCnt(paramMap);
	}
}
