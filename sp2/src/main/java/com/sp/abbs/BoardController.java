package com.sp.abbs;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.FileManager;
import com.sp.common.MyUtil;

@Controller("abbs.boardController")
public class BoardController {
	@Autowired
	private BoardService service;

	@Autowired
	private MyUtil util;

	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/abbs/main")
	public String main() throws Exception {
		return "abbs/main";
	}

	// AJAX - Text
	@RequestMapping(value = "/abbs/list")
	public String list(@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req, Model model) throws Exception {

		int rows = 10;
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) {
			// GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}

		// 전체 페이지 수
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		dataCount = service.dataCount(map);
		if (dataCount != 0)
			total_page = util.pageCount(rows, dataCount);

		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page)
			current_page = total_page;

		// 리스트에 출력할 데이터를 가져오기
		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);

		List<Board> list = service.listBoard(map);

		// 리스트의 번호
		int listNum, n = 0;
		for (Board dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}

		String paging = util.pagingMethod(current_page, total_page, "listPage");

		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);

		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return "abbs/list";
	}

	// AJAX - Text
	@RequestMapping(value = "/abbs/created", method = RequestMethod.GET)
	public String createdForm(Model model) throws Exception {
		model.addAttribute("mode", "created");
		return "abbs/created";
	}

	// AJAX - JSON
	@RequestMapping(value = "/abbs/created", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(Board dto, HttpServletRequest req, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "bbs";

		String state = "true";
		try {
			dto.setIpAddr(req.getRemoteAddr());
			service.insertBoard(dto, pathname);
		} catch (Exception e) {
			state = "false";
		}
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);

		return model;
	}

	// AJAX - Text
	@RequestMapping(value = "/abbs/article", method = RequestMethod.GET)
	public String article(@RequestParam int num, @RequestParam String pageNo,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			HttpServletResponse resp, Model model) throws Exception {

		keyword = URLDecoder.decode(keyword, "utf-8");
		service.updateHitCount(num);

		Board dto = service.readBoard(num);
		if (dto == null) {
			return "abbs/error";
		}

		// 스타일로 처리하는 경우 : style="white-space:pre;"
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);

		Board preReadDto = service.preReadBoard(map);
		Board nextReadDto = service.nextReadBoard(map);

		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);

		model.addAttribute("pageNo", pageNo);

		return "abbs/article";
	}

	@RequestMapping("/abbs/download")
	public void down(@RequestParam int num, HttpServletResponse resp, HttpSession session) throws Exception {

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "bbs";

		Board dto = service.readBoard(num);
		boolean b = false;

		if (dto != null) {
			b = fileManager.doFileDownload(dto.getSaveFilename(), dto.getOriginalFilename(), pathname, resp);
		}

		if (!b) {
			resp.setContentType("text/html;charset=utf-8");
			PrintWriter out = resp.getWriter();
			out.print("<script>alert('파일 다운로드가 실패 했습니다.');history.back();</script>");
		}
	}

	// AJAX - JSON
	@RequestMapping(value = "/abbs/delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(@RequestParam int num, HttpSession session) throws Exception {

		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "bbs";

		String state = "true";
		try {
			service.deleteBoard(num, pathname);
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}

	// AJAX - Text
	@RequestMapping(value = "/abbs/update", method = RequestMethod.GET)
	public String updateForm(@RequestParam int num, Model model) throws Exception {

		Board dto = service.readBoard(num);
		if (dto == null) {
			return "abbs/error";
		}

		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");

		return "abbs/created";
	}

	// AJAX - JSON
	@RequestMapping(value = "/abbs/update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSubmit(Board dto, HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "bbs";

		String state = "true";
		try {
			service.updateBoard(dto, pathname);
		} catch (Exception e) {
			state = "false";
		}

		Map<String, Object> model = new HashMap<>();
		model.put("state", state);

		return model;
	}

	// AJAX - JSON
	@RequestMapping(value = "/abbs/deleteFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(@RequestParam int num, HttpSession session)
			throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "bbs";
		
		service.deleteFile(num, pathname);

		Map<String, Object> model = new HashMap<>();
		model.put("state", "true");

		return model;
	}

}
