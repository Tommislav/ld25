package game.systems;
import game.components.AngularMovementComponent;
import game.components.CatComponent;
import game.components.CenterPointPositionComponent;
import game.components.EnemyComponent;
import game.components.PlayerComponent;
import game.enums.BulletType;
import game.enums.EnemyType;
import game.events.CreateBulletEvent;
import game.utils.Gun;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;
import se.salomonsson.game.components.CameraComponent;

/**
 * ...
 * @author Tommislav
 */

class EnemySystem extends Sys
{

	private var dummyGun:Gun;
	
	public function new()  { 
		super(); 
		dummyGun = new Gun();
		dummyGun.spawnOffsetAngle = 0;
		dummyGun.spawnOffsetDistance = 46;
	}
	
	
	override public function tick(gt:GameTime):Void 
	{
		var camera = em().getComp(CameraComponent);
		
		var player = em().getEWC([PlayerComponent])[0];
		var playerPos = player.comp(CenterPointPositionComponent);
		
		var allEnemies = em().getEWC([EnemyComponent]);
		
		
		for (enemy in allEnemies) {
			
			var enemyPos = enemy.comp(CenterPointPositionComponent);
			if (camera.inView(enemyPos) == false)
				continue;
			
			var enemyComp = enemy.comp(EnemyComponent);
			var type = enemyComp.type;
			
			
			if (type == EnemyType.RANDOM || type == EnemyType.RANDOM_FAST) {
				if (--enemyComp.counter == 0) {
					// shoot in random direction
					
					dummyGun.spawnOffsetAngle = dummyGun.directionRadians = Math.random() * Math.PI * 2;
					dispatch(new CreateBulletEvent(CreateBulletEvent.SPAWN, dummyGun, enemy, BulletType.ENEMY, [CatComponent]));
				}
			
				if (enemyComp.counter <= 0) {
					var waitTime = (type == EnemyType.RANDOM_FAST) ? Std.int(Math.random() * 20 + 20) : Std.int(Math.random() * 120 + 120);
					enemyComp.counter = waitTime;
				}
				
				
			} else if (type == EnemyType.FIRE_TOWARDS_PLAYER) {
				
				if (--enemyComp.counter == 0) {
					var dx = playerPos.x - enemyPos.x;
					var dy = playerPos.y - enemyPos.y;
					var playerAngle = Math.atan2(dy, dx);
					
					playerAngle -= enemy.comp(AngularMovementComponent).radians;
					
					dummyGun.spawnOffsetAngle = dummyGun.directionRadians = playerAngle;
					dispatch(new CreateBulletEvent(CreateBulletEvent.SPAWN, dummyGun, enemy, BulletType.ENEMY, [CatComponent]));
				}
				
				if (enemyComp.counter <= 0) {
					var waitTime = Std.int(Math.random()*200 + 30);
					enemyComp.counter = waitTime;
				}
			}
			
		}
	}
}