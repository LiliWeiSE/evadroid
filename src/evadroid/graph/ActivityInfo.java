package evadroid.graph;

public class ActivityInfo implements Comparable{
	private String name = null;
	private int count = 0;
	public ActivityInfo(String name, int count) {
		super();
		this.name = name;
		this.count = count;
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
	@Override
	public int compareTo(Object o) {
		// TODO Auto-generated method stub
		ActivityInfo info = (ActivityInfo)o;
		if(count > info.count)
			return -1;
		else if(count == info.count)
			return 0;
		else
			return 1;
	}
}
