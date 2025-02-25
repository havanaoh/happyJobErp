package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.system.dao.DepartmentDao;
import kr.happyjob.study.system.dao.GroupDao;
import kr.happyjob.study.system.model.DepartmentModel;
import kr.happyjob.study.system.model.GroupModel;

@Service
public class GroupServiceImpl implements GroupService {

	@Autowired
	GroupDao groupDao;

	@Override
	public List<GroupModel> getGroupList(Map<String, Object> paramMap) throws Exception {
		return groupDao.getGroupList(paramMap);
	}

	@Override
	public int getGroupCnt(Map<String, Object> paramMap) throws Exception {
		return groupDao.getGroupCnt(paramMap);
	}

	@Override
	public GroupModel groupDetail(Map<String, Object> paramMap) throws Exception {
		return groupDao.groupDetail(paramMap);
	}

	@Override
	public int groupSave(Map<String, Object> paramMap) throws Exception {
		return groupDao.groupSave(paramMap);
	}

	@Override
	public int groupUpdate(Map<String, Object> paramMap) throws Exception {
		return groupDao.groupUpdate(paramMap);
	}

	@Override
	public List<GroupModel> getDetailList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return groupDao.getDetailList(paramMap);
	}

	@Override
	public int getDetailCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return groupDao.getDetailCnt(paramMap);
	}

	@Override
	public GroupModel detailDetail(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return groupDao.detailDetail(paramMap);
	}

	@Override
	public int detailSave(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return groupDao.detailSave(paramMap);
	}

	@Override
	public int detailUpdate(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return groupDao.detailUpdate(paramMap);
	}

}
