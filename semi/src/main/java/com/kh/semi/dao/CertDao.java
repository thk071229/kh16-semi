package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.CertDto;
import com.kh.semi.mapper.CertMapper;

@Repository
public class CertDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private CertMapper certMapper;
	
	public void insert(CertDto certDto) {
		String sql = "insert into cert(cert_email, cert_number) values(?, ?)";
		Object[] params = {certDto.getCertEmail(), certDto.getCertNumber()};
		jdbcTemplate.update(sql, params);
	}
	public boolean update(CertDto certDto) {
		String sql = "update cert set cert_number=?, cert_time=systimestamp where cert_email=?";
		Object[] params = { certDto.getCertNumber(), certDto.getCertEmail() };
		return jdbcTemplate.update(sql, params) > 0;
	}
	public CertDto selectOne(String certEmail) {
		String sql = "select * from cert where cert_email = ?";
		Object[] params = {certEmail};
		List<CertDto> list = jdbcTemplate.query(sql, certMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	public boolean delete(String certEmail) {
		String sql = "delete cert where cert_email = ?";
		Object[] params = {certEmail};
		return jdbcTemplate.update(sql, params) > 0;
	}
}
