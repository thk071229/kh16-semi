package com.kh.semi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.semi.dao.RegionDao;
import com.kh.semi.dto.RegionDto;

@Service
public class RegionService {

	@Autowired
	private RegionDao regionDao;
	
	@Transactional
	public int createRegion(String regionName){
		  //1.regionNo가 있는지 확인
		  RegionDto origin = regionDao.findByRegionName(regionName);
		  
		  //2. regionNo가 있다면 번호 가져와
		  if(origin != null) {
		    return origin.getRegionNo();
		  }
		  else{//없다면
		    RegionDto regionDto = new RegionDto();
		    int regionNo = regionDao.sequence();//시퀀스 만들고
		    regionDto.setRegionNo(regionNo);
		    regionDto.setRegionName(regionName);
		    regionDto.setRegionDepth1(regionDto.getRegionDepth1());
		    regionDto.setRegionDepth2(regionDto.getRegionDepth2());
		    regionDao.insert(regionDto);//No랑 Name 담아서 insert
		    return regionNo;//반환
		  }
	}
	
}
