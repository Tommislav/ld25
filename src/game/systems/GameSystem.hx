package game.systems;
import game.events.CreateCatEvent;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class GameSystem extends Sys
{
	private var _spawnKittenTimer:Int;
	
	
	
	public function new() { super(); }
	
	override public function tick(gt:GameTime):Void 
	{
		if (_spawnKittenTimer <= 0) {
			spawnNewKitten();
			_spawnKittenTimer = Std.int(100 + Math.random() * 400);
		}
		
		_spawnKittenTimer--;
	}
	
	private function spawnNewKitten() 
	{
		trace("SPAWN KITTEN!");
		var fromX = Math.random() * 500;
		var fromY = Math.random() * 500;
		var toX = Math.random() * 500;
		var toY = Math.random() * 500;
		
		dispatch(new CreateCatEvent(CreateCatEvent.SPAWN, fromX, fromY, toX, toY));
	}
}