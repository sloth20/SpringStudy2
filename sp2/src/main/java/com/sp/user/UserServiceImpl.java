package com.sp.user;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

/*
 DOM(Document Object Model) : 문서 객체 모델(DOM)은 HTML 및 XML 문서를 처리하는 API이며, 문서의 구조적 형태를 제공하므로 자바스크립트(JavaScript)와 같은 스크립트 언어를 사용하여 문서 내용과 시각적 표현을 수정할 수 있다.
 Element : XML 문서의 원소를 표현하기 위해 사용
 Node : XML 문서에서 노드 트리의 각 요소를 읽고 쓰기 위해 사용되는데  DOM에서 가장 기본적인 자료형에서 쓰인다.
 NodeList 인터페이스 : 노드들의 집합이 구현되는 방법을 정의하거나 순서가 있는 노드들의 집합을 표현
*/

@Service("user.userService")
public class UserServiceImpl implements UserService {
	@Override
	public Map<String, Object> serializeNode(String spec) {
		// XML 문서를 파싱하여 Map에 저장

		Map<String, Object> map = new HashMap<>();

		InputStream is = null;
		try {
			List<User> list = new ArrayList<User>();

			is = new URL(spec).openConnection().getInputStream();
			
			// InputSource : XML 엔티티의 단일 입력 소스
			InputSource source = new InputSource(new InputStreamReader(is, "UTF-8"));

			// DOM Document를 생성하기 위한 팩토리 생성
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

			// 팩토리에서 Document의 파서를 얻어내기
			DocumentBuilder parser = factory.newDocumentBuilder();

			// Document DOM 파서로 입력받을 파일을 파싱하도록 요청
			Document xmlDoc = parser.parse(source);

			// Element : XML 문서의 요소를 표현
			Element root = xmlDoc.getDocumentElement();

			Node nodeCount = root.getElementsByTagName("dataCount").item(0);
			String dataCount = nodeCount.getFirstChild().getNodeValue();

			NodeList items = root.getElementsByTagName("record");
			for (int i = 0; i < items.getLength(); i++) {
				Node item = items.item(i);
				NodeList itemList = item.getChildNodes();

				// 속성
				NamedNodeMap itemMap = item.getAttributes();
				String num = itemMap.getNamedItem("num").getNodeValue();
				User user = new User();
				user.setNum(Integer.parseInt(num));
				for (int j = 0; j < itemList.getLength(); j++) {
					Node e = itemList.item(j);
					if (e.getNodeType() == Node.ELEMENT_NODE) {
						String name = e.getNodeName();
						String value = e.getChildNodes().item(0).getNodeValue();

						if (name.equals("name"))
							user.setName(value);
						else if (name.equals("content"))
							user.setContent(value);
						else if (name.equals("created"))
							user.setCreated(value);
					}
				}

				list.add(user);
			}

			map.put("dataCount", dataCount);
			map.put("list", list);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return map;
	}

	@Override
	public String documentWriter(String spec) {
		// Document(XML)를 String으로 변환

		StringWriter writer = new StringWriter();
		InputStream is = null;
		try {
			is = new URL(spec).openConnection().getInputStream();
			is = IOUtils.toInputStream(IOUtils.toString(is, "UTF-8"), "UTF-8");

			// DOM Document를 생성하기 위하여 팩토리를 생성한다
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

			// 팩토리로부터 Document 파서를 얻어내도록 한다.
			DocumentBuilder parser = factory.newDocumentBuilder();

			// Document DOM 파서로 하여금 입력받은 파일을 파싱하도록 요청한다.
			Document xmlDoc = parser.parse(is);

			// Document를 String으로 변환
			DOMSource domSource = new DOMSource(xmlDoc);
			StreamResult result = new StreamResult(writer);
			TransformerFactory tf = TransformerFactory.newInstance();
			Transformer transformer = tf.newTransformer();
			transformer.transform(domSource, result);

		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (Exception e2) {
				}
			}
		}

		return writer.toString();
	}
}
