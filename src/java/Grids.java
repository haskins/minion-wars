/**
 * Grid for GUI.
 * 
 * @author Josh Haskins
 */

import java.awt.Canvas;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.util.ArrayList;

class Grids extends Canvas {

	private static final long serialVersionUID = 1L;

	int width, height, rows, columns;

	int ICON_WIDTH = 25, ICON_HEIGHT = 25;

	FontMetrics fm;

	Boolean SIMOVER = false;

	String WINNER;

	public static String[][] field_team = new String[20][20],
			field_type = new String[20][20];

	private static Font monoFont = new Font("Monospaced", Font.BOLD, 20);

	static ArrayList<Minion> minions;

	/**
	 * Constructs the size of the grid
	 * 
	 * @param w
	 *            width of grid box
	 * @param h
	 *            height of grid box
	 * @param r
	 *            rows
	 * @param columns
	 */
	Grids(int w, int h, int r, int c) {
		setSize(width = w, height = h);
		rows = r;
		columns = c;
	}

	/**
	 * Prints on screen a Simulation Over screen with the winners name.
	 * 
	 * @param g
	 *            Graphics element
	 */
	public void simOver(Graphics g) {
		g.setColor(Color.black);
		g.fillRect(0, 0, getWidth(), getHeight());
		g.setFont(monoFont);
		g.setColor(Color.white);
		g.drawString("Simulation Over", 50, 50);
		g.drawString(WINNER + " Wins", 50, 100);
	}

	/**
	 * Clears the team and type database.
	 */
	public static void clear() {
		// clear the field
		for (int i = 0; i < Grids.field_team.length; i++) {
			for (int v = 0; v < Grids.field_team.length; v++) {
				Grids.field_team[i][v] = null;
				Grids.field_type[i][v] = null;
			}
		}
	}

	/**
	 * Converts all data from simulation into GUI data.
	 */
	public void conv() {
		minions = Battlefield.getMinions();

		clear();

		int t1_count = 0, t2_count = 0, t3_count = 0, t4_count = 0;
		// map correct locations to grid
		for (Minion s : minions) {
			if (s.getHealth() > 0) {
				if (s.getTeam() == Battlefield.T1) {
					t1_count++;
				} else if (s.getTeam() == Battlefield.T2) {
					t2_count++;
				} else if (s.getTeam() == Battlefield.T3) {
					t3_count++;
				} else if (s.getTeam() == Battlefield.T4) {
					t4_count++;
				}
				if (Grids.field_team[s.getX()][s.getY()] == null) {
					Grids.field_team[s.getX()][s.getY()] = s.getTeam();
					Grids.field_type[s.getX()][s.getY()] = s.getType();
				} else {
					Grids.field_team[s.getX()][s.getY()] = "battle";
					Grids.field_type[s.getX()][s.getY()] = "x";
				}
			}
		}

		// checks for winner if all other teams have been wiped out
		if (t1_count == 0 && t2_count == 0 && t3_count == 0) {
			SIMOVER = true;
			WINNER = Battlefield.T4;
			Battlefield.tell2("sim(over)");
		} else if (t2_count == 0 && t3_count == 0 && t4_count == 0) {
			SIMOVER = true;
			WINNER = Battlefield.T1;
			Battlefield.tell2("sim(over)");
		} else if (t1_count == 0 && t2_count == 0 && t4_count == 0) {
			SIMOVER = true;
			WINNER = Battlefield.T3;
			Battlefield.tell2("sim(over)");
		} else if (t1_count == 0 && t3_count == 0 && t4_count == 0) {
			SIMOVER = true;
			WINNER = Battlefield.T2;
			Battlefield.tell2("sim(over)");
		}

		repaint();
	}

	/**
	 * Draws a circle on screen
	 * 
	 * @param g
	 *            Graphics element to draw on
	 * @param x
	 *            position for x coordinate
	 * @param y
	 *            position for y coordinate
	 * @param c
	 *            colour of circle
	 */
	public void drawCircle(Graphics g, int x, int y, Color c) {
		g.setColor(c);
		g.fillOval(x, y, ICON_WIDTH, ICON_HEIGHT);
	}

	/**
	 * Prints letter on screen.
	 * 
	 * @param g
	 *            Graphics element to draw on
	 * @param x
	 *            position for x coordinate
	 * @param y
	 *            position for y coordinate
	 * @param v
	 *            text to print
	 */
	public void printLetter(Graphics g, int x, int y, String v) {
		g.setFont(monoFont);
		g.setColor(Color.white);
		g.drawString(v, (x * 25) + 7, (int) ((y * 25) * 0.92) + 20);
	}

	/**
	 * Paints the screen with required GUI information.
	 */
	public void paint(Graphics g) {

		if (SIMOVER == true) {
			simOver(g);
		} else {

			int k;
			width = getSize().width;
			height = getSize().height;

			//draws rows
			int htOfRow = height / (rows);
			for (k = 0; k < rows; k++)
				g.drawLine(0, k * htOfRow, width, k * htOfRow);

			//draws columns
			int wdOfRow = width / (columns);
			for (k = 0; k < columns; k++)
				g.drawLine(k * wdOfRow, 0, k * wdOfRow, height);

			//draws players
			for (int i = 0; i < field_team.length; i++) {
				for (int v = 0; v < field_team.length; v++) {
					if (field_team[i][v] != null) {
						if (field_team[i][v].equals(Battlefield.T1)) {
							drawCircle(g, i * 25, (int) ((v * 25) * 0.92),
									Color.blue);
							printLetter(g, i, v, field_type[i][v]);
						} else if (field_team[i][v].equals(Battlefield.T2)) {
							drawCircle(g, i * 25, (int) ((v * 25) * 0.92),
									Color.red);
							printLetter(g, i, v, field_type[i][v]);

						} else if (field_team[i][v].equals(Battlefield.T3)) {
							drawCircle(g, i * 25, (int) ((v * 25) * 0.92),
									Color.green);
							printLetter(g, i, v, field_type[i][v]);

						} else if (field_team[i][v].equals(Battlefield.T4)) {
							drawCircle(g, i * 25, (int) ((v * 25) * 0.92),
									Color.yellow);
							printLetter(g, i, v, field_type[i][v]);
						} else if (field_team[i][v].equals("battle")) {
							drawCircle(g, i * 25, (int) ((v * 25) * 0.92),
									Color.black);
							printLetter(g, i, v, field_type[i][v]);
						}
					}
				}
			}
		}
	}
}