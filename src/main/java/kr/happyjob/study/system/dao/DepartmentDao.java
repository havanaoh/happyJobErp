package kr.happyjob.study.system.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.DepartmentModel;

public interface DepartmentDao {

	public List<DepartmentModel> getDepartmentList(Map<String, Object> paramMap) throws Exception;

	public int getDepartmentCnt(Map<String, Object> paramMap) throws Exception;

	public DepartmentModel departmentDetail(Map<String, Object> paramMap) throws Exception;

	public int departmentSave(Map<String, Object> paramMap) throws Exception;

	public int departmentUpdate(Map<String, Object> paramMap) throws Exception;

	public int departmentDelete(Map<String, Object> paramMap) throws Exception;

}
