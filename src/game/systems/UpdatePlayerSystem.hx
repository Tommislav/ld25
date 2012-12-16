package game.systems;
import game.components.AngularMovementComponent;
import game.components.CollidableComponent;
import game.components.DamagebleComponent;
import game.components.GameComponent;
import game.components.GunComponent;
import game.components.PlayerComponent;
import game.components.CenterPointPositionComponent;
import game.events.GameEvent;
import nme.ui.Keyboard;
import se.salomonsson.ent.EW;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;
import se.salomonsson.game.components.KeyboardInputComponent;

/**
 * ...
 * @author Tommislav
 */

class UpdatePlayerSystem extends Sys
{
	private var _player:EW;
	private var _keyboard:KeyboardInputComponent;
	private var _health:DamagebleComponent;
	
	private var _speedX:Float;
	private var _speedY:Float;
	private var _accel:Float;
	private var _maxSpeed:Float;
	private var _friction:Float;
	
	
	public function new() { 
		super(); 
		
		// These properties should be in component so they can be upgraded!
		_accel = 0.25;
		_maxSpeed = 8;
		_speedX = 0;
		_speedY = 0;
		_friction = 0.93;
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		_player = em.getEWC([PlayerComponent])[0];
		_health = _player.comp(DamagebleComponent);
	}
	
	override public function tick(gt:GameTime):Void 
	{
		var rotComp = _player.comp(AngularMovementComponent);
		
		if (_health.health == 0) {
			rotComp.setDegrees(rotComp.angle + 5);
			trace("I am dead!");
			return;
		}
		
		if (_keyboard == null)
			_keyboard = em().getComp(KeyboardInputComponent);
		
		var leftIsPressed:Bool = _keyboard.getKeyIsDown(Keyboard.LEFT);
		var rightIsPressed:Bool = _keyboard.getKeyIsDown(Keyboard.RIGHT);
		var upIsPressed:Bool = _keyboard.getKeyIsDown(Keyboard.UP);
		var downIsPressed:Bool = _keyboard.getKeyIsDown(Keyboard.DOWN);
		
		
		if (leftIsPressed)
			_speedX -= _accel;
		if (rightIsPressed)
			_speedX += _accel;
		if (upIsPressed)
			_speedY -= _accel;
		if (downIsPressed)
			_speedY += _accel;
		
		if (!leftIsPressed && !rightIsPressed)
			_speedX *= _friction;
			
		if (!upIsPressed && !downIsPressed)
			_speedY *= _friction;
		
		if (_speedX < -_maxSpeed)
			_speedX = -_maxSpeed;
		else if (_speedX > _maxSpeed)
			_speedX = _maxSpeed;
			
		if (_speedY < -_maxSpeed)
			_speedY = -_maxSpeed;
		else if (_speedY > _maxSpeed)
			_speedY = _maxSpeed;
		
		rotComp.setRadians(Math.atan2(_speedY, _speedX));
		
		var pos = em().getComp(CenterPointPositionComponent);
		pos.x += _speedX;
		pos.y += _speedY;
		
		
		var levelBounds = em().getComp(GameComponent).levelBounds;
		if (pos.x < levelBounds.x)
			pos.x = levelBounds.x;
		else if (pos.x > levelBounds.right)
			pos.x = levelBounds.right;
		
		if (pos.y < levelBounds.y)
			pos.y = levelBounds.y;
		else if (pos.y > levelBounds.bottom)
			pos.y = levelBounds.bottom;
		
		
		
		if (_keyboard.getKeyIsDown(Keyboard.SPACE)) {
			var guns = _player.comp(GunComponent).allGuns;
			for (gun in guns) {
				if (gun.canFire()) {
					gun.fire();
				}
			}
		}
		
		
		// Check for collision against enemy ships
		var collidables = em().getEWC([CollidableComponent]);
		for (coll in collidables) {
			var enemyPos = coll.comp(CenterPointPositionComponent);
			if (pos.intersects(enemyPos)) {
				coll.comp(DamagebleComponent).health--;
				_health.health--;
				em().getComp(GameComponent).playerWasDamaged();
				dispatch(new GameEvent(GameEvent.PLAYER_DAMAGE, null));
				_speedX *= -1;
				_speedY *= -1;
			}
		}
	}
}