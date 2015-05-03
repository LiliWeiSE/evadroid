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
			ActivityNode real_node = it_real.next();
			boolean flag = false;
			it_ideal = ideal.iterator();
			while(it_ideal.hasNext()) {
				if(it_ideal.next().thesameas(real_node)){
					flag = true;
					break;
				}
			}
			if(!flag) {
				ActivityInfo info = new ActivityInfo(real_node.getName(),real_node.getCount());
				result.add(info);
			}
		}
		//排序
		Collections.sort(result);
		return result;
	}
}
