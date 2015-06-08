package evadroid.utils;

import evadroid.graph.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;

public class AnalysisUtil {
	private ArrayList<ActivityNode> ideal = null, real;

	public AnalysisUtil(ArrayList<ActivityNode> ideal,
			ArrayList<ActivityNode> real) {
		super();
		this.ideal = ideal;
		this.real = real;
	}

	public ArrayList<ActivityNode> getIdeal() {
		return ideal;
	}

	public void setIdeal(ArrayList<ActivityNode> ideal) {
		this.ideal = ideal;
	}

	public ArrayList<ActivityNode> getReal() {
		return real;
	}

	public void setReal(ArrayList<ActivityNode> real) {
		this.real = real;
	}
	
	@SuppressWarnings("unchecked")
	public ArrayList<ActivityInfo> getRedundantActivity(){
		Iterator<ActivityNode> it_real = real.iterator(), it_ideal = null;
		ArrayList<ActivityInfo> result = new ArrayList<ActivityInfo>();
		while(it_real.hasNext()) {
			ActivityNode real_node = it_real.next(), ideal_node = idealContains(real_node);
			boolean flag = (ideal_node == null);
			if(flag) {
				ActivityInfo info = new ActivityInfo(real_node.getName(),real_node.getCount());
				result.add(info);
			}
			else {
				int count = real_node.getCount() - real_node.getTotal() * ideal_node.getCount();
				ActivityInfo info = new ActivityInfo(real_node.getName(),count);
				Iterator<EventEdge> itEdge_ideal = ideal_node.getEdges().iterator(), itEdge_real = null;
				int same_count = 0;
				while(itEdge_ideal.hasNext()) {
					EventEdge edge_ideal = itEdge_ideal.next();
					itEdge_real = real_node.getEdges().iterator();
					while(itEdge_real.hasNext()) {
						EventEdge edge_real = itEdge_real.next();
						if(edgesEqual(edge_real, edge_ideal)) {
							same_count += (edge_ideal.getCount() * real_node.getTotal());
							System.out.println("same_count: " + same_count);
							break;
						}
					}
				}
				float rate = ((float)(real_node.getEdgeTotal() - same_count))/(float)real_node.getEdgeTotal();
				System.out.println("total: " + real_node.getTotal());
				System.out.println("edge_total: " + real_node.getEdgeTotal());
				System.out.println("rate: " + rate);
				info.setMistakeRate(rate);
				if(count != 0 || rate > 0)
					result.add(info);
			}
		}
		//排序
		Collections.sort(result);
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public ArrayList<EventInfo> getRedundantEvent() {
		Iterator<ActivityNode> it_real = real.iterator(), it_ideal = null;
		Iterator<EventEdge> itEdge_real = null, itEdge_ideal = null;
		ArrayList<EventInfo> result = new ArrayList<EventInfo>();
		while(it_real.hasNext()) {
			ActivityNode node = it_real.next(), node_ideal = idealContains(node);
			if(node_ideal != null) {
				//Compare the edges
				itEdge_real = node.getEdges().iterator();
				while(itEdge_real.hasNext()) {
					itEdge_ideal = node_ideal.getEdges().iterator();
					EventEdge edge_real = itEdge_real.next();
					boolean flag = true;
					while(itEdge_ideal.hasNext()) {
						if(edgesEqual(edge_real,itEdge_ideal.next())){
							flag = false;
							break;
						}
					}
					if(flag){
						EventInfo info = new EventInfo(edge_real.getType(),
													   edge_real.getName(),
													   node.getName(),
													   real.get(edge_real.getDes()).getName(),
													   edge_real.getCount());
						result.add(info);
					}
				}
			}
		}
		//排序
		Collections.sort(result);
		return result;
	}
	
	private ActivityNode idealContains(ActivityNode a) {
		Iterator<ActivityNode> it = ideal.iterator();
		while(it.hasNext()) {
			ActivityNode node = it.next();
			if(node.thesameas(a))
				return node;
		}
		return null;
	}
	
	private boolean edgesEqual(EventEdge ed_real, EventEdge ed_ideal) {
		return ed_real.getName().equals(ed_ideal.getName()) && ed_real.getType().equals(ed_ideal.getType()) && real.get(ed_real.getDes()).thesameas(ideal.get(ed_ideal.getDes()));
	}
}
