package game.events;
import game.utils.Gun;
import nme.events.Event;
import se.salomonsson.ent.EW;

/**
 * ...
 * @author Tommislav
 */

class CreateBulletEvent extends Event
{
	inline public static var SPAWN:String = "CreateBulletEvent.SPAWN";
	
	public var gun:Gun;
	public var firingEntity:EW;
	
	public function new(type:String, gun:Gun, firingEntity:EW) 
	{
		super(type);
		this.gun = gun;
		this.firingEntity = firingEntity;
	}
	
}