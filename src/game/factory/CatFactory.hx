package game.factory;
import game.components.BitmapComponent;
import game.components.CatComponent;
import game.components.CenterPointPositionComponent;
import game.components.DamagebleComponent;
import game.components.GameComponent;
import game.components.PlayerComponent;
import game.components.XYSpeedComponent;
import game.enums.TileId;
import game.events.CreateCatEvent;
import game.utils.TileMap;
import se.salomonsson.ent.EntManager;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class CatFactory extends Sys
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
		addListener(CreateCatEvent.SPAWN, onSpawnNewCat);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		removeListener(CreateCatEvent.SPAWN, onSpawnNewCat);
	}
	
	private function onSpawnNewCat(e:CreateCatEvent):Void 
	{
		em().getComp(GameComponent).catsTotal += 1;
		
		var catSpeed = 2;
		var dx = e.fromX - e.toX;
		var dy = e.fromY - e.toY;
		var angle = Math.atan2(dy, dx);
		var sx = Math.cos(angle) * catSpeed;
		var sy = Math.sin(angle) * catSpeed;
		
		
		em().allocateEntity()
			.addComponent(CenterPointPositionComponent.build(e.fromX, e.fromY, 40))
			.addComponent(BitmapComponent.build(_tileMap.getTile(TileId.CAT_0)))
			.addComponent(XYSpeedComponent.build(sx, sy))
			.addComponent(new CatComponent())
			.addComponent(new DamagebleComponent());
	}
	
}