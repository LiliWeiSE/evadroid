package evadroid.graph;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;

public class ActivityNode implements Serializable{
	String name;
	int total;
	int count;
	ArrayList<EventEdge> edges;
	public ActivityNode (String name, int total) {
		this.name = name;
		this.total = total;
		count = 1;
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


	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
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
	
	public int getEdgeTotal() {
		Iterator<EventEdge> it =  edges.iterator();
		int eTotal = 0;
		while(it.hasNext()) {
			eTotal += it.next().getCount();
		}
		return eTotal;
	}
	
	public boolean thesameas(ActivityNode ac) {
		return name.equals(ac.getName());
	}
	
}
