package game.systems;
import game.components.AngularMovementComponent;
import game.components.BitmapComponent;
import game.components.CatComponent;
import game.components.CatTrackerComponent;
import game.components.CenterPointPositionComponent;
import game.components.DamagebleComponent;
import game.components.GameComponent;
import game.components.PlayerComponent;
import game.events.GameEvent;
import se.salomonsson.ent.EntityEvent;
import se.salomonsson.ent.EW;
import se.salomonsson.ent.GameTime;
import se.salomonsson.ent.Sys;
import se.salomonsson.game.components.CameraComponent;

/**
 * ...
 * @author Tommislav
 */

class UpdateCatTrackersSystem extends Sys
{
	private var _frame:Int;
	
	public function new() { super(); }
	
	override public function onAdded(sm, em):Void 
	{
		super.onAdded(sm, em);
		em.addListener(EntityEvent.ENTITY_DESTROYED, onCatRemoved);
	}
	
	override public function onRemoved():Void 
	{
		super.onRemoved();
		em().removeListener(EntityEvent.ENTITY_DESTROYED, onCatRemoved);
	}
	
	private function onCatRemoved(e:EntityEvent):Void 
	{
		var entityRemoved:Int = e.entity;
		var allTrackers = em().getEWC([CatTrackerComponent]);
		for (tracker in allTrackers) {
			if (tracker.comp(CatTrackerComponent).catToTrack == entityRemoved) {
				removeTracker(tracker);
				return;
			}
		}
	}
	
	override public function tick(gt:GameTime):Void 
	{
		var player = em().getEWC([PlayerComponent]);
		if (player.length == 0)
			return;
		
		
		var playerPos = player[0].comp(CenterPointPositionComponent);
		var camera = em().getComp(CameraComponent);
		var gameComp = em().getComp(GameComponent);
		
		var catTrackerEnt = em().getEWC([CatTrackerComponent]);
		for (tracker in catTrackerEnt) {
			var catId = tracker.comp(CatTrackerComponent).catToTrack;
			
			// If cat is removed, we should also be removed
			var cat = em().getComponentOnEntity(catId, CatComponent);
			var catHealth = em().getComponentOnEntity(catId, DamagebleComponent);
			
			if (cat == null || catHealth.health == 0) {
				removeTracker(tracker);
				continue;
				
			} else {
				
				// Is cat visible in the screen?
				var catPos = em().getComponentOnEntity(catId, CenterPointPositionComponent);
				
				var catVisible = camera.inView(catPos);
				var arrowVisible = !catVisible && gameComp.catRadarEnabled;
				tracker.comp(BitmapComponent).holder.visible = arrowVisible;
				
				if (!arrowVisible)
					continue;
				
				var dx = catPos.x - playerPos.x;
				var dy = catPos.y - playerPos.y;
				var angle = Math.atan2(dy, dx);
				var distFromPlayer = 200;
				
				var trackerPos = tracker.comp(CenterPointPositionComponent);
				trackerPos.x = playerPos.x + (Math.cos(angle) * distFromPlayer);
				trackerPos.y = playerPos.y + (Math.sin(angle) * distFromPlayer);
				
				tracker.comp(AngularMovementComponent).setRadians(angle);
			}
		}
	}
	
	private function removeTracker(e:EW) {
		e.comp(BitmapComponent).remove();
		e.destroy();
	}
	
}