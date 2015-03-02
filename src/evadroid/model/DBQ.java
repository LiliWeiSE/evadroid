package evadroid.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

public class DBQ {
	private Connection conn;
	private PreparedStatement pstmt;
	private int index = 1;

	private static String server = null;
	private static String database;
	private static String username;
	private static String password;
	
	public DBQ(String sql) throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		if(server==null) {
			getConfig();
		}
		conn = DriverManager.getConnection(  
                "jdbc:mysql://" + server + ":3306/" + database + "?useUnicode=true&characterEncoding=utf-8",
                username, password );
		pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	}
	
	public void set(String str) throws Exception {
		pstmt.setString(index++, str);
	}
	
	public void set(int x) throws Exception {
		pstmt.setInt(index++, x);
	}
	
	public void set(Date x) throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.setTime(x);
		pstmt.setDate(index++, new java.sql.Date(cal.getTimeInMillis()));
	}
	
	/*
	public void set(Object x) throws Exception {
		pstmt.setObject(index++, x);
	}
	*/
	
	public ResultSet query() throws Exception {
		ResultSet rs = pstmt.executeQuery();
		//conn.close();
		return rs;
	}
	
	public ArrayList<Integer> getGK() {
		ArrayList<Integer> list = new ArrayList<Integer>();
		try {
			ResultSet gk = pstmt.getGeneratedKeys();
			while(gk.next()) {
				list.add(gk.getInt(1));
			}
		} catch(Exception e) {
			
		}
		return list;
	}
	
	public int excute() throws Exception {
		int count =  pstmt.executeUpdate();
		//conn.close();
		return count;
	}
	
	public void close() throws Exception {
		if(!pstmt.isClosed()) {
			pstmt.close();
		}
		
		if(!conn.isClosed()){
			conn.close();
		}
	}
	
	private void getConfig() throws Exception {
		Properties prop = new Properties();
		prop.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("database.properties"));
		server = prop.getProperty("server");
		database = prop.getProperty("database");
		username = prop.getProperty("username");
		password = prop.getProperty("password");
	}
}