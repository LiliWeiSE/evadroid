package evadroid.model;

import java.sql.ResultSet;
import java.util.ArrayList;

public class App {
	private AppProfile appProfile;

	public App(AppProfile appProfile) {
		this.appProfile = appProfile;
	}

	public AppProfile getAppProfile() {
		return appProfile;
	}

	public void setAppProfile(AppProfile appProfile) {
		this.appProfile = appProfile;
	}
	public static App insertApp(AppProfile ap) throws Exception{
		int id = 0;
		DBQ dbq = new DBQ(
				"INSERT INTO app (uid, name, description, url, icon, task, point) VALUES( ?, ?, ?, ?, ?, ?, ?)");
		dbq.set(ap.getUid());
		dbq.set(ap.getName());
		dbq.set(ap.getDescription());
		dbq.set(ap.getUrl());
		dbq.set(ap.getIcon());
		dbq.set(ap.getTask());
		//dbq.set(ap.getTime());
		dbq.set(ap.getPoint());
		
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
		ap.setId(id);
		return new App(ap);
	}
	public static App getAppById(int id) throws Exception {
		DBQ dbq = new DBQ("SELECT * FROM app WHERE id=?");
		dbq.set(id);
		App app = null;
		
		ResultSet rs = dbq.query();
		if(rs.next()) {
			app = new App(
					new AppProfile(
							rs.getInt("id"), 
							rs.getInt("uid"),
							rs.getString("name"),
							rs.getString("description"),
							rs.getString("url"),
							rs.getString("icon"),
							rs.getString("task"),
							rs.getDate("time"),
							rs.getInt("point"),
							rs.getString("result"))
					);
		}
		return app;
	}
	
	public static ArrayList<App> getAllApps() throws Exception {
		ArrayList<App> allApp = new ArrayList<App>();
		DBQ dbq = new DBQ("SELECT * FROM app");
		ResultSet rs = dbq.query();
		
		while(rs.next()) {
			App app = new App(
						new AppProfile(
							rs.getInt("id"), 
							rs.getInt("uid"),
							rs.getString("name"),
							rs.getString("description"),
							rs.getString("url"),
							rs.getString("icon"),
							rs.getString("task"),
							rs.getDate("time"),
							rs.getInt("point"),
							rs.getString("result"))
					);
			allApp.add(app);
		}
		return allApp;
	}
	
	public static ArrayList<App> getCertainApps(int number) throws Exception {
		ArrayList<App> cApp = new ArrayList<App>();
		DBQ dbq = new DBQ("SELECT * FROM app ORDER BY time DESC");
		ResultSet rs = dbq.query();
		int i = 0;
		while(rs.next() && i <number) {
			App app = new App(
						new AppProfile(
							rs.getInt("id"), 
							rs.getInt("uid"),
							rs.getString("name"),
							rs.getString("description"),
							rs.getString("url"),
							rs.getString("icon"),
							rs.getString("task"),
							rs.getDate("time"),
							rs.getInt("point"),
							rs.getString("result"))
					);
			cApp.add(app);
			i++;
		}
		return cApp;
	}
	
	public static ArrayList<App> getAppsByUid(int uid) throws Exception {
		ArrayList<App> userApp = new ArrayList<App>();
		DBQ dbq = new DBQ("SELECT * FROM app WHERE uid = ?");
		dbq.set(uid);
		
		ResultSet rs = dbq.query();
		while(rs.next()) {
			App app = new App(
						new AppProfile(
							rs.getInt("id"), 
							rs.getInt("uid"),
							rs.getString("name"),
							rs.getString("description"),
							rs.getString("url"),
							rs.getString("icon"),
							rs.getString("task"),
							rs.getDate("time"),
							rs.getInt("point"),
							rs.getString("result"))
					);
			userApp.add(app);
		}
		return userApp;
	}
	
	public static boolean addResult(int id, String result) throws Exception {
		DBQ dbq = new DBQ(
				"UPDATE app SET result=? WHERE id=?");
		dbq.set(result);
		dbq.set(id);
		if (dbq.excute() != 1) {
			dbq.close();
			return false;
		}
		dbq.close();
		return true;
	}
	
	public boolean update() throws Exception {
		DBQ dbq = new DBQ(
				"UPDATE app SET uid=?, description=?, url=?, icon=?, task=?, point=?, result=? WHERE id=?");
		dbq.set(appProfile.getUid());
		dbq.set(appProfile.getDescription());
		dbq.set(appProfile.getUrl());
		dbq.set(appProfile.getIcon());
		dbq.set(appProfile.getTask());
		dbq.set(appProfile.getId());
		//dbq.set(appProfile.getTime());
		dbq.set(appProfile.getPoint());
		dbq.set(appProfile.getResult());
		if (dbq.excute() != 1) {
			dbq.close();
			return false;
		}
		dbq.close();
		return true;
	}
}