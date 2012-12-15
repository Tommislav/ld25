package game.components;
import se.salomonsson.ent.IComponent;

/**
 * ...
 * @author Tommislav
 */

class CenterPointPositionComponent implements IComponent
{
	public var x:Float;
	public var y:Float;
	public var radius:Float;
	
	
	public function new() {}
	
	
	public function intersects(otherPos:CenterPointPositionComponent):Bool {
		if (otherPos == null)
			return false;
			
		var dx = x - otherPos.x;
		var dy = y - otherPos.y;
		
		var minDist = radius + otherPos.radius;
		
		// quick optimization
		//if (Math.abs(dx) > (minDist+150) || Math.abs(dy) > (minDist+150))
			//return false;
		
		var dist = Math.sqrt((dx * dx) + (dy * dy));
		var minDist = radius + otherPos.radius;
		return (dist < minDist);
	}
	
	public static function build(x:Float, y:Float, radius:Float) {
		var c = new CenterPointPositionComponent();
		c.x = x;
		c.y = y;
		c.radius = radius;
		return c;
	}
}