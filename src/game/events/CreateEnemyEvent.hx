package game.events;
import nme.events.Event;

/**
 * ...
 * @author Tommislav
 */

class CreateEnemyEvent extends Event
{
	inline public static var SPAWN:String = "CreateEnemyEvent.SPAWN";
	
	public function new(type:String) 
	{
		super(type);
	}
	
}