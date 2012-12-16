package ;
import game.components.AngularMovementComponent;
import game.components.BitmapComponent;
import game.components.DamagebleComponent;
import game.components.GameComponent;
import game.components.GameScreenComponent;
import game.components.GunComponent;
import game.components.PlayerComponent;
import game.components.CenterPointPositionComponent;
import game.components.TileMapComponent;
import game.enums.EnemyType;
import game.enums.TileId;
import game.events.CreateEnemyEvent;
import game.factory.BulletFactory;
import game.factory.CatFactory;
import game.factory.EnemyFactory;
import game.factory.TextFactory;
import game.systems.CameraTrackPlayerSystem;
import game.systems.EnemySystem;
import game.systems.FaceDirectionSystem;
import game.systems.GameSystem;
import game.systems.GunSystem;
import game.systems.LifeParticleSystem;
import game.systems.MoveWithAngularMovementSystem;
import game.systems.MoveWithXYSpeedSystem;
import game.systems.RenderBitmapsSystem;
import game.systems.UpdateBulletsSystem;
import game.systems.UpdateCatsSystem;
import game.systems.UpdateCatTrackersSystem;
import game.systems.UpdateDamagablesSystem;
import game.systems.UpdateEscortingEntitiesSystem;
import game.systems.UpdatePlayerSystem;
import game.systems.RenderBackgroundTilesSystem;
import game.utils.Gun;
import game.utils.TileMap;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.events.Event;
import nme.geom.Rectangle;
import nme.Lib;
import se.salomonsson.ent.Core;
import se.salomonsson.game.components.CameraComponent;
import se.salomonsson.game.components.CanvasComponent;
import se.salomonsson.game.components.SineMoveCameraSystem;
import se.salomonsson.game.components.TileLayerComponent;
import se.salomonsson.game.components.TileModelComponent;
import se.salomonsson.game.components.ViewPortComponent;
import se.salomonsson.game.systems.DebugCameraPositionSystem;
import se.salomonsson.game.systems.KeyboardInputSystem;


import se.salomonsson.game.systems.RenderViewPortSystem;
import se.salomonsson.game.utils.PixelMapParser;

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
		setupSpritesMap();
		
		var map:PixelMapParser = new PixelMapParser(Assets.getBitmapData("img/levelmap.gif"));
		var tiles:BitmapData = Assets.getBitmapData("img/BackgroundTiles.png");
		
		_core = new Core();
		
		// Game canvas entity
		_core.getEntManager().allocateEntity()
			.addComponent(GameScreenComponent.build(Lib.current.stage, 640, 480))
			.addComponent(CameraComponent.build("camera", 0, 0, 640, 480))
			.addComponent(new ViewPortComponent("main"))
			.addComponent(TileModelComponent.build([tiles])) // ops, old crap. If I had more time I would remove this and ony use tileMapComponent which is much more supreior!
			.addComponent(CanvasComponent.build(buildCanvas(640, 480)))
			.addComponent(TileMapComponent.build(_tileMap))
			.addComponent(TileLayerComponent.build("main", 10, map, 0.5, 0.5))
			.addComponent(new GameComponent());
			
		//_core.getEntManager().allocateEntity()
			
		
		
		var gunComp:GunComponent = new GunComponent();
		gunComp.addGun(Gun.build(0, 36, 0, 25, ""));
		gunComp.addGun(Gun.build(Math.PI, 36, Math.PI, 25, ""));
		gunComp.addGun(Gun.build(Math.PI/2, 36, Math.PI/2, 25, ""));
		gunComp.addGun(Gun.build(Math.PI*1.5, 36, Math.PI*1.5, 25, ""));
		
		
		// Hero (or in this case: villain) entity
		_core.getEntManager().allocateEntity()
			.addComponent(CenterPointPositionComponent.build(500, 500, 32))
			.addComponent(AngularMovementComponent.build(-90, 0))
			.addComponent(BitmapComponent.build(_tileMap.getTile(TileId.HERO_0)))
			.addComponent(gunComp)
			.addComponent(new DamagebleComponent(3))
			.addComponent(new PlayerComponent());
		
		
		_core.addSystem(new KeyboardInputSystem(), 9);
		_core.addSystem(new GameSystem(), 9);
		
		_core.addSystem(new MoveWithXYSpeedSystem(), 8);
		
		_core.addSystem(new UpdatePlayerSystem(), 7);
		_core.addSystem(new UpdateBulletsSystem(), 7);
		
		
		_core.addSystem(new GunSystem(), 7);
		_core.addSystem(new CameraTrackPlayerSystem(), 7);
		_core.addSystem(new LifeParticleSystem(), 7);
		_core.addSystem(new UpdateCatsSystem(_tileMap), 6);
		_core.addSystem(new BulletFactory(_tileMap), 6);
		_core.addSystem(new CatFactory(_tileMap), 6);
		_core.addSystem(new TextFactory(_tileMap), 6);
		_core.addSystem(new EnemyFactory(), 6);
		_core.addSystem(new UpdateCatTrackersSystem(), 6);
		_core.addSystem(new UpdateEscortingEntitiesSystem(), 6);
		_core.addSystem(new FaceDirectionSystem(), 6);
		_core.addSystem(new EnemySystem(), 6);
		
		_core.addSystem(new UpdateDamagablesSystem(), 2);
		
		_core.addSystem(new RenderBitmapsSystem(Lib.current.stage), 1);
		_core.addSystem(new RenderBackgroundTilesSystem("main", tiles), 1);
		_core.addSystem(new DebugCameraPositionSystem(Lib.current.stage), 1);
		
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		
		// create some random enemies
		var enemyType:String;
		for (i in 0...10) {
			//if (i < 3)
				//enemyType = EnemyType.RANDOM;
			//else if (i < 6)
				//enemyType = EnemyType.RANDOM_FAST;
			//else
				enemyType = EnemyType.FIRE_TOWARDS_PLAYER;
			
			_core.getSystemManager().getEventDispatcher().dispatchEvent(new CreateEnemyEvent(CreateEnemyEvent.SPAWN, enemyType));
		}
	}
	
	private function onEnterFrame(e:Event):Void 
	{
		_core.tick();
	}
	
	
	
	
	private function setupSpritesMap() 
	{
		_tileMap = new TileMap();
		var bd:BitmapData = Assets.getBitmapData("img/sheet1.png");
		
		_tileMap.mapTile(TileId.HERO_0, bd, new Rectangle(0, 0, 64, 64));
		_tileMap.mapTile(TileId.GUARD_0, bd, new Rectangle(64, 0, 64, 64));
		_tileMap.mapTile(TileId.CAT_0, bd, new Rectangle(128, 0, 64, 64));
		_tileMap.mapTile(TileId.BULLET_0, bd, new Rectangle(192, 0, 16, 16));
		_tileMap.mapTile(TileId.CAT_MARKER, bd, new Rectangle(192, 16, 16, 16));
		_tileMap.mapTile(TileId.TEXT_CAT_KIDNAPPED, bd, new Rectangle(192, 64, 128, 32));
		_tileMap.mapTile(TileId.TEXT_CAT_KILLED, bd, new Rectangle(192, 96, 128, 32));
	}
	
	
	
	private function buildCanvas(width:Int, height:Int):BitmapData {
		var bd:BitmapData = new BitmapData(width, height, false, 0xffcc00);
		var bmp:Bitmap = new Bitmap(bd);
		Lib.current.stage.addChild(bmp);
		
		return bd;
	}
	
}