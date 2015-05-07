package evadroid.graph;

public class EventInfo implements Comparable{
	String type;
	String name;
	String src;
	String des;
	int count;
	
	public EventInfo(String type, String name, String src, String des, int count) {
		super();
		this.type = type;
		this.name = name;
		this.src = src;
		this.des = des;
		this.count = count;
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
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		EventInfo info = (EventInfo)o;
		if(count > info.count)
			return -1;
		else if(count == info.count)
			return 0;
		else
			return 1;
	}
}
