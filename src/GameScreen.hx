package ;
import game.components.AngularMovementComponent;
import game.components.BitmapComponent;
import game.components.DamagebleComponent;
import game.components.GameScreenComponent;
import game.components.GunComponent;
import game.components.PlayerComponent;
import game.components.CenterPointPositionComponent;
import game.enums.TileId;
import game.factory.BulletFactory;
import game.systems.CameraTrackPlayerSystem;
import game.systems.GunSystem;
import game.systems.MoveWithAngularMovementSystem;
import game.systems.MoveWithXYSpeedSystem;
import game.systems.RenderBitmapsSystem;
import game.systems.UpdateBulletsSystem;
import game.systems.UpdateDamagablesSystem;
import game.systems.UpdatePlayerSystem;
import game.utils.Gun;
import game.utils.TileMap;
import nme.Assets;
import nme.display.BitmapData;
import nme.events.Event;
import nme.geom.Rectangle;
import nme.Lib;
import se.salomonsson.ent.Core;
import se.salomonsson.game.components.CameraComponent;
import se.salomonsson.game.components.SineMoveCameraSystem;
import se.salomonsson.game.systems.KeyboardInputSystem;

/**
 * ...
 * @author Tommislav
 */

class GameScreen 
{
	
	private var _core:Core;
	private var _tileMap:TileMap;
	
	public function new() 
	{
		setupTileMap();
		
		
		_core = new Core();
		
		// Game canvas entity
		_core.getEntManager().allocateEntity()
			.addComponent(GameScreenComponent.build(Lib.current.stage, 640, 480))
			.addComponent(new CameraComponent("camera"));
		
		// Hero (or in this case: villain) entity
		_core.getEntManager().allocateEntity()
			.addComponent(CenterPointPositionComponent.build(10, 10, 32))
			.addComponent(AngularMovementComponent.build(-90, 0))
			.addComponent(BitmapComponent.build(_tileMap.getTile(TileId.HERO_0)))
			.addComponent(new GunComponent().addGun(Gun.build(36, 0, 0, 25, "")))
			.addComponent(new DamagebleComponent(3))
			.addComponent(new PlayerComponent());
		
		// create some random enemies
		for (i in 0...10) {
			enemyFactory(Std.int(Math.random() * 1000), Std.int(Math.random() * 1000));
		}
		
		
		_core.addSystem(new KeyboardInputSystem(), 9);
		
		_core.addSystem(new MoveWithXYSpeedSystem(), 8);
		
		_core.addSystem(new UpdatePlayerSystem(), 7);
		_core.addSystem(new UpdateBulletsSystem(), 7);
		
		
		_core.addSystem(new GunSystem(), 7);
		_core.addSystem(new CameraTrackPlayerSystem(), 7);
		_core.addSystem(new UpdateDamagablesSystem(), 7);
		//_core.addSystem(new SineMoveCameraSystem("camera"), 9);
		
		_core.addSystem(new BulletFactory(_tileMap), 6);
		
		_core.addSystem(new RenderBitmapsSystem(Lib.current.stage), 1);
		
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	private function onEnterFrame(e:Event):Void 
	{
		_core.tick();
	}
	
	private function setupTileMap() 
	{
		_tileMap = new TileMap();
		var bd:BitmapData = Assets.getBitmapData("img/sheet1.png");
		
		_tileMap.mapTile(TileId.HERO_0, bd, new Rectangle(0, 0, 64, 64));
		_tileMap.mapTile(TileId.GUARD_0, bd, new Rectangle(64, 0, 64, 64));
		_tileMap.mapTile(TileId.CAT_0, bd, new Rectangle(128, 0, 64, 64));
		_tileMap.mapTile(TileId.BULLET_0, bd, new Rectangle(192, 0, 16, 16));
		
	}
	
	
	
	
	private function enemyFactory(x, y) {
		// Enemy (a guard)
		_core.getEntManager().allocateEntity()
			.addComponent(CenterPointPositionComponent.build(x, y, 32))
			.addComponent(AngularMovementComponent.build(0, 3))
			.addComponent(BitmapComponent.build(_tileMap.getTile(TileId.GUARD_0)))
			.addComponent(new DamagebleComponent());
	}
	
}