package game.factory;
import se.salomonsson.ent.EntManager;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class EnemyFactory extends Sys
{
	private var _em:EntManager;
	
	public function new(em:EntManager) 
	{
		super();
		_em = em;
	}
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
	}
	
	override public function onRemoved():Dynamic 
	{
		super.onRemoved();
	}
	
	override public function tick(gt:GameTime):Void 
	{
		super.tick(gt);
	}
}