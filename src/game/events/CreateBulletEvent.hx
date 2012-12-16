package game.events;
import game.utils.Gun;
import nme.events.Event;
import se.salomonsson.ent.EW;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class CreateBulletEvent extends Event
{
	inline public static var SPAWN:String = "CreateBulletEvent.SPAWN";
	
	public var gun:Gun;
	public var firingEntity:EW;
	public var bulletImmuneTypes:Array<Dynamic>;
	public var bulletType:String;
	
	public function new(type:String, gun:Gun, firingEntity:EW, bulletType:String, bulletImmuneTypes:Array<Dynamic>=null) 
	{
		super(type);
		this.gun = gun;
		this.firingEntity = firingEntity;
		this.bulletImmuneTypes = bulletImmuneTypes;
		this.bulletType = bulletType;
	}
	
}