package evadroid.graph;

public class NodePair {
	int source;
	int des;
	public NodePair(int source, int des) {
		super();
		this.source = source;
		this.des = des;
	}
	public NodePair getReverse() {
		return new NodePair(des, source);
	}
	@Override
	public boolean equals(Object o) {
		NodePair p = (NodePair)o;
		return p.des == this.des && p.source == this.source;
	}
}
