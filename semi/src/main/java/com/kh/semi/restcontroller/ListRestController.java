/* 시간 남을때 ajax 이용하기 위한 restController
 * package com.kh.semi.restcontroller;
 * 
 * import java.util.ArrayList; import java.util.Collections; import
 * java.util.HashMap; import java.util.List; import java.util.Map;
 * 
 * import org.eclipse.tags.shaded.org.apache.bcel.generic.RETURN; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.web.bind.annotation.CrossOrigin; import
 * org.springframework.web.bind.annotation.ModelAttribute; import
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestParam; import
 * org.springframework.web.bind.annotation.RestController;
 * 
 * import com.kh.semi.dao.BoardDao; import com.kh.semi.dao.ClubDao; import
 * com.kh.semi.dao.EventDao; import com.kh.semi.vo.BoardListVO; import
 * com.kh.semi.vo.PageVO;
 * 
 * @CrossOrigin
 * 
 * @RestController
 * 
 * @RequestMapping("/rest/list") public class ListRestController {
 * 
 * @Autowired private BoardDao boardDao;
 * 
 * @Autowired private ClubDao clubDao;
 * 
 * @Autowired private EventDao eventDao;
 * 
 * @PostMapping("/more") public Map<String, Object> list(
 * 
 * @ModelAttribute PageVO pageVO,
 * 
 * @RequestParam String type) { Map<String, Object> response = new HashMap<>();
 * List<?> list = new ArrayList<>(); int dataCount = 0;
 * 
 * switch(type.toLowerCase()) { case "board" : int clubNo =
 * pageVO.getParentParamsValue(); dataCount = boardDao.count(pageVO, clubNo);
 * pageVO.setDataCount(dataCount); list = boardDao.selectListWithPaging(pageVO,
 * clubNo); break; case "club" : list = clubDao.selectList(pageVO); break;
 * default : break; } response.put("list", list); response.put("dataCount",
 * dataCount);
 * 
 * return response; } }
 */