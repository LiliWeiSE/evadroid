package evadroid.controller;

import java.io.File;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

public class MyXMLParser {
	private String url;
	Document doc;
	
	public MyXMLParser(String url) throws DocumentException {
		super();
		this.url = url;
		
		SAXReader reader = new SAXReader();
		doc = reader.read(new File(url));	
	}
	public int getAid() {
		return getId("aid");
	}
	public int getTid() {
		return getId("tid");
	}
	
	private int getId(String type) {
		Element root = doc.getRootElement();
		
		Element node = root.element(type);
		String str = node.getText();
		int id = Integer.parseInt(str);
		return id;
	}
}
