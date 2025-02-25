package kr.happyjob.study.personnel.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.personnel.model.GroupListModel;

public interface GroupListDao {
	
	List<GroupListModel> departmentGroupList() throws Exception;
	
	List<GroupListModel> jobGradeGroupList() throws Exception;
	
	List<GroupListModel> jobRoleGroupList(Map<String, Object> paramMap) throws Exception;

}
