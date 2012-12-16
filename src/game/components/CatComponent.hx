package game.components;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class CatComponent implements IComponent
{
	public var active:Bool;
	public var captured:Bool;
	public var value:Int;
	
	
	public function new() 
	{
		active = true;
		captured = false;
		value = 100;
	}
	
}