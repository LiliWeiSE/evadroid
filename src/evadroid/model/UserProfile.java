package evadroid.model;

public class UserProfile {
	private int id;
	private int type;
	private String email;
	private String name;
	private String password;
	private int credit;

	public UserProfile(int id, int type, String email, String name,
			String password, int credit) {
		super();
		this.id = id;
		this.type = type;
		this.email = email;
		this.name = name;
		this.password = password;
		this.credit = credit;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getCredit() {
		return credit;
	}

	public void setCredit(int credit) {
		this.credit = credit;
	}

}