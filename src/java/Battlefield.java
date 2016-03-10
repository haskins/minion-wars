/**
 * The environment for Jason Battlefield Simulator.
 * 
 * @author Josh Haskins
 */

import java.util.ArrayList;
import java.util.Random;

import jason.asSyntax.Literal;
import jason.asSyntax.Structure;
import jason.environment.Environment;

public class Battlefield extends Environment {

	public static final int GSize = 20; // grid size

	Random rand = new Random();

	final static String T1 = "blue", T2 = "red", T3 = "green", T4 = "yellow";

	static ArrayList<String> percepts = new ArrayList<String>();
	static ArrayList<Minion> minions = new ArrayList<Minion>();

	@SuppressWarnings("unused")
	private final String BASE = "b", ATTACK = "a", DEF = "d", HEAL = "h";

	/**
	 * Returns list of minions
	 * 
	 * @return list of minions
	 */
	public static ArrayList<Minion> getMinions() {
		return minions;
	}

	/**
	 * Generates a random x or y value for postion on battlefield.
	 * 
	 * @return random integer between 0 and 19
	 */
	public int genSpot() {
		return rand.nextInt(19);
	}

	/**
	 * Removes char from string at pos
	 * 
	 * @param s
	 *            string required
	 * @param pos
	 *            the position of the char from string to be removed
	 * @return new string with char removed
	 */
	public static String removeCharAt(String s, int pos) {
		return s.substring(0, pos) + s.substring(pos + 1);
	}

	/**
	 * Initializes the agents and starts the GUI
	 */
	@Override
	public void init(String[] args) {

		// creates 4 bases
		 minions.add(new Minion("b1", T1, BASE, 100, 0, 0));
		 minions.add(new Minion("b2", T2, BASE, 100, 0, GSize - 1));
		 minions.add(new Minion("b3", T3, BASE, 10, GSize - 1, 0));
		 minions.add(new Minion("b4", T4, BASE, 10, GSize - 1, GSize - 1));

		// creates 4 attackers
		minions.add(new Minion("a1", T1, ATTACK, 100, genSpot(), genSpot()));
		minions.add(new Minion("a2", T2, ATTACK, 100, genSpot(), genSpot()));
		minions.add(new Minion("a3", T3, ATTACK, 100, genSpot(), genSpot()));
		minions.add(new Minion("a4", T4, ATTACK, 100, genSpot(), genSpot()));

		// creates 4 healers
		 minions.add(new Minion("h1", T1, HEAL, 100, genSpot(), genSpot()));
		 minions.add(new Minion("h2", T2, HEAL, 100, genSpot(), genSpot()));
		 minions.add(new Minion("h3", T3, HEAL, 100, genSpot(), genSpot()));
		 minions.add(new Minion("h4", T4, HEAL, 100, genSpot(), genSpot()));

		// // creates additional attackers
//		 minions.add(new Minion("a5", T1, ATTACK, 100, genSpot(), genSpot()));
//		 minions.add(new Minion("a6", T2, ATTACK, 100, genSpot(), genSpot()));
//		 minions.add(new Minion("a7", T3, ATTACK, 100, genSpot(), genSpot()));
//		 minions.add(new Minion("a8", T4, ATTACK, 100, genSpot(), genSpot()));

		updatePercepts();

		// start GUI
		DrawWindows.main();

	}

	/**
	 * Executes actions from agents
	 * 
	 * @param ag
	 *            calling agent name
	 * @param action
	 *            requested action to be achieved
	 */
	@Override
	public boolean executeAction(String ag, Structure action) {
		try {
			if (action.getFunctor().equals("move_north")) {
				for (Minion s : minions) {
					if (s.getName().equals(ag))
						s.setY(s.getY() - 1);
				}
			} else if (action.getFunctor().equals("move_east")) {
				for (Minion s : minions) {
					if (s.getName().equals(ag))
						s.setX(s.getX() + 1);
				}
			} else if (action.getFunctor().equals("move_south")) {
				for (Minion s : minions) {
					if (s.getName().equals(ag))
						s.setY(s.getY() + 1);
				}
			} else if (action.getFunctor().equals("move_west")) {
				for (Minion s : minions) {
					if (s.getName().equals(ag))
						s.setX(s.getX() - 1);
				}
			} else if (action.getFunctor().equals("tell")) {
				tell(String.valueOf(action.getTerms()));
			} else if (action.getFunctor().equals("revoke")) {
				String str = String.valueOf(action.getTerms());
				str = removeCharAt(str, 0);
				str = removeCharAt(str, str.length() - 1);
				System.out.println("I JUST RECEIVED THIS " + str);
				percepts.remove(str);
			} else if (action.getFunctor().equals("heal_agent")) {
				for (Minion s : minions) {
					if (s.getName().equals(String.valueOf(action.getTerm(0))))
						s.setHealth(s.getHealth() + 5);
				}
			} else if (action.getFunctor().equals("kill_agent")) {
				System.out.println(ag + " attacked "
						+ String.valueOf(action.getTerm(0)));
				for (Minion s : minions) {
					if (s.getName().equals(String.valueOf(action.getTerm(0))))
						s.setHealth(s.getHealth() - 10);
				}
			} else if (action.getFunctor().equals("remove")) {
				System.out.println("killing " + ag);
			} else {
				System.out
						.println("A action was requested that does not exist");
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		updatePercepts();

		// refresh GUI
		DrawWindows.grid.conv();

		/**
		 * Delays so that system can correctly update and that the simulation
		 * takes some time to run. The larger the number, the longer the
		 * simulation will take.
		 */
		try {
			Thread.sleep(150);
		} catch (Exception e) {
		}
		informAgsEnvironmentChanged();
		return true;
	}

	/**
	 * Receives command from executeAction method from the agent that adds a new
	 * percept to the database. Removes square brackets from beginning and end
	 * of string
	 * 
	 * @param str
	 *            new percept
	 */
	static void tell(String str) {
		str = removeCharAt(str, 0);
		str = removeCharAt(str, str.length() - 1);
		System.out.println("I JUST RECEIVED THIS " + str);
		percepts.add(str);
	}

	/**
	 * Receives command from executeAction method from the agent that adds a new
	 * percept to the database.
	 * 
	 * @param str
	 *            new percept
	 */
	static void tell2(String str) {
		System.out.println("I JUST RECEIVED THIS " + str);
		percepts.add(str);
	}

	/**
	 * Updates all percepts. First it clears then all, then looks the percpet
	 * database and creates the new ones.
	 */
	synchronized void updatePercepts() {
		clearPercepts();

		for (Minion s : minions) {
			addPercept(Literal.parseLiteral("status(" + s.getName() + ","
					+ s.getTeam() + "," + s.getType() + "," + s.getHealth()
					+ ")"));
			addPercept(Literal.parseLiteral("pos(" + s.getName() + ","
					+ s.getX() + "," + s.getY() + ")"));
		}

		for (String s : percepts) {
			addPercept(s);
		}

	}
}
