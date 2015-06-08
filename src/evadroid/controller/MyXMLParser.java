package evadroid.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import evadroid.graph.*;
import evadroid.utils.*;
import evadroid.model.*;

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
	
	@SuppressWarnings("unchecked")
	public void readAndSave(String filePath) throws Exception {
		Element root = doc.getRootElement();
		
		Iterator it = root.elementIterator();
		ActivityNode activity = null, preActivity = null;
		EventEdge edge = null;
		
		int aid = getAid(), total = 1;
		String fileUrl = filePath + aid + "result.dat";
		ArrayList<ActivityNode> activityList = (ArrayList<ActivityNode>)ObjectIOUtil.read(fileUrl);
		if(activityList == null) {
			activityList = new ArrayList<ActivityNode>();
		}
		else{
			total = activityList.get(0).getTotal() + 1;
			Iterator<ActivityNode> temp = activityList.iterator();
			while(temp.hasNext()) {
				ActivityNode node = temp.next();
				node.setTotal(total);
			}
		}
		System.out.println(total);
		String preName = null;
		int i = 0;
		while (it.hasNext()) {
			Element element = (Element)it.next();
			String name = element.getName();
			if(name == "Activity"){
				//add activity
				String activityName = element.getText();
				preActivity = activity;
				activity = new ActivityNode(activityName, total);
				if(activityList.isEmpty()){
					activityList.add(activity);
				}
				else{
					//遍历找到Activity
					int size = activityList.size();
					
					for(i = 0; i < size;i++){
						if(activityList.get(i).thesameas(activity))
							break;
					}
					if(i == size)
						activityList.add(activity);
					else
					{
						activity = activityList.get(i);
						activity.increase();
					}
					if(edge != null) {
						edge.setDes(i);
						preActivity.addEdge(edge);
					}
				}
			}
			else if(name == "Event" && preName == "Event"){
				edge.setDes(i);
				activity.addEdge(edge);
				
				String EventType = element.element("type").getText();
				String EventName = element.element("name").getText();
				
				edge = new EventEdge(EventType, EventName);
			}
			else if(name == "Event") {
				//add event
				String EventType = element.element("type").getText();
				String EventName = element.element("name").getText();
				
				edge = new EventEdge(EventType, EventName);
			}
			preName = name;
		}
		
		//write
		ObjectIOUtil.write(fileUrl, activityList);
		//save to DB
		App.addResult(aid, fileUrl);
	}
	
	public ArrayList<ActivityNode> readSingleFile() {
		ArrayList<ActivityNode> activityList = new ArrayList<ActivityNode>();
		Element root = doc.getRootElement();
		
		Iterator it = root.elementIterator();
		ActivityNode activity = null, preActivity = null;
		EventEdge edge = null;
		int i = 0;
		String preName = null;
		while (it.hasNext()) {
			Element element = (Element)it.next();
			String name = element.getName();
			if(name == "Activity"){
				//add activity
				String activityName = element.getText();
				preActivity = activity;
				activity = new ActivityNode(activityName, 1);
				if(activityList.isEmpty()){
					activityList.add(activity);
				}
				else{
					//遍历找到Activity
					int size = activityList.size();
					for(i = 0; i < size;i++){
						if(activityList.get(i).thesameas(activity))
							break;
					}
					if(i == size)
						activityList.add(activity);
					else
					{
						activity = activityList.get(i);
						activity.increase();
					}
					if(edge != null) {
						edge.setDes(i);
						preActivity.addEdge(edge);
					}
				}
			}
			else if(name == "Event" && preName == "Event"){
				edge.setDes(i);
				activity.addEdge(edge);
				
				String EventType = element.element("type").getText();
				String EventName = element.element("name").getText();
				
				edge = new EventEdge(EventType, EventName);
			}
			else if(name == "Event") {
				//add event
				String EventType = element.element("type").getText();
				String EventName = element.element("name").getText();
				
				edge = new EventEdge(EventType, EventName);
			}
			preName = name;
		}
		return activityList;
	}
}
