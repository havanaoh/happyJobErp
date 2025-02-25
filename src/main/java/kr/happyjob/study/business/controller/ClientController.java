package kr.happyjob.study.business.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.business.service.ClientService;



@Controller
@RequestMapping("/business/")
public class ClientController {	
	
	
	@Autowired
	private ClientService clientService;	

	@RequestMapping("/client-list")
	public String getClientListPage() {
		return "business/client";
	}	
		
	@ResponseBody
	@RequestMapping("/searchClientList.do")
	public Map<String, Object> searchClientList(@RequestParam Map<String,Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clientList", clientService.searchClientList(params));
		return map;
	}
	
	
	
	@ResponseBody
	@RequestMapping("/insertClientList.do")
	public Map<String, Object> insertClientList(@RequestParam Map<String,Object> params) {

		Map<String, Object> map = new HashMap<String, Object>();
		
		int findRow=clientService.isExist(params);
		
		if(findRow>=1){
				map.put("findRow", findRow);
				
				return map;
			
		}
		
		
		int createClientId=clientService.getMaxId(params);
		
		params.put("id", createClientId+1);
		
		int affectedRow=clientService.insertClientList(params);
		
		map.put("affectedRow", affectedRow);
		
		return map;
		
		
	}
	
	@ResponseBody
	@RequestMapping("/updateClientList.do")
	public Map<String, Object> updateClientList(@RequestParam Map<String,Object> params) {
		
		Map<String, Object> map = new HashMap<String, Object>();		
		int affectedRow=clientService.updateClientList(params);
		
		map.put("affectedRow", affectedRow);
		
		return map;
		
		
	}
	
	
	
	
	
	
	@ResponseBody
	@RequestMapping("/client-list.do")
	public Map<String, Object> getManufacturer() {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clientList", clientService.getClientList());
		return map;
	}

}
