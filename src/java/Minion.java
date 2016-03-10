public class Minion {
	private String name;
	private String team;
	private String type;
	private int health;
	private int xpos;
	private int ypos;

	public Minion(String n, String te, String t, int h, int x, int y){
		name = n;
		team = te;
		type = t;
		health = h;
		xpos = x;
		ypos = y;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String n) {
		name = n;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String n) {
		team = n;
	}

	public String getType() {
		return type;
	}

	public void setType(String n) {
		type = n;
	}

	public int getHealth() {
		return health;
	}

	public void setHealth(int n) {
		health = n;
	}

	public int getX() {
		return xpos;
	}

	public void setX(int xpos) {
		this.xpos = xpos;
	}

	public int getY() {
		return ypos;
	}

	public void setY(int ypos) {
		this.ypos = ypos;
	}

}
