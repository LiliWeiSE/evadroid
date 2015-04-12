package evadroid.graph;

import java.io.Serializable;

public class EventEdge implements Serializable{
	String type;
	String name;
	int count;
	int des;
	public EventEdge(String type, String name) {
		this.type = type;
		this.name = name;
		count = 1;
		des = -1;
	}
	public EventEdge(String type, String name, int count, int des) {
		super();
		this.type = type;
		this.name = name;
		this.count = count;
		this.des = des;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getDes() {
		return des;
	}
	public void setDes(int des) {
		this.des = des;
	}
	
	public boolean thesameas(EventEdge ed) {
		return type == ed.getType() && name == ed.getName() && des == ed.getDes();
	}
	
	public void increase() {
		count++;
	}
}
