package game.events;
import nme.events.Event;

/**
 * ...
 * @author Tommislav
 */

class GameEvent extends Event
{
	inline public static var CAT_CREATED:String = "GameEvent.CAT_CREATED";
	inline public static var CAT_REMOVED:String = "GameEvent.CAT_REMOVED";
	inline public static var PLAYER_DAMAGE:String = "GameEvent.DAMAGE";
	
	public var data:Dynamic;
	
	public function new(type:String, data:Dynamic) 
	{
		super(type);
		this.data = data;
	}
	
}