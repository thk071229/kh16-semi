package com.kh.semi.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.RegionDao;

@CrossOrigin
@RestController
@RequestMapping("/rest/region")
public class RegionRestCotroller {

	@Autowired
	private RegionDao regionDao;
	
	/*
	 * @GetMapping("/list") public
	 */
}
