package game.systems;
import game.components.AngularMovementComponent;
import game.components.CenterPointPositionComponent;
import game.components.FaceDirectionComponent;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;
import se.salomonsson.game.components.CameraComponent;

/**
 * ...
 * @author Tommislav
 */

class FaceDirectionSystem extends Sys
{

	public function new() { super(); }
	
	override public function tick(gt:GameTime):Void 
	{
		var camera = em().getComp(CameraComponent);
		var allFaceDirEnts = em().getEWC([FaceDirectionComponent]);
		for (ent in allFaceDirEnts) {
			var faceDir = ent.comp(FaceDirectionComponent);
			var pos = ent.comp(CenterPointPositionComponent);
			
			var lastX = faceDir.lastX;
			var lastY = faceDir.lastY;
			var thisX = pos.x;
			var thisY = pos.y;
			
			faceDir.lastX = thisX;
			faceDir.lastY = thisY;
			
			if (lastX < -1000 || lastY < -1000)
				continue;
			
			if (camera.inView(pos)) {
				var dx = thisX - lastX;
				var dy = thisY - lastY;
				
				if (dx != 0 && dy != 0) {
					var rot = ent.comp(AngularMovementComponent);
					var angle = Math.atan2(dy, dx);
					rot.setRadians(angle);
				}
			}
		}
	}
}