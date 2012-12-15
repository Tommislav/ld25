package game.factory;
import game.components.BitmapComponent;
import game.components.CenterPointPositionComponent;
import game.components.LifeCountDownComponent;
import game.components.XYSpeedComponent;
import game.enums.TileId;
import game.events.CreateTextEvent;
import game.utils.TileMap;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class TextFactory extends Sys
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
		addListener(CreateTextEvent.CAT_KIDNAPPED, onCatKidnapped);
		addListener(CreateTextEvent.CAT_KILLED, onCatKilled);
	}
	
	
	
	
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		removeListener(CreateTextEvent.CAT_KIDNAPPED, onCatKidnapped);
		removeListener(CreateTextEvent.CAT_KILLED, onCatKilled);
	}
	
	
	private function onCatKidnapped(e:CreateTextEvent):Void 
	{
		spawnText(TileId.TEXT_CAT_KIDNAPPED, e.x, e.y);
	}
	
	private function onCatKilled(e:CreateTextEvent):Void 
	{
		spawnText(TileId.TEXT_CAT_KILLED, e.x, e.y);
	}
	
	private function spawnText(tileId:Int, x:Float, y:Float) {
		em().allocateEntity()
			.addComponent(CenterPointPositionComponent.build(x, y, 32))
			.addComponent(BitmapComponent.build(_tileMap.getTile(tileId)))
			.addComponent(XYSpeedComponent.build(0, -0.5))
			.addComponent(new LifeCountDownComponent());
	}
}