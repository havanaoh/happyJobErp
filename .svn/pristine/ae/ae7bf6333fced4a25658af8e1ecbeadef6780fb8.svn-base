package kr.happyjob.study.business.controller;

import java.util.HashMap;
import java.util.Map;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.business.service.PlanService;

@Controller
@RequestMapping("/business/")
public class PlanController {

	@Autowired
	private PlanService planService;

	@RequestMapping("sales-plan")
	public String getManufacturer() {
		return "business/salesPlan";
	}

	@ResponseBody
	@RequestMapping("sales-plan/getmanufacturer.do")
	public Map<String, Object> getManufacturer(Map<String, Object> params) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("manuFacturerList", planService.getManufacturer(params));

		String unitIndustrycode = planService.getUnitindustrycode();

		map.put("unitIndustrycode", unitIndustrycode);

		return map;
	}

	@ResponseBody
	@RequestMapping("sales-plan/getMainCategory.do")
	public Map<String, Object> getMainCategoryList(@RequestParam Map<String, Object> params) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("mainCategory", planService.getMainCategoryList(params));

		return map;
	}

	@ResponseBody
	@RequestMapping("sales-plan/getSubCategoryList.do")
	public Map<String, Object> getSubCategoryList(@RequestParam Map<String, Object> params) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("subCategory", planService.getSubCategoryList(params));

		return map;
	}

	@ResponseBody
	@RequestMapping("sales-plan/getProductList.do")
	public Map<String, Object> getProductList(@RequestParam Map<String, Object> params) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("productList", planService.getProductList(params));

		return map;
	}

	@ResponseBody
	@RequestMapping("sales-plan/searchPlanList.do")
	public Map<String, Object> getdateSearchPlanList(@RequestParam Map<String, Object> params) {

		Map<String, Object> map = new HashMap<String, Object>();

		String defaultPlanList = (String) params.get("enterence");

		if (defaultPlanList != null && defaultPlanList.equals("yes")) {
			map.put("searchPlanList", planService.defaultSearchPlanList(params));
		} else {

			map.put("searchPlanList", planService.searchPlanList(params));
		}

		return map;
	}

	@ResponseBody
	@RequestMapping("sales-plan/insertPlan.do")
	public Map<String, Object> actionInsertPlan(@RequestParam Map<String, Object> params) {

		// 스탭 플로우
		// 먼저 사번이 옳바르게 기입되었는지 검사한다.
		// Map<String, Object> map = planService.checkEmpId(params);
		// Long empId = (Long) map.get("emp_id");
		// String emp_id = empId.toString();
		// System.out.println("emp_id: " + emp_id);

		Map<String, Object> map = new HashMap<String, Object>();

		int randomNumber = (int) (Math.random() * 1000) + 1;
		// 실적수량에 관한 언급이 없으니 여기서 그냥 넣는다.
		params.put("perform_qut", randomNumber);

		// map.put("statusCode", 1);
		// if (emp_id == null) {
		// map.put("statusCode", -1);
		// return map;
		// }

		int affectedRow = planService.insertPlan(params);
		map.put("affectedRow", affectedRow);
		return map;
	}

	@ResponseBody
	@RequestMapping("sales-plan/updatePlan.do")
	public Map<String, Object> actionUpdatePlan(@RequestParam Map<String, Object> params, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		String empIdStr = (String) params.get("emp_id"); // String 타입으로 가져오기
		String userIdxStr =((Integer) session.getAttribute("user_idx")).toString(); // String
																		
	
		if (!empIdStr.equals(userIdxStr)) {

			map.put("statusCode", -1);
			return map;
		}
		;

		// 스탭 플로우
		// 먼저 사번이 옳바르게 기입되었는지 검사한다.
		// Map<String, Object> map = planService.checkEmpId(params);
		// Long empId = (Long) map.get("emp_id");
		// String emp_id = empId.toString();
		// System.out.println("emp_id: " + emp_id);

		int randomNumber = (int) (Math.random() * 1000) + 1;
		// 실적수량에 관한 언급이 없으니 여기서 그냥 넣는다.
		params.put("perform_qut", randomNumber);
		// map.put("statusCode", 1);
		// if (emp_id == null) {
		// map.put("statusCode", -1);
		// return map;
		// }

		int affectedRow = planService.updatePlan(params);
		map.put("affectedRow", affectedRow);
		return map;
	}
	
	

	// deletePlan

	@ResponseBody
	@RequestMapping("sales-plan/deletePlan.do")
	public Map<String, Object> actionDeletePlan(@RequestParam Map<String, Object> params, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		String empIdStr = (String) params.get("emp_id"); // String 타입으로 가져오기
		String userIdxStr =((Integer) session.getAttribute("user_idx")).toString(); // String
																		
	
		if (!empIdStr.equals(userIdxStr)) {

			map.put("statusCode", -1);
			return map;
		}
		;


		int randomNumber = (int) (Math.random() * 1000) + 1;
		// 실적수량에 관한 언급이 없으니 여기서 그냥 넣는다.
		params.put("perform_qut", randomNumber);
		map.put("statusCode", 1);
		int affectedRow = planService.actionDeletePlan(params);
		map.put("affectedRow", affectedRow);
		return map;
	}

	@RequestMapping("sales-list")
	public String salesList() {
		return "business/salesList";
	}

}
