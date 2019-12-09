package com.sp.ts1;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("ts1.demoController")
public class DemoController {
	@Autowired
	private DemoService demoService;

	@RequestMapping(value="/ts1/write", method=RequestMethod.GET)
	public String created() throws Exception{
		return "ts1/write";
	}

	@RequestMapping(value="/ts1/write", method=RequestMethod.POST)
	public String created(Demo dto, Model model) throws Exception{
		String msg = "추가 성공...";
		try {
			demoService.insertDemo(dto);
		} catch (Exception e) {
			msg = "추가 실패...";
		}
		
		model.addAttribute("message", msg);
		
		return "ts1/result";
	}
}
