package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.system.dao.DepartmentDao;
import kr.happyjob.study.system.model.DepartmentModel;

@Service
public class DepartmentServiceImpl implements DepartmentService {

	@Autowired
	DepartmentDao departmentDao;

	@Override
	public List<DepartmentModel> getDepartmentList(Map<String, Object> paramMap) throws Exception {
		return departmentDao.getDepartmentList(paramMap);
	}

	@Override
	public int getDepartmentCnt(Map<String, Object> paramMap) throws Exception {
		return departmentDao.getDepartmentCnt(paramMap);
	}

	@Override
	public DepartmentModel departmentDetail(Map<String, Object> paramMap) throws Exception {
		return departmentDao.departmentDetail(paramMap);
	}

	@Override
	public int departmentSave(Map<String, Object> paramMap) throws Exception {
		return departmentDao.departmentSave(paramMap);
	}

	@Override
	public int departmentUpdate(Map<String, Object> paramMap) throws Exception {
		return departmentDao.departmentUpdate(paramMap);
	}

	@Override
	public int departmentDelete(Map<String, Object> paramMap) throws Exception {
		return departmentDao.departmentDelete(paramMap);
	}
	
}
