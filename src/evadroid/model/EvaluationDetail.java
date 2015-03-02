package evadroid.model;

public class EvaluationDetail {
	int id;
	int aid;
	int score;

	

	public EvaluationDetail(int id, int aid, int score) {
		super();
		this.id = id;
		this.aid = aid;
		this.score = score;
	}

	public int getAid() {
		return aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
}