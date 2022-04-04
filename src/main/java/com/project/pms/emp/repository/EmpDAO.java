package com.project.pms.emp.repository;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.project.pms.emp.vo.Emp;

@Repository
public interface EmpDAO {

	// 사원정보조회
	public Emp empInfo(int empId);
	
	// 사원추가
	public void saveEmp(Emp emp);
	
	// 비밀번호 변경
	public void modifyPassword(Emp emp);
	
	// 프로필 수정
	public void modifyProfile(Emp emp);
	
}
