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
	public static TestRecord insert(int tid, int aid) throws Exception{
		int id = 0;
		DBQ dbq = new DBQ(
				"INSERT INTO testrecord (tid, aid, score) VALUES( ?, ?, ?)");
		dbq.set(tid);
		dbq.set(aid);
		dbq.set(-1);
		
		try {
			if(dbq.excute() != 1)
			{
				dbq.close();
				return null;
			}
		} catch (Exception e) {
			dbq.close();
			//return null;
			throw(e);
		}
		id = dbq.getGK().get(0);
		dbq.close();
		
		return new TestRecord(new TestRecordDetail(id, aid, tid, -1, null));
	}
	public static int getAverage(int aid) throws Exception{
		DBQ dbq = new DBQ(
				"SELECT AVG(score) FROM testrecord WHERE aid=?");
		dbq.set(aid);
		
		ResultSet rs = dbq.query();
		if(rs.next()) {
			return rs.getInt(1);
		}
		return -1;
	}
	public static int getCount(int aid) throws Exception{
		DBQ dbq = new DBQ(
				"SELECT COUNT(score) FROM testrecord WHERE aid=?");
		dbq.set(aid);
		
		ResultSet rs = dbq.query();
		if(rs.next()) {
			return rs.getInt(1);
		}
		return -1;
	}
	public static ArrayList<TestRecord> getByAid(int aid) throws Exception{
		DBQ dbq = new DBQ(
				"SELECT * FROM testrecord WHERE aid=?");
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
	public static TestRecord getByTidAndAid(int tid, int aid) throws Exception{
		DBQ dbq = new DBQ(
				"SELECT * FROM testrecord WHERE tid=? AND aid=?");
		dbq.set(tid);
		dbq.set(aid);
		
		TestRecord tr = null;
		ResultSet rs = dbq.query();
		if(rs.next()) {
			tr = new TestRecord(
					new TestRecordDetail(
							rs.getInt("id"),
							rs.getInt("aid"),
							rs.getInt("tid"),
							rs.getInt("score"),
							rs.getDate("time")
							)
					);
		}
		return tr;
	}
	public static TestRecord getById(int id) throws Exception {
		DBQ dbq = new DBQ(
				"SELECT * FROM testrecord WHERE id=?");
		dbq.set(id);
		
		TestRecord tr = null;
		ResultSet rs = dbq.query();
		if(rs.next()) {
			tr = new TestRecord(
					new TestRecordDetail(
							rs.getInt("id"),
							rs.getInt("aid"),
							rs.getInt("tid"),
							rs.getInt("score"),
							rs.getDate("time")
							)
					);
		}
		return tr;
	}
	public static ArrayList<TestRecord> getByTid(int tid) throws Exception{
		DBQ dbq = new DBQ(
				"SELECT * FROM testrecord WHERE tid=?");
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
				"UPDATE testrecord SET aid=?, tid=?, score=? WHERE id=?");
		dbq.set(testRecordDetail.getAid());
		dbq.set(testRecordDetail.getTid());
		dbq.set(testRecordDetail.getScore());
		dbq.set(testRecordDetail.getId());
		if (dbq.excute() != 1) {
			dbq.close();
			return false;
		}
		dbq.close();
		return true;
	}
}