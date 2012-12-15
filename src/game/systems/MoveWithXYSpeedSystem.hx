package game.systems;
import game.components.PositionComponent;
import game.components.XYSpeedComponent;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class MoveWithXYSpeedSystem extends Sys
{

	public function new() { super(); }
	
	override public function tick(gt:GameTime):Void 
	{
		var moveComps = em().getEWC([XYSpeedComponent]);
		for (moveEnt in moveComps) {
			var speed = moveEnt.comp(XYSpeedComponent);
			var pos = moveEnt.comp(PositionComponent);
			
			if (speed.xSpeed != 0)
				pos.x += Std.int(speed.xSpeed);
			
			if (speed.ySpeed != 0)
				pos.y += Std.int(speed.ySpeed);
		}
	}
}