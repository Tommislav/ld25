package game.systems;
import game.components.BitmapComponent;
import game.components.CenterPointPositionComponent;
import game.components.EscortObjectComponent;
import se.salomonsson.ent.EntityEvent;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;
import se.salomonsson.game.components.CameraComponent;

/**
 * ...
 * @author Tommislav
 */

class UpdateEscortingEntitiesSystem extends Sys
{

	public function new() { super(); }
	
	
	
	override public function tick(gt:GameTime):Void 
	{
		var camera = em().getComp(CameraComponent);
		
		var escortingEntities = em().getEWC([EscortObjectComponent]);
		for (ent in escortingEntities) {
			var escortComp = ent.comp(EscortObjectComponent);
			if (escortComp.isEscorting == false)
				continue;
			
			var escortingPos = em().getComponentOnEntity(escortComp.escortingEntity, CenterPointPositionComponent);
			var pos = ent.comp(CenterPointPositionComponent);
			
			// Entity has been destroyed
			if (escortingPos != null) {
				pos.x = escortingPos.x + escortComp.offX;
				pos.y = escortingPos.y + escortComp.offY;
			} else {
				escortComp.isEscorting = false;
				
				if (camera.inView(pos) == false) {
					ent.comp(BitmapComponent).remove();
					em().destroyEntity(ent.getEntity());
				}
			}
			
		}
	}
}