package com.sp.user;

import java.net.URLEncoder;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.XMLSerializer;

@Controller("user.userController")
public class UserController {

	@Autowired
	private XMLSerializer xmlSerializer;

	@Autowired
	private UserService service;
	
	@RequestMapping(value = "/user/main")
	public String main() {
		return "user/main";
	}
	
	@RequestMapping(value="/user/json1")
	@ResponseBody
	public Map<String, Object> json1() throws Exception{
		String spec = "http://localhost:9090/sp2/xml/userXML.xml";
		
		Map<String, Object> model = service.serializeNode(spec);
		
		return model;
	}

	@RequestMapping(value = "/user/json2", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String xmlToJson2() throws Exception {
		String result = null;
		String spec = "http://127.0.0.1:9090/sp2/xml/userXML.xml";

		result = xmlSerializer.xmlToJson(spec);

		return result;
	}

	@RequestMapping(value="/user/xml", produces="application/xml;charset=utf-8")
	@ResponseBody
	public String xml() throws Exception{
		String spec = "http://localhost:9090/sp2/xml/userXML.xml";
		
		String s = xmlSerializer.xmlToString(spec);

		return s;
	}
	
	@RequestMapping(value = "/user/zip", produces = "application/json;charset=utf-8")
	@ResponseBody
	public String zipJson() throws Exception {
		// 공공 API(오픈 API) : 도로명주소조회서비스
		// serviceKey 를 받은 후 도로명주소조회서비스에서 활용신청
		// 활용신청후 약 1시간 후 확인 가능
		String keyword = "세종로 17";
		String serviceKey = "jdWevoTtmH9bIoNzU6kWxW6sxbE2PoXco5Y0XpO%2FSxOIR9iv6bwDlRqKRB9qJm%2FH0Sld6zazh9lgbrXONbIwIw%3D%3D";

		String spec = "http://openapi.epost.go.kr/postal/retrieveNewAdressAreaCdService/retrieveNewAdressAreaCdService/getNewAddressListAreaCd";
		spec += "?ServiceKey=" + serviceKey + "&searchSe=road";
		spec += "&srchwrd=" + URLEncoder.encode(keyword, "UTF-8");

		String result = xmlSerializer.xmlToJson(spec);

		return result;
	}
}
