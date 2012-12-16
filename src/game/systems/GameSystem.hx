package game.systems;
import game.components.GameComponent;
import game.enums.EnemyType;
import game.events.CreateCatEvent;
import game.events.CreateEnemyEvent;
import game.events.GameEvent;
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
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		addListener(GameEvent.CAT_CREATED, onCatCreated);
	}
	override public function onRemoved():Void 
	{
		super.onRemoved();
		removeListener(GameEvent.CAT_CREATED, onCatCreated);
	}
	
	
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
		var levelBounds = em().getComp(GameComponent).levelBounds;
		
		var fromX = Math.random() * levelBounds.width;
		var fromY = Math.random() * levelBounds.height;
		var toX = Math.random() * levelBounds.width;
		var toY = Math.random() * levelBounds.height;
		
		dispatch(new CreateCatEvent(CreateCatEvent.SPAWN, fromX, fromY, toX, toY));
	}
	
	
	
	
	private function onCatCreated(e:GameEvent):Void 
	{
		var kittenId:Int = e.data;
		for (i in 0...4) {
			dispatch(new CreateEnemyEvent(CreateEnemyEvent.SPAWN, EnemyType.RANDOM, kittenId, i));
		}
	}
}