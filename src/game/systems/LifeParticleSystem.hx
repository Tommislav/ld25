package game.systems;
import game.components.BitmapComponent;
import game.components.LifeCountDownComponent;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class LifeParticleSystem extends Sys
{

	public function new() 
	{
		super();
	}
	
	override public function tick(gt:GameTime):Void 
	{
		var allParticleEntities = em().getEWC([LifeCountDownComponent]);
		for (entity in allParticleEntities) {
			var count = entity.comp(LifeCountDownComponent);
			count.life -= 1;
			if (count.life <= 0) {
				entity.comp(BitmapComponent).remove();
				em().destroyEntity(entity.getEntity());
			}
		}
	}
}