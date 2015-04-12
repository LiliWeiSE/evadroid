package evadroid.graph;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;

public class ActivityNode implements Serializable{
	String name;
	int count;
	ArrayList<EventEdge> edges;
	public ActivityNode (String name) {
		this.name = name;
		count = 0;
		edges = new ArrayList<EventEdge>();
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


	public ArrayList<EventEdge> getEdges() {
		return edges;
	}


	public void setEdges(ArrayList<EventEdge> edges) {
		this.edges = edges;
	}


	public void increase(){
		count++;
	}
	public void addEdge(EventEdge edge) {
		Iterator<EventEdge> it =  edges.iterator();
		while(it.hasNext()){
			EventEdge ed = it.next();
			if(ed.thesameas(edge)){
				ed.increase();
				return;
			}
		}
		edges.add(edge);
	}
	
	public boolean thesameas(ActivityNode ac) {
		return name == ac.getName();
	}
	
}
