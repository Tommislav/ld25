package game.components;
import game.utils.Gun;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class GunComponent implements IComponent
{
	public var allGuns:Array<Gun>;
	
	public function new() 
	{
		allGuns = new Array<Gun>();
	}
	
	public function addGun(gun:Gun) {
		allGuns.push(gun);
		return this;
	}
}