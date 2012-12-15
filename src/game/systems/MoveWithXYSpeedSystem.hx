package game.systems;
import game.components.CenterPointPositionComponent;
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
			var pos = moveEnt.comp(CenterPointPositionComponent);
			
			if (speed.xSpeed != 0)
				pos.x += speed.xSpeed;
			
			if (speed.ySpeed != 0)
				pos.y += speed.ySpeed;
		}
	}
}