package game.components;
import nme.display.DisplayObjectContainer;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class GameScreenComponent implements IComponent
{
	public var holder:DisplayObjectContainer;
	public var width:Int;
	public var height:Int;
	
	public function new() {}
	
	public static function build(holder:DisplayObjectContainer, width:Int, height:Int) {
		var c = new GameScreenComponent();
		c.holder = holder;
		c.width = width;
		c.height = height;
		return c;
	}
}