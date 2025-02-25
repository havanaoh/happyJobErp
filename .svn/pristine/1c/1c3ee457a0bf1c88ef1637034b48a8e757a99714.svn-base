package kr.happyjob.study.personnel.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.personnel.dao.GroupListDao;
import kr.happyjob.study.personnel.model.GroupListModel;

@Service
public class GroupListServiceImpl implements GroupListService {
	
	@Autowired
	GroupListDao groupListDao;
	
	@Override
	public List<GroupListModel> departmentGroupList() throws Exception {
		return groupListDao.departmentGroupList();
	}

	@Override
	public List<GroupListModel> jobGradeGroupList() throws Exception {
		return groupListDao.jobGradeGroupList();
	}

	@Override
	public List<GroupListModel> jobRoleGroupList(Map<String, Object> paramMap) throws Exception {
		return groupListDao.jobRoleGroupList(paramMap);
	}

}
