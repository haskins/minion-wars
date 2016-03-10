/**
 * Creates the GUI window, then uses Grids for additional GUI elements.
 * 
 * @author Josh Haskins
 */

import java.awt.Dimension;
import java.awt.Frame;

public class DrawWindows extends Frame {

	private static final long serialVersionUID = 1L;
	static Grids grid;

	/**
	 * Draws lines for grid view on Frame/Panel.
	 * 
	 * @param title
	 *            window name
	 * @param w
	 *            width of window
	 * @param h
	 *            height of window
	 * @param rows
	 *            number of rows
	 * @param columns
	 *            number of columns
	 */
	DrawWindows(String title, int w, int h, int rows, int columns) {
		setTitle(title);
		grid = new Grids(w, h, rows, columns);
		add(grid);
	}

	/**
	 * Creates the main window.
	 */
	public static void main() {
		DrawWindows dg = new DrawWindows("Battlefield", 200, 200, 20, 20);
		dg.setPreferredSize(new Dimension(500, 500));
		dg.setResizable(false);
		dg.pack();
		dg.setVisible(true);
		Grids.clear();
	}
}