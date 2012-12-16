package game.systems;
import game.components.BitmapComponent;
import game.components.DamagebleComponent;
import game.components.PlayerComponent;
import se.salomonsson.ent.EW;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class UpdateDamagablesSystem extends Sys
{

	public function new() 
	{
		super();
	}
	
	override public function tick(gt:GameTime):Void 
	{
		var player = em().getEWC([PlayerComponent])[0];
		
		var allDamagebleEntities = em().getEWC([DamagebleComponent]);
		for (dmgEntity in allDamagebleEntities) {
			var dmg = dmgEntity.comp(DamagebleComponent);
			if (dmg.health != dmg.prevHealth) {
				dmg.prevHealth = dmg.health;
				if (dmg.health <= 0 && (dmgEntity.getEntity() != player.getEntity())) {
					destroyEntity(dmgEntity);
				}
			}
		}
	}
	
	private function destroyEntity(e:EW) 
	{
		var holder = e.comp(BitmapComponent).holder;
		if (holder.parent != null)
			holder.parent.removeChild(holder);
		
		em().destroyEntity(e.getEntity());
	}
}