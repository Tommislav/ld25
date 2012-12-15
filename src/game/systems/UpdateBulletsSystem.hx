package game.systems;
import game.components.BitmapComponent;
import game.components.BulletComponent;
import game.components.DamagebleComponent;
import game.components.CenterPointPositionComponent;
import se.salomonsson.ent.EW;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;
import se.salomonsson.game.components.CameraComponent;

/**
 * ...
 * @author Tommislav
 */

class UpdateBulletsSystem extends Sys
{
	private var _camera:CameraComponent;
	
	public function new() { super(); }
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_camera = em.getComp(CameraComponent);
	}
	
	override public function tick(gt:GameTime):Void 
	{
		var damageableEntities = em().getEWC([DamagebleComponent]);
		
		
		var allBullets = em().getEWC([BulletComponent]);
		for (bullet in allBullets) {
			var pos = bullet.comp(CenterPointPositionComponent);
			
			if (_camera.inView(pos) == false) {
				destroyBullet(bullet);
				continue; 
			}
			
			var bulletPos = bullet.comp(CenterPointPositionComponent);
			for (e in damageableEntities) {
				var pos = e.comp(CenterPointPositionComponent);
				if (bulletPos.intersects(pos)) {
					e.comp(DamagebleComponent).health -= 1;
					destroyBullet(bullet);
					continue;
				}
			}
		}
	}
	
	
	
	private function destroyBullet(e:EW) {
		var bulletBitmapComponent = e.comp(BitmapComponent);
		if (bulletBitmapComponent != null) {
			var bulletHolder = bulletBitmapComponent.holder;
			if (bulletHolder.parent != null)
			bulletHolder.parent.removeChild(bulletHolder);
			
			em().destroyEntity(e.getEntity());
		}
	}
}