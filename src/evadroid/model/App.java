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
							rs.getString("description"),
							rs.getString("url"),
							rs.getString("icon"),
							rs.getString("task"),
							rs.getDate("time"),
							rs.getInt("point"))
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
							rs.getString("description"),
							rs.getString("url"),
							rs.getString("icon"),
							rs.getString("task"),
							rs.getDate("time"),
							rs.getInt("point"))
					);
			allApp.add(app);
		}
		return allApp;
	}
	
	public static ArrayList<App> getCertainApps(int number) throws Exception {
		return (ArrayList<App>) getAllApps().subList(0, number);
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
							rs.getString("description"),
							rs.getString("url"),
							rs.getString("icon"),
							rs.getString("task"),
							rs.getDate("time"),
							rs.getInt("point"))
					);
			userApp.add(app);
		}
		return userApp;
	}
	
	public boolean update() throws Exception {
		DBQ dbq = new DBQ(
				"UPDATE app SET uid=?, description=?, url=?, icon=?, task=?, time=?, point=? WHERE id=?");
		dbq.set(appProfile.getUid());
		dbq.set(appProfile.getDescription());
		dbq.set(appProfile.getUrl());
		dbq.set(appProfile.getIcon());
		dbq.set(appProfile.getTask());
		dbq.set(appProfile.getId());
		dbq.set(appProfile.getTime());
		dbq.set(appProfile.getPoint());
		if (dbq.excute() != 1) {
			dbq.close();
			return false;
		}
		dbq.close();
		return true;
	}
}