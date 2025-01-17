package com.project.pms.output.controller;

import java.io.IOException;
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

import com.project.pms.emp.vo.Emp;
import com.project.pms.output.service.OutputService;
import com.project.pms.output.vo.Output;
import com.project.pms.output.vo.OutputDetail;
import com.project.pms.output.vo.OutputFile;
import com.project.pms.output.vo.OutputFileInfo;
import com.project.pms.output.vo.OutputForm;
import com.project.pms.output.vo.OutputListForm;
import com.project.pms.output.vo.OutputSearchCriteria;
import com.project.pms.utils.FileStore;

@Controller
@RequestMapping("/output/*")
public class OutputController {

	@Autowired
	private FileStore fileStore;
	
	@Autowired
	private OutputService service;
	
	@GetMapping("/list.do")
	public String getList(Model model) {
		
		model.addAttribute("category", service.getOutputCategory());
		model.addAttribute("type", service.getOutputType());
		model.addAttribute("project", service.getProjectInfo());
		
		return "output/list";
	}
	
	@ResponseBody
	@GetMapping("/api/list.do")
	public Map<String, Object> getSearchList(OutputSearchCriteria sc) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int start = sc.getStart() + 1;
		int length = sc.getStart() + 10;
		
		sc.setStart(start);
		sc.setLength(length);
		
		List<OutputListForm> list = service.getOutputList(sc);
		int size = service.getOutputCount(sc);
		
		map.put("data", list);
		map.put("iTotalRecords", size);
		map.put("iTotalDisplayRecords", size);
		
		return map;
		
	}
	
	@ResponseBody
	@GetMapping("/detail/{outputId}")
	public ResponseEntity<OutputDetail> getOutputDetail(@PathVariable Integer outputId) {
		return ResponseEntity.ok(service.getOutputDetail(outputId));
	}
	
	@PostMapping("/save.do")
	public ResponseEntity<String> saveOutput(HttpSession session, OutputForm form) {
		
		Emp emp = (Emp) session.getAttribute("emp");
		
		Output output = new Output();
		output.setEmpId(emp.getEmpId()); // session에서 가져올것
		output.setOutputType(form.getOutputType());
		output.setCategoryId(form.getCategoryId());
		output.setTaskId(form.getTaskId());
		output.setContent(form.getContent());

		OutputFile file;
		try {
			file = fileStore.storeFile(form.getFile());
		} catch (IllegalStateException | IOException e) {
			System.out.println(e.getMessage());
			return ResponseEntity.badRequest().body("fail");
		}
		
		service.saveOutputWithFile(output, file);
		
		return ResponseEntity.ok().body("success");
	}
	
	@GetMapping("/attach/{outputFileId}")
	public String downloadAttach(@PathVariable Integer outputFileId, Model model) {
		OutputFileInfo outputFile = service.getOutputFile(outputFileId);
		model.addAttribute("storeFileName", outputFile.getSaveName());
		model.addAttribute("uploadFileName", outputFile.getOriginalName());
		
		return "download";
	}
	
	@ResponseBody
	@PostMapping(value = "/update/{outputId}")
	public ResponseEntity<String> updateOutput(@PathVariable Integer outputId, Output output) {
		
		System.out.println(output);
		
		boolean result = service.updateOutput(output);
		
		return result ? ResponseEntity.ok().body("success") : ResponseEntity.badRequest().body("fail");
	}
	
	@ResponseBody
	@PostMapping("/delete/{outputId}")
	public ResponseEntity<String> deleteOutput(@PathVariable Integer outputId) {
		
		boolean result = service.deleteOutputWithFile(outputId);
		
		return result ? ResponseEntity.ok().body("success") : ResponseEntity.badRequest().body("fail");
	}
	
}
