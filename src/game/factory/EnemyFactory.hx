package game.factory;
import game.components.AngularMovementComponent;
import game.components.BitmapComponent;
import game.components.CenterPointPositionComponent;
import game.components.CollidableComponent;
import game.components.DamagebleComponent;
import game.components.EnemyComponent;
import game.components.EscortObjectComponent;
import game.components.FaceDirectionComponent;
import game.components.GameComponent;
import game.components.TileMapComponent;
import game.enums.EnemyType;
import game.enums.TileId;
import game.events.CreateEnemyEvent;
import game.utils.TileMap;
import se.salomonsson.ent.EntManager;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class EnemyFactory extends Sys
{
	private var _tileMap:TileMap;
	private var _gameComp:GameComponent;
	
	public function new() { super(); }
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_tileMap = em.getComp(TileMapComponent).tileMap;
		_gameComp = em.getComp(GameComponent);
		addListener(CreateEnemyEvent.SPAWN, onSpawnNewEnemy);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		removeListener(CreateEnemyEvent.SPAWN, onSpawnNewEnemy);
	}
	
	private function onSpawnNewEnemy(event:CreateEnemyEvent) {
		
		
		// Enemy (a guard)
		var enemy = em().allocateEntity();
		
		// --- Position ---
		var pos = CenterPointPositionComponent.build(0, 0, 42);
		if (event.otherEntity > -1) {
			var ang:Array<Float> = 
				[0, Math.PI, Math.PI / 2, Math.PI * 1.5, 
				Math.PI/4, Math.PI*0.75, Math.PI*1.25, Math.PI * 1.75];
			var dist:Array<Float> = [200.0, 200.0, 200.0, 200.0, 
				100.0, 100.0, 100.0, 100.0];
			
			var index = (event.enemyIndex > -1) ? event.enemyIndex : 1;
			
			var a = ang[index];
			var d = dist[index];
			
			var offX:Float = Math.cos(a) * d;
			var offY:Float = Math.sin(a) * d;
			enemy.addComponent(EscortObjectComponent.build(event.otherEntity, offX, offY)); 
			enemy.addComponent(new FaceDirectionComponent());
			
		} else {
			pos.x = Math.random() * _gameComp.levelBounds.width;
			pos.y = Math.random() * _gameComp.levelBounds.height;
		}
		enemy.addComponent(pos);
		
		enemy.addComponent(new CollidableComponent());
		enemy.addComponent(AngularMovementComponent.build(180, 0));
		enemy.addComponent(BitmapComponent.build(_tileMap.getTile(TileId.GUARD_0)));
		enemy.addComponent(EnemyComponent.build(event.enemyType));
		enemy.addComponent(new DamagebleComponent());
	}
}