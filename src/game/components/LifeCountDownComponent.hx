package game.components;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class LifeCountDownComponent implements IComponent
{
	public var life:Int;

	public function new(life:Int = 120) 
	{
		this.life = life;
	}
	
}