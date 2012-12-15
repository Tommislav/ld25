package game.factory;
import flash.events.Event;
import game.components.AngularMovementComponent;
import game.components.BitmapComponent;
import game.components.BulletComponent;
import game.components.PositionComponent;
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
		
		var entPos = firingEntity.comp(PositionComponent);
		var rot = firingEntity.comp(AngularMovementComponent);
		var spawnX:Int = entPos.x;
		var spawnY:Int = entPos.y;
		
		spawnX += Std.int(Math.cos(rot.radians) * firingGun.offX);
		spawnY += Std.int(Math.sin(rot.radians) * firingGun.offX);
		spawnX += Std.int(Math.cos(rot.radians) * firingGun.offY);
		spawnY += Std.int(Math.sin(rot.radians) * firingGun.offY);
		
		var bulletSpeed = 16;
		var sX:Float = Math.cos(rot.radians) * bulletSpeed;
		var sY:Float = Math.sin(rot.radians) * bulletSpeed;
		
		var bullet = em().allocateEntity()
			.addComponent(PositionComponent.build(spawnX, spawnY, 16, 16))
			.addComponent(BitmapComponent.build(_tileMap.getTile(TileId.BULLET_0)))
			.addComponent(XYSpeedComponent.build(sX, sY))
			.addComponent(new BulletComponent());
	}
}