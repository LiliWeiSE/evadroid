package evadroid.model;

import java.sql.ResultSet;

public class Evaluation {
	EvaluationDetail evaluationDetail;

	public Evaluation(EvaluationDetail evaluationDetail) {
		this.evaluationDetail = evaluationDetail;
	}

	public EvaluationDetail getEvaluationDetail() {
		return evaluationDetail;
	}

	public void setEvaluationDetail(EvaluationDetail evaluationDetail) {
		this.evaluationDetail = evaluationDetail;
	}

	public static Evaluation getEvaluationByAid(int aid) throws Exception {
		DBQ dbq = new DBQ(
				"SELECT * FROM evaluation WHERE aid=?");
		dbq.set(aid);
		
		Evaluation eva = null;
		ResultSet rs = dbq.query();
		if(rs.next())
			eva = new Evaluation(
					new EvaluationDetail(
							rs.getInt("id"),
							rs.getInt("aid"),
							rs.getInt("score")));
		return eva;
	}
	
	public boolean update() throws Exception {
		DBQ dbq = new DBQ(
				"UPDATE evaluation SET aid=?, score=? WHERE id=?");
		dbq.set(evaluationDetail.getAid());
		dbq.set(evaluationDetail.getScore());
		dbq.set(evaluationDetail.getId());
		if (dbq.excute() != 1) {
			dbq.close();
			return false;
		}
		dbq.close();
		return true;
	}
}