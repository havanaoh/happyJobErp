package kr.happyjob.study.business.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.business.dao.ClientDao;

@Service
public class ClinetServiceImpl implements ClientService {

	@Autowired
	private ClientDao clientDao;

	@Override
	public List<Map<String, Object>> getClientList() {

		return clientDao.getClientList();
	}

	
	@Override
	public List<Map<String, Object>> searchClientList( Map<String, Object> params) {
		// TODO Auto-generated method stub
		return clientDao.searchClientList(params);
	}


	@Override
	public int insertClientList(Map<String, Object> params) {
		
		
		return clientDao.insertClientList(params);
	}


	@Override
	public int isExist(Map<String, Object> params) {
		
		int findRow=clientDao.isExist(params);
		
		 return findRow; 
	}


	@Override
	public int getMaxId(Map<String, Object> params) {
		int createClientId=clientDao.getMaxId(params);
		return createClientId;
	}


	@Override
	public int updateClientList(Map<String, Object> params) {
		
		int affectedRow=clientDao.updateClientList(params);
		return affectedRow;
	}

}
