package game.components;
import game.utils.TileMap;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class TileMapComponent implements IComponent
{
	public var tileMap:TileMap;

	public function new() {}
	
	static public function build(tileMap:TileMap) {
		var c:TileMapComponent = new TileMapComponent();
		c.tileMap = tileMap;
		return c;
	}
}