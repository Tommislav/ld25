package game.systems;
import game.components.BitmapComponent;
import game.components.CatComponent;
import game.components.CenterPointPositionComponent;
import game.components.DamagebleComponent;
import game.components.GameComponent;
import game.components.PlayerComponent;
import game.events.CreateTextEvent;
import game.events.GameEvent;
import game.utils.TileMap;
import se.salomonsson.ent.EW;
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
		var gameComponent = em().getComp(GameComponent);
		var player = em().getEWC([PlayerComponent])[0];
		var playerPos = player.comp(CenterPointPositionComponent);
		
		var allCatEntities = em().getEWC([CatComponent]);
		for (catEntity in allCatEntities) {
			var catPos = catEntity.comp(CenterPointPositionComponent);
			if (catPos.intersects(playerPos)) {
				// kidnapped by player!
				gameComponent.score += 1;
				gameComponent.money += catEntity.comp(CatComponent).value;
				
				dispatch(new CreateTextEvent(CreateTextEvent.CAT_KIDNAPPED, catPos.x, catPos.y));
				removeCat(catEntity);
				
			} else {
				var health = catEntity.comp(DamagebleComponent).health;
				if (health == 0) { // are we dead?
					dispatch(new CreateTextEvent(CreateTextEvent.CAT_KILLED, catPos.x, catPos.y));
					removeCat(catEntity);
				} else {
					
					// has cat left level bounds?
					var insideLevelBounds = gameComponent.levelBounds.contains(catPos.x, catPos.y);
					if (!insideLevelBounds) {
						removeCat(catEntity);
					}
					
				}
			}
		}
	}
	
	private function removeCat(cat:EW) {
		dispatch(new GameEvent(GameEvent.CAT_REMOVED, cat.getEntity()));
		cat.comp(BitmapComponent).remove();
		em().destroyEntity(cat.getEntity());
	}
	
}