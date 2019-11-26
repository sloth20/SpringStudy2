package com.sp.score;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;

import oracle.net.aso.o;

@Controller("score.scoreController")
public class ScoreController {
	@Autowired
	private ScoreService service;
	@Autowired
	public MyUtil util;

	@RequestMapping("/score/list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "hak") String condition, @RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req, Model model) throws Exception {

		String cp = req.getContextPath();

		int rows = 10;
		int total_page;
		int dataCount;

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		dataCount = service.dataCount(map);
		total_page = util.pageCount(rows, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);

		List<Score> list = service.listScore(map);

		String query = "";
		String listUrl = cp + "/score/list";
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");

			listUrl += "?" + query;
		}

		String paging = util.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		return "score/list";
	}

	@RequestMapping(value = "/score/insert", method = RequestMethod.GET)
	public String insertForm(Model model) {
		model.addAttribute("mode", "insert");

		return "score/write";
	}

	@RequestMapping(value = "/score/insert", method = RequestMethod.POST)
	public String insertSumbit(Score dto, Model model) {

		try {
			service.insertScore(dto);
		} catch (Exception e) {
			model.addAttribute("mode", "insert");
			model.addAttribute("msg", "학번 중복, 생년월일 형식 오류 등으로 추가 실패");
			return "score/write";
		}

		return "redirect:/score/list";
	}

	@RequestMapping(value = "/score/delete")
	public String delete(@RequestParam String hak, @RequestParam String page) {
		try {
			service.deleteScore(hak);
		} catch (Exception e) {

		}
		return "redirect:/score/list?page=" + page;
	}

	@RequestMapping(value = "/score/update", method = RequestMethod.GET)
	public String updateForm(@RequestParam String hak, @RequestParam String page, Model model) {
		Score dto = service.readScore(hak);
		if (dto == null) {
			return "redirect:/score/list?page=" + page;
		}

		model.addAttribute("mode", "update");
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);

		return "score/write";
	}

	@RequestMapping(value = "/score/update", method = RequestMethod.POST)
	public String updateSumbit(@RequestParam String page, Score dto, HttpServletResponse resp) throws Exception {

		try {
			service.updateScore(dto);
		} catch (Exception e) {
			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>alert('학번 중복으로 수정이 불가능합니다.');history.back();</script>");
			return null;
		}

		return "redirect:/score/list?page=" + page;
	}

	@RequestMapping(value = "/score/deleteList", method=RequestMethod.POST)
	public String deleteList(@RequestParam List<String> haks, @RequestParam String page) {
		try {
			service.deleteScoreList(haks);
		} catch (Exception e) {

		}
		return "redirect:/score/list?page=" + page;
	}


}
