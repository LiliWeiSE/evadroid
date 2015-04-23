package evadroid.model;

import java.sql.Date;

public class AppProfile {
	private int id;
	private int uid;
	private String name;
	private String description;
	private String url;
	private String icon;
	private String task;
	private Date time;
	private int point;
	private String result;
	private String xml;
	
	public AppProfile() {
		this.id = -1;
		this.uid = -1;
		this.name = null;
		this.description = null;
		this.url = null;
		this.icon = null;
		this.task = null;
		this.time = null;
		this.point = 0;
		this.result = null;
		this.xml = null;
	}

	public AppProfile(int id, int uid, String name, String description, String url,
			String icon, String task, Date time, int point) {
		this.id = id;
		this.uid = uid;
		this.name = name;
		this.description = description;
		this.url = url;
		this.icon = icon;
		this.task = task;
		this.time = time;
		this.point = point;
		this.result = null;
	}
	
	

	public AppProfile(int id, int uid, String name, String description,
			String url, String icon, String task, Date time, int point,
			String result, String xml) {
		super();
		this.id = id;
		this.uid = uid;
		this.name = name;
		this.description = description;
		this.url = url;
		this.icon = icon;
		this.task = task;
		this.time = time;
		this.point = point;
		this.result = result;
		this.xml = xml;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTask() {
		return task;
	}

	public void setTask(String task) {
		this.task = task;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getXml() {
		return xml;
	}

	public void setXml(String xml) {
		this.xml = xml;
	}
}