package kr.happyjob.study.personnel.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.happyjob.study.personnel.model.GroupListModel;

public interface GroupListService {
	List<GroupListModel> departmentGroupList() throws Exception;
	
	List<GroupListModel> jobGradeGroupList() throws Exception;
	
	List<GroupListModel> jobRoleGroupList(Map<String, Object> paramMap) throws Exception;
}
