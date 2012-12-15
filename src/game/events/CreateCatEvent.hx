package game.events;
import nme.events.Event;

/**
 * ...
 * @author Tommislav
 */

class CreateCatEvent extends Event
{
	inline public static var SPAWN:String = "CreateCatEvent.SPAWN";
	
	public var fromX:Float;
	public var fromY:Float;
	public var toX:Float;
	public var toY:Float;
	
	public function new(type:String, fromX:Float, fromY:Float, toX:Float, toY:Float) 
	{
		super(type);
		this.fromX = fromX;
		this.fromY = fromY;
		this.toX = toX;
		this.toY = toY;
	}
	
}