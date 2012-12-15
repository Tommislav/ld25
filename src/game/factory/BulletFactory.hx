package game.factory;
import flash.events.Event;
import game.components.AngularMovementComponent;
import game.components.BitmapComponent;
import game.components.BulletComponent;
import game.components.CenterPointPositionComponent;
import game.components.XYSpeedComponent;
import game.enums.TileId;
import game.events.CreateBulletEvent;
import game.utils.Gun;
import game.utils.TileMap;
import se.salomonsson.ent.EW;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class BulletFactory extends Sys
{
	private var _tileMap:TileMap;
	
	public function new(tileMap:TileMap) 
	{
		super();
		_tileMap = tileMap;
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		addListener(CreateBulletEvent.SPAWN, onSpawnBullet);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		removeListener(CreateBulletEvent.SPAWN, onSpawnBullet);
	}
	
	private function onSpawnBullet(e:CreateBulletEvent):Void 
	{
		var firingGun:Gun = e.gun;
		var firingEntity:EW = e.firingEntity;
		
		var entPos = firingEntity.comp(CenterPointPositionComponent);
		var rot = firingEntity.comp(AngularMovementComponent);
		var spawnX:Float = entPos.x;
		var spawnY:Float = entPos.y;
		
		spawnX += (Math.cos(rot.radians) * firingGun.offX);
		spawnY += (Math.sin(rot.radians) * firingGun.offX);
		spawnX += (Math.cos(rot.radians) * firingGun.offY);
		spawnY += (Math.sin(rot.radians) * firingGun.offY);
		
		var bulletSpeed = 16;
		var sX:Float = Math.cos(rot.radians) * bulletSpeed;
		var sY:Float = Math.sin(rot.radians) * bulletSpeed;
		
		var bullet = em().allocateEntity()
			.addComponent(CenterPointPositionComponent.build(spawnX, spawnY, 2))
			.addComponent(BitmapComponent.build(_tileMap.getTile(TileId.BULLET_0)))
			.addComponent(XYSpeedComponent.build(sX, sY))
			.addComponent(new BulletComponent());
	}
}