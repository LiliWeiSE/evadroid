package evadroid.model;

import java.sql.ResultSet;
import java.util.ArrayList;

public class TestRecord {
	private TestRecordDetail testRecordDetail;

	public TestRecord(TestRecordDetail testRecordDetail) {
		this.testRecordDetail = testRecordDetail;
	}

	public TestRecordDetail getTestRecordDetail() {
		return testRecordDetail;
	}

	public void setTestRecordDetail(TestRecordDetail testRecordDetail) {
		this.testRecordDetail = testRecordDetail;
	}
	
	public static ArrayList<TestRecord> getByAid(int aid) throws Exception{
		DBQ dbq = new DBQ(
				"SELECT * FROM evaluation WHERE aid=?");
		dbq.set(aid);
		
		ResultSet rs = dbq.query();
		ArrayList<TestRecord> appRecord = new ArrayList<TestRecord>();
		
		while(rs.next()) {
			TestRecord record = new TestRecord(
									new TestRecordDetail(
											rs.getInt("id"),
											rs.getInt("aid"),
											rs.getInt("tid"),
											rs.getInt("score"),
											rs.getDate("time")));
			appRecord.add(record);
		}
		return appRecord;
	}
	
	public static ArrayList<TestRecord> getByTid(int tid) throws Exception{
		DBQ dbq = new DBQ(
				"SELECT * FROM evaluation WHERE tid=?");
		dbq.set(tid);
		
		ResultSet rs = dbq.query();
		ArrayList<TestRecord> userRecord = new ArrayList<TestRecord>();
		
		while(rs.next()) {
			TestRecord record = new TestRecord(
									new TestRecordDetail(
											rs.getInt("id"),
											rs.getInt("aid"),
											rs.getInt("tid"),
											rs.getInt("score"),
											rs.getDate("time")));
			userRecord.add(record);
		}
		return userRecord;
	}
	
	public boolean update() throws Exception {
		DBQ dbq = new DBQ(
				"UPDATE evaluation SET aid=?, tid=?, score=?, time = ? WHERE id=?");
		dbq.set(testRecordDetail.getAid());
		dbq.set(testRecordDetail.getTid());
		dbq.set(testRecordDetail.getScore());
		dbq.set(testRecordDetail.getTime());
		dbq.set(testRecordDetail.getId());
		if (dbq.excute() != 1) {
			dbq.close();
			return false;
		}
		dbq.close();
		return true;
	}
}