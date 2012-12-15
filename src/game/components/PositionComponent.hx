package game.components;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class PositionComponent implements IComponent
{
	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	
	
	public function new() {}
	
	public static function build(x:Int, y:Int, width:Int, height:Int) {
		var c = new PositionComponent();
		c.x = x;
		c.y = y;
		c.width = width;
		c.height = height;
		return c;
	}
}