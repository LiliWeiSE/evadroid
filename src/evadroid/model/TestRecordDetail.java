package evadroid.model;

import java.util.Date;

public class TestRecordDetail {
	private int id;
	private int aid;
	private int tid;
	private int score;
	private Date time;
	public TestRecordDetail(int id, int aid, int tid, int score, Date time) {
		this.id = id;
		this.aid = aid;
		this.tid = tid;
		this.score = score;
		this.time = time;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAid() {
		return aid;
	}
	public void setAid(int aid) {
		this.aid = aid;
	}
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	
	
}