package game.events;
import nme.events.Event;

/**
 * ...
 * @author Tommislav
 */

class CreateTextEvent extends Event
{

	inline public static var CAT_KIDNAPPED:String = "CreateTextEvent.CAT_KIDNAPPED";
	inline public static var CAT_KILLED:String = "CreateTextEvent.CAT_KILLED";
	
	public var x:Float;
	public var y:Float;
	
	public function new(type:String, x:Float, y:Float) 
	{
		super(type);
		this.x = x;
		this.y = y;
	}
	
}