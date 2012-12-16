package game.events;
import nme.events.Event;

/**
 * ...
 * @author Tommislav
 */

class CreateEnemyEvent extends Event
{
	inline public static var SPAWN:String = "CreateEnemyEvent.SPAWN";
	
	public var enemyType:String;
	public var otherEntity:Int;
	public var enemyIndex:Int;
	
	public function new(type:String, enemyType:String, otherEntity:Int=-1, enemyIndex:Int=-1) 
	{
		super(type);
		this.enemyType = enemyType;
		this.otherEntity = otherEntity;
		this.enemyIndex = enemyIndex;
	}
	
}