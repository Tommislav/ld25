package game.systems;
import game.components.GunComponent;
import game.events.CreateBulletEvent;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class GunSystem extends Sys
{

	public function new() { super(); }
	
	override public function tick(gt:GameTime):Void 
	{
		var allGunEntities = em().getEWC([GunComponent]);
		for (entityWithGuns in allGunEntities) {
			var guns = entityWithGuns.comp(GunComponent).allGuns;
			for (gun in guns) {
				gun.tick();
				if (gun.gunHasBeenFired) {
					gun.gunHasBeenFired = false;
					dispatch(new CreateBulletEvent(CreateBulletEvent.SPAWN, gun, entityWithGuns));
				}
			}
		}
	}
}