package game.systems;
import game.components.AngularMovementComponent;
import game.components.CenterPointPositionComponent;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class MoveWithAngularMovementSystem extends Sys
{

	public function new() { super(); }
	
	override public function tick(gt:GameTime):Void 
	{
		var angularMovingEntities = em().getEWC([AngularMovementComponent]);
		for (ew in angularMovingEntities) {
			var ang = ew.comp(AngularMovementComponent);
			if (ang.speed == 0)
				continue;
				
			var pos = ew.comp(CenterPointPositionComponent);
			
			var sx:Float = Math.cos(ang.radians) * ang.speed;
			var sy:Float = Math.sin(ang.radians) * ang.speed;
			
			pos.x += sx;
			pos.y += sy;
		}
	}
	
}