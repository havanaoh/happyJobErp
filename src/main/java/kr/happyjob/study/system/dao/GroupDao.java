package kr.happyjob.study.system.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.DepartmentModel;
import kr.happyjob.study.system.model.GroupModel;

public interface GroupDao {

	public List<GroupModel> getGroupList(Map<String, Object> paramMap) throws Exception;

	public int getGroupCnt(Map<String, Object> paramMap) throws Exception;
	
	public List<GroupModel> getDetailList(Map<String, Object> paramMap) throws Exception;

	public int getDetailCnt(Map<String, Object> paramMap) throws Exception;

	public GroupModel groupDetail(Map<String, Object> paramMap) throws Exception;
	
	public GroupModel detailDetail(Map<String, Object> paramMap) throws Exception;

	public int groupSave(Map<String, Object> paramMap) throws Exception;

	public int groupUpdate(Map<String, Object> paramMap) throws Exception;
	
	public int detailSave(Map<String, Object> paramMap) throws Exception;

	public int detailUpdate(Map<String, Object> paramMap) throws Exception;


}
