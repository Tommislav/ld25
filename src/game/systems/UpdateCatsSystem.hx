package game.systems;
import game.components.BitmapComponent;
import game.components.CatComponent;
import game.components.CenterPointPositionComponent;
import game.components.DamagebleComponent;
import game.components.GameComponent;
import game.components.PlayerComponent;
import game.events.CreateTextEvent;
import game.utils.TileMap;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;

/**
 * ...
 * @author Tommislav
 */

class UpdateCatsSystem extends Sys
{
	private var _tileMap:TileMap;

	public function new(tileMap:TileMap) 
	{
		_tileMap = tileMap;
		super();
	}
	
	override public function tick(gt:GameTime):Void 
	{
		var player = em().getEWC([PlayerComponent])[0];
		var playerPos = player.comp(CenterPointPositionComponent);
		
		var allCatEntities = em().getEWC([CatComponent]);
		for (catEntity in allCatEntities) {
			var catPos = catEntity.comp(CenterPointPositionComponent);
			if (catPos.intersects(playerPos)) {
				// catched a cat!
				var gameComponent = em().getComp(GameComponent);
				gameComponent.score += 1;
				gameComponent.money += 100;
				trace("Catched a cat! Score: " + gameComponent.score);
				
				catEntity.comp(BitmapComponent).remove();
				em().destroyEntity(catEntity.getEntity());
				
				dispatch(new CreateTextEvent(CreateTextEvent.CAT_KIDNAPPED, catPos.x, catPos.y));
			}else {
				var health = catEntity.comp(DamagebleComponent).health;
				if (health == 0)
					dispatch(new CreateTextEvent(CreateTextEvent.CAT_KILLED, catPos.x, catPos.y));
			}
		}
	}
}