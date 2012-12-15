package game.components;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class DamagebleComponent implements IComponent
{
	public var health:Int;
	public var prevHealth:Int;
	
	public function new(startHealth:Int = 1) 
	{
		health = prevHealth = startHealth;
	}
	
}