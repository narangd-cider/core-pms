package com.project.pms.approval.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.pms.approval.service.ApprovalService;
import com.project.pms.approval.vo.ApprovalForm;
import com.project.pms.approval.vo.ApprovalSearchCriteria;
import com.project.pms.emp.vo.Emp;
import com.project.pms.output.service.OutputService;
import com.project.pms.project.vo.Project;

@Controller
@RequestMapping("/approval")
public class ApprovalController {
	
	@Autowired
	private ApprovalService service;
	
	@Autowired
	private OutputService outputService;

	@GetMapping("/list.do")
	public String getList(Model model) {
		
		model.addAttribute("projectList", outputService.getProjectInfo());
		
		return "approval/list";
	}
	
	@ResponseBody
	@GetMapping("/api/list.do")
	public Map<String, Object> getApprovalList(HttpSession session, Model model, ApprovalSearchCriteria sc) {
		Map<String, Object> map = new HashMap<String, Object>();
		Integer empId = ((Emp)session.getAttribute("emp")).getEmpId();
		int start = sc.getStart() + 1;
		int length = sc.getStart() + 10;
		
		sc.setEmpId(empId);
		sc.setStart(start);
		sc.setLength(length);
		
		List<ApprovalForm> list = service.getApprovalList(sc);
		int size = service.getApprovalCount(sc);
		
		map.put("data", list);
		map.put("iTotalRecords", size);
		map.put("iTotalDisplayRecords", size);
		
		return map;
	}
	
	@ResponseBody
	@PostMapping("/approval/{approvalId}")
	public ResponseEntity<String> setApproval(@PathVariable Integer approvalId) {
		
		int result = service.setApproval(approvalId);
		System.out.println("승인결과" + result);
		return (result == 1) ? ResponseEntity.ok().body("success") : ResponseEntity.badRequest().body("fail"); 
	}
	
	@ResponseBody
	@PostMapping("/reject/{approvalId}")
	public ResponseEntity<String> setReject(@PathVariable Integer approvalId) {
		
		int result = service.setReject(approvalId);
		
		return (result == 1) ? ResponseEntity.ok().body("success") : ResponseEntity.badRequest().body("fail"); 
	}
}
