package game.components;
import nme.geom.Rectangle;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class GameComponent implements IComponent
{
	public var score:Int;
	public var money:Int;
	public var catsKilled:Int;
	public var catsTotal:Int;
	
	public var levelBounds:Rectangle;
	public var playerDamageCounter:Int;
	
	public function new() 
	{
		levelBounds = new Rectangle(0, 0, 5000, 5000);
	}
	
	public function playerWasDamaged() {
		playerDamageCounter = 6;
	}
	
}